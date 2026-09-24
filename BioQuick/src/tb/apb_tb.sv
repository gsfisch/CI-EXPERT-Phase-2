 
`timescale 1ns / 1ps

module apb_tb;

    // Parâmetros
    parameter ADDR_WIDTH = 12;
    parameter DATA_WIDTH = 16;

    // Sinais
    logic                  PCLK;
    logic                  PRESETN;
    logic                  i_PWRITE;
    logic [ADDR_WIDTH-1:0] i_PADDR;
    logic [DATA_WIDTH-1:0] i_PWDATA;
    logic                  i_transfer;
    logic [DATA_WIDTH-1:0] o_PRDATA;
    logic                  o_PSLVERR;

    // Instanciação do DUT
    apb #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) dut (
        .PCLK(PCLK),
        .PRESETN(PRESETN),
        .i_PWRITE(i_PWRITE),
        .i_PADDR(i_PADDR),
        .i_PWDATA(i_PWDATA),
        .i_PSSTRB(2'b00), // Não usado
        .i_transfer(i_transfer),
        .o_PRDATA(o_PRDATA),
        .o_PSLVERR(o_PSLVERR)
    );

    // Geração de clock
    initial begin
        PCLK = 0;
        forever #5 PCLK = ~PCLK; // Período de 10ns
    end

    // Geração de reset
    initial begin
        PRESETN = 0;
        #20 PRESETN = 1;
    end

    // Estímulos direcionados
    initial begin
        // Inicialização
        i_PWRITE = 0;
        i_PADDR = 0;
        i_PWDATA = 0;
        i_transfer = 0;

        @(posedge PRESETN);
        #10;

        $display("Iniciando testes direcionados...");
        #10;
        // Teste 1: 5 Escritas Individuais
        $display("Realizando 5 escritas individuais...");
        // Escrita 1
        i_PADDR = 1;
        i_PWDATA = 16'h0001;
        i_PWRITE = 1;
        i_transfer = 1;
        #10;
//        i_transfer = 0;
        #20;

        // Escrita 2
        i_PADDR = 2;
        i_PWDATA = 16'h0002;
        i_PWRITE = 1;
        i_transfer = 1;
        #10;
//        i_transfer = 0;
        #20;

        // Escrita 3
        i_PADDR = 3;
        i_PWDATA = 16'h0003;
        i_PWRITE = 1;
        i_transfer = 1;
        #10;
        i_transfer = 0;
        #20;

        // Escrita 4
        i_PADDR = 4;
        i_PWDATA = 16'h0004;
        i_PWRITE = 1;
        i_transfer = 1;
        #10;
        i_transfer = 0;
        #20;

        // Escrita 5
        i_PADDR = 5;
        i_PWDATA = 16'h0005;
        i_PWRITE = 1;
        i_transfer = 1;
        #10
        i_transfer = 0;
        #50; // Espaço maior entre grupos de testes

        // Teste 2: 5 Leituras Individuais
        $display("Realizando 5 leituras individuais...");
        // Leitura 1
        i_PADDR = 1;
        i_PWRITE = 0;
        i_transfer = 1;
        #10;
        $display("Leitura em addr 0: PRDATA = %h", o_PRDATA);
        i_transfer = 0;
        #20;

        // Leitura 2
        i_PADDR = 2;
        i_PWRITE = 0;
        i_transfer = 1;
        #10;
        $display("Leitura em addr 1: PRDATA = %h", o_PRDATA);
        i_transfer = 0;
        #20;

        // Leitura 3
        i_PADDR = 3;
        i_PWRITE = 0;
        i_transfer = 1;
        #10;
        $display("Leitura em addr 2: PRDATA = %h", o_PRDATA);
        i_transfer = 0;
        #20;

        // Leitura 4
        i_PADDR = 4;
        i_PWRITE = 0;
        i_transfer = 1;
        #10;
        $display("Leitura em addr 3: PRDATA = %h", o_PRDATA);
        i_transfer = 0;
        #20;

        // Leitura 5
        i_PADDR = 5;
        i_PWRITE = 0;
        i_transfer = 1;
        #10;
        $display("Leitura em addr 4: PRDATA = %h", o_PRDATA);
        i_transfer = 0;
        #20

        $display("Testes concluídos!");
        $finish;
    end

endmodule
