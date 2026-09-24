`timescale 1ns / 1ps

module apbmaster_tb;

    // Sinais de entrada
    logic PCLK;
    logic PRESETN;
    logic PWRITE;
    logic [11:0] PADDR;
    logic [15:0] PWDATA;
    logic [1:0] PSSTRB;
    logic transfer;
    logic [15:0] i_PRDATA;
    logic i_PREADY;
    logic i_PSLVERR;

    // Sinais de saída
    logic [11:0] o_PADDR;
    logic [15:0] o_PWDATA;
    logic o_PWRITE;
    logic o_PENABLE;
    logic o_PSEL;

    // Instanciação do módulo sob teste
    apbmaster dut (
        .PCLK(PCLK),
        .PRESETN(PRESETN),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PSSTRB(PSSTRB),
        .transfer(transfer),
        .i_PRDATA(i_PRDATA),
        .i_PREADY(i_PREADY),
        .i_PSLVERR(i_PSLVERR),
        .o_PADDR(o_PADDR),
        .o_PWDATA(o_PWDATA),
        .o_PWRITE(o_PWRITE),
        .o_PENABLE(o_PENABLE),
        .o_PSEL(o_PSEL)
    );

    // Geração do clock (100 MHz, período de 10 ns)
    initial begin
        PCLK = 0;
        forever #5 PCLK = ~PCLK;
    end

    // Propriedades Formais
    property reset_property;
        @(posedge PCLK) disable iff (PRESETN)
        (dut.state == dut.IDLE && o_PSEL == 0 && o_PENABLE == 0 && o_PADDR == 0 && o_PWRITE == 0 && o_PWDATA == 0);
    endproperty
    assert property (reset_property) else $error("Erro: Após reset, estado ou saídas incorretas");

    property idle_to_setup_property;
        @(posedge PCLK) disable iff (!PRESETN)
        (dut.state == dut.IDLE && transfer) |=> (dut.state == dut.SETUP);
    endproperty
    assert property (idle_to_setup_property) else $error("Erro: Não transitou de IDLE para SETUP com transfer alto");

    property setup_to_access_property;
        @(posedge PCLK) disable iff (!PRESETN)
        (dut.state == dut.SETUP) |=> (dut.state == dut.ACCESS);
    endproperty
    assert property (setup_to_access_property) else $error("Erro: Não transitou de SETUP para ACCESS");

    property access_to_setup_property;
        @(posedge PCLK) disable iff (!PRESETN)
        (dut.state == dut.ACCESS && i_PREADY && transfer) |=> dut.state == dut.SETUP;
    endproperty
    assert property (access_to_setup_property) else $error("Erro: Não transitou de ACCESS para SETUP corretamente");
    
    property access_to_idle_property;
        @(posedge PCLK) disable iff (!PRESETN)
        (dut.state == dut.ACCESS && i_PREADY && !transfer) |=> dut.state == dut.IDLE;
    endproperty
    assert property (access_to_idle_property) else $error("Erro: Não transitou de ACCESS para IDLE corretamente");


    property access_wait_property;
        @(posedge PCLK) disable iff (!PRESETN)
        (dut.state == dut.ACCESS && !i_PREADY) |=> (dut.state == dut.ACCESS);
    endproperty
    assert property (access_wait_property) else $error("Erro: Não permaneceu em ACCESS com i_PREADY baixo");

    property idle_outputs_property;
        @(posedge PCLK) disable iff (!PRESETN)
        (dut.state == dut.IDLE) |=> (o_PSEL == 0 && o_PENABLE == 0 && o_PADDR == 0 && o_PWRITE == 0 && o_PWDATA == 0);
    endproperty
    assert property (idle_outputs_property) else $error("Erro: Saídas incorretas em IDLE");

    property setup_outputs_property;
        @(posedge PCLK) disable iff (!PRESETN)
        (dut.state == dut.SETUP) |=> (o_PSEL == 1 && o_PENABLE == 0 && o_PADDR == dut.addr_reg && o_PWRITE == dut.write_reg && o_PWDATA == dut.wdata_reg);
    endproperty
    assert property (setup_outputs_property) else $error("Erro: Saídas incorretas em SETUP");

    property access_outputs_property_notransfer;
        @(posedge PCLK) disable iff (!PRESETN || transfer || i_PREADY)
        (dut.state == dut.ACCESS) |=> (o_PSEL == 1 && o_PENABLE == 1 && o_PADDR == dut.addr_reg && o_PWRITE == dut.write_reg && o_PWDATA == dut.wdata_reg);
    endproperty
    assert property (access_outputs_property_notransfer) else $error("Erro: Saídas incorretas em ACCESS quando transfer baixo");

    property access_outputs_property_transfer;
        @(posedge PCLK) disable iff (!PRESETN || !transfer || !i_PREADY)
        (dut.state == dut.ACCESS) |=> (o_PSEL == 1 && o_PENABLE == 1);
    endproperty
    assert property (access_outputs_property_transfer) else $error("Erro: Saídas incorretas em ACCESS quando transfer alto");

    property capture_inputs_property;
        @(posedge PCLK) disable iff (!PRESETN)
        (dut.state == dut.IDLE && transfer) |=> (dut.addr_reg == $past(PADDR) && dut.write_reg == $past(PWRITE) && dut.wdata_reg == $past(PWDATA));
    endproperty
    assert property (capture_inputs_property) else $error("Erro: Não capturou corretamente os sinais de entrada em IDLE com transfer");

    // Covergroup para cobertura de estados
    covergroup state_coverage @(posedge PCLK);
        coverpoint dut.state {
            bins IDLE = {dut.IDLE};
            bins SETUP = {dut.SETUP};
            bins ACCESS = {dut.ACCESS};
        }
    endgroup

    // Covergroup para cobertura de transições
    covergroup transition_coverage @(posedge PCLK);
        coverpoint dut.state {
            bins IDLE_to_SETUP = (dut.IDLE => dut.SETUP);
            bins SETUP_to_ACCESS = (dut.SETUP => dut.ACCESS);
            bins ACCESS_to_IDLE = (dut.ACCESS => dut.IDLE);
            bins ACCESS_to_SETUP = (dut.ACCESS => dut.SETUP);
            bins ACCESS_to_ACCESS = (dut.ACCESS => dut.ACCESS);
        }
    endgroup

    // Covergroup para cobertura de sinais
    covergroup signal_coverage @(posedge PCLK);
        coverpoint o_PSEL {
            bins LOW = {0};
            bins HIGH = {1};
        }
        coverpoint o_PENABLE {
            bins LOW = {0};
            bins HIGH = {1};
        }
        coverpoint o_PWRITE {
            bins READ = {0};
            bins WRITE = {1};
        }
        coverpoint i_PREADY {
            bins LOW = {0};
            bins HIGH = {1};
        }
        coverpoint transfer {
            bins LOW = {0};
            bins HIGH = {1};
        }
    endgroup

    // Instanciação dos covergroups
    state_coverage state_cov = new();
    transition_coverage transition_cov = new();
    signal_coverage signal_cov = new();

    // Classe para geração de estímulos aleatórios
    class Stimulus;
        rand bit transfer;
        rand bit PWRITE;
        rand logic [11:0] PADDR;
        rand logic [15:0] PWDATA;
        rand bit i_PREADY;

        // Constraints para cenários realistas
        constraint addr_range { PADDR inside {[12'h000:12'hFFF]}; }
        constraint write_data { PWDATA inside {[16'h0000:16'hFFFF]}; }
        constraint transfer_dist { transfer dist {0 := 30, 1 := 70}; } // Mais transações ativas
        constraint pready_dist { i_PREADY dist {0 := 20, 1 := 80}; }  // Mais respostas rápidas
    endclass

    // Procedimento de teste automatizado
    initial begin
        Stimulus stim = new();
        int cycles = 1000; // Número de ciclos de teste para garantir cobertura

        // Inicialização
        PRESETN = 0;
        transfer = 0;
        PWRITE = 0;
        PADDR = 12'h000;
        PWDATA = 16'h0000;
        i_PREADY = 0;
        i_PSLVERR = 0;
        PSSTRB = 2'b00;
        #10;
        PRESETN = 1;
        #10;

        // Teste aleatório com cobertura
        repeat (cycles) begin
            assert(stim.randomize()) else $fatal("Falha na randomização");
            transfer = stim.transfer;
            PWRITE = stim.PWRITE;
            PADDR = stim.PADDR;
            PWDATA = stim.PWDATA;
            i_PREADY = stim.i_PREADY;
            #10; // Espera um ciclo de clock
        end

        // Verificar resultados
        $display("\n### Testes Concluídos ###");
        $display("Cobertura de estados alcançada: %0d%%", state_cov.get_coverage());
        $display("Cobertura de transições alcançada: %0d%%", transition_cov.get_coverage());
        $display("Cobertura de sinais alcançada: %0d%%", signal_cov.get_coverage());

        if (state_cov.get_coverage() == 100 && transition_cov.get_coverage() == 100 && signal_cov.get_coverage() == 100)
            $display("Teste bem-sucedido com 100% de cobertura!");
        else
            $display("Teste falhou ou cobertura incompleta.");
        
        $finish;
    end

    // Monitoramento dos estados e saídas (opcional, para depuração)
    always @(posedge PCLK) begin
        $display("Tempo: %0t | Estado: %s | transfer: %b | i_PREADY: %b | o_PSEL: %b | o_PENABLE: %b | o_PADDR: %h | o_PWRITE: %b | o_PWDATA: %h",
                 $time, dut.state.name(), transfer, i_PREADY, o_PSEL, o_PENABLE, o_PADDR, o_PWRITE, o_PWDATA);
    end

endmodule