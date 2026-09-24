 
module apbmaster #(
    parameter ADDR_WIDTH = 12,    // Largura do endereço
    parameter DATA_WIDTH = 16     // Largura dos dados
) (
    input  logic                  PCLK,          // Clock
    input  logic                  PRESETN,       // Active-low reset
    input  logic                  PWRITE,        // Write control (1=write, 0=read)
    input  logic [ADDR_WIDTH-1:0] PADDR,         // 12-bit address
    input  logic [DATA_WIDTH-1:0] PWDATA,        // 16-bit write data
    input  logic [1:0]            PSSTRB,        // 2-bit strobe (not used in this implementation)
    input  logic                  transfer,      // Transfer initiation signal
    input  logic [DATA_WIDTH-1:0] i_PRDATA,      // 16-bit read data from slave
    input  logic                  i_PREADY,      // Ready signal from slave
    input  logic                  i_PSLVERR,     // Error signal from slave
    output logic [ADDR_WIDTH-1:0] o_PADDR,       // Output address to slave
    output logic [DATA_WIDTH-1:0] o_PWDATA,      // Output write data to slave
    output logic                  o_PWRITE,      // Output write control to slave
    output logic                  o_PENABLE,     // Enable signal to slave
    output logic                  o_PSEL,        // Select signal to slave
    output logic [DATA_WIDTH-1:0] o_PRDATA       // Output read data
);

    // Definição dos estados da FSM
    typedef enum logic [1:0] {
        IDLE,
        SETUP,
        ACCESS
    } state_t;

    state_t state, next_state;
    logic [DATA_WIDTH-1:0] rdata_reg;

    // Lógica combinacional para PSEL e PENABLE
    always_comb begin
        if (!PRESETN) begin
            o_PSEL    = 1'b0;
            o_PENABLE = 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    o_PSEL    = 1'b0;
                    o_PENABLE = 1'b0;
                end
                SETUP: begin
                    o_PSEL    = 1'b1;
                    o_PENABLE = 1'b0;
                end
                ACCESS: begin
                    o_PSEL    = 1'b1;
                    o_PENABLE = 1'b1;
                end
                default: begin
                    o_PSEL    = 1'b0;
                    o_PENABLE = 1'b0;
                end
            endcase
        end
    end

    // Lógica combinacional para next_state
    always_comb begin
        case (state)
            IDLE: begin
                if (transfer) next_state = SETUP;
            end

            SETUP: begin
                next_state = ACCESS;
            end

            ACCESS: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Atualização síncrona do estado
    always_ff @(posedge PCLK or negedge PRESETN) begin
        if (!PRESETN) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Lógica para leitura
    always_comb begin
        if (!PRESETN) begin
            o_PRDATA <= 0;
        end else begin
            case (state)
                IDLE: begin
                   o_PRDATA <= 0;
                end
                SETUP: begin
                   o_PRDATA <= 0;
                end
                ACCESS: begin
                    if (i_PREADY && !o_PWRITE) begin
                        o_PRDATA <= i_PRDATA;
                    end
                end
                default: begin
                    o_PRDATA <= 0;
                end
            endcase
        end
    end

    //lógica para saidas
    always_comb begin
        if (!PRESETN) begin
                o_PADDR   <= 12'b0;
                o_PWRITE  <= 1'b0;
                o_PWDATA  <= 16'b0;
        end else begin
            case(state)
                IDLE: begin
                    o_PADDR   <= 12'b0;
                    o_PWRITE  <= 1'b0;
                    o_PWDATA  <= 16'b0;
                end

                SETUP:begin
                    o_PADDR   <= PADDR;
                    o_PWRITE  <= PWRITE;
                    o_PWDATA  <= PWDATA;
                end

                ACCESS:begin
                    o_PADDR   <= PADDR;
                    o_PWRITE  <= PWRITE;
                    o_PWDATA  <= PWDATA;
                end

                default: begin
                    o_PADDR   <= 12'b0;
                    o_PWRITE  <= 1'b0;
                    o_PWDATA  <= 16'b0;
                end
            endcase
        end
    end

endmodule
