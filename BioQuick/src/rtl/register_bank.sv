module register_bank #(
    parameter ADDR_WIDTH = 12,        // Número de registradores
    parameter DATA_WIDTH = 16        // Largura de cada registrador (em bits)
) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic [ADDR_WIDTH-1:0] i_addr,
    input  logic [DATA_WIDTH-1:0] i_write_data,
    input  logic                  i_write_en,
    input  logic                  i_read_en,
    output logic [DATA_WIDTH-1:0] o_read_data,
    output logic                  o_done,
    output logic                  o_error
);

    // Definição da constante para o tamanho máximo do endereço
    localparam ADDR_MAX_POS = {ADDR_WIDTH{1'b1}};  // 4095 para ADDR_WIDTH=12
    logic valid_address;
    // Declaração da memória como array de registradores
    logic [DATA_WIDTH-1:0] reg_bank [0:ADDR_MAX_POS];


    // Lógica sequencial para escrita
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_done <= 0;
            for (int i = 0; i <= ADDR_MAX_POS; i++) begin
                reg_bank[i] <= 0;
            end
        end else if (i_write_en && valid_address) begin
            reg_bank[i_addr] <= i_write_data;
            o_done <= 1;
        end else if(i_read_en && valid_address)begin
            o_done <= 1;
        end
        else begin
          o_done <= 0;
        end
    end

    assign valid_address = (i_addr <= ADDR_MAX_POS) ? 1 : 0;
    assign o_error = !valid_address || (!rst_n && (i_write_en || i_read_en));

    // Lógica combinacional para leitura
    always_comb begin
        if (i_read_en && valid_address) begin
            o_read_data = reg_bank[i_addr];
        end else begin
            o_read_data = 0;  // Valor padrão para endereços inválidos ou sem leitura
        end
    end

endmodule
