 
module apb_slave_memory #(
    parameter ADDR_WIDTH = 12,    // Largura do endereço
    parameter DATA_WIDTH = 16     // Largura dos dados
) (
    // Sinais APB
    input  logic                  PCLK,
    input  logic                  PRESETN,
    input  logic                  i_PSEL,
    input  logic                  i_PENABLE,
    input  logic                  i_PWRITE,
    input  logic [ADDR_WIDTH-1:0] i_PADDR,
    input  logic [DATA_WIDTH-1:0] i_PWDATA,
    output logic [DATA_WIDTH-1:0] o_PRDATA,
    output logic                  o_PREADY,
    output logic                  o_PSLVERR
);

    typedef enum logic [1:0] {
        IDLE,
        ACCESS,
        DONE
    } state_t;

    // Sinais internos
    logic [ADDR_WIDTH-1:0] addr_reg;
    logic [DATA_WIDTH-1:0] write_data_reg;
    logic write_en;
    logic read_en;
    logic [DATA_WIDTH-1:0] read_data_reg;
    logic mem_done;
    logic mem_error;
    state_t state = IDLE;
    state_t next_state;

    // Instanciação do reg bank
    register_bank #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) reg_bank (
        .clk(PCLK),
        .rst_n(PRESETN),
        .i_addr(addr_reg),
        .i_write_data(write_data_reg),
        .i_write_en(write_en),
        .i_read_en(read_en),
        .o_read_data(read_data_reg),
        .o_done(mem_done),
        .o_error(mem_error)
    );

    // Processo 1: Lógica combinacional para determinar o próximo estado
    always_comb begin
        case (state)
            IDLE: begin
                if (i_PSEL && !i_PENABLE) begin
                    next_state = ACCESS;
                end else begin
                    next_state = IDLE;
                end
            end
            ACCESS: begin
                if (i_PENABLE) begin
                    next_state = DONE;
                end else begin
                    next_state = ACCESS; // aguarda o penable
                end
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Processo 2: Atualização síncrona do estado e registradores
    always_ff @(posedge PCLK or negedge PRESETN) begin
        if (!PRESETN) begin
            addr_reg <= 0;
            write_data_reg <= 0;
            write_en <= 0;
            read_en <= 0;
            state <= IDLE;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    if (i_PSEL && !i_PENABLE) begin
                        addr_reg <= i_PADDR;
                        write_data_reg <= i_PWDATA;
                        write_en <= i_PWRITE;
                        read_en <= !i_PWRITE;
                    end
                end
                ACCESS: begin

                end
                DONE: begin
                    write_en <= 0;
                    read_en <= 0;
                end
            endcase
        end
    end

    // Lógica combinacional para saídas
    always_comb begin
        if (!PRESETN) begin
            o_PRDATA = 0;
            o_PREADY = 0;
            o_PSLVERR = 0;
        end else begin
            o_PSLVERR = mem_error;
            case (state)
                IDLE: begin
                    o_PREADY = 0;
                    o_PRDATA = 0;
                end
                ACCESS: begin
                    o_PREADY = 1;
                    o_PRDATA = read_en? read_data_reg : 0;
                end
                DONE: begin
                    o_PRDATA = 0;
                    o_PREADY = 0;
                end
                default: begin
                    o_PREADY = 0;
                    o_PRDATA = 0;
                end
            endcase
        end
    end

endmodule
