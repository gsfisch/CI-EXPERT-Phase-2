`timescale 1ns / 1ps

module Addresser_tb;

    // Sinais de entrada
    logic clk;
    logic reset;
    logic i_ss;
    logic i_ready;
    logic [15:0] i_data;
    logic i_PREADY;

    // Sinais de saída
    logic o_rw;
    logic [11:0] o_addr;
    logic [15:0] o_data;
    logic o_Transfer;

    // Instanciação do módulo sob teste
    Addresser dut (
        .clk(clk),
        .reset(reset),
        .i_ss(i_ss),
        .i_ready(i_ready),
        .i_data(i_data),
        .i_PREADY(i_PREADY),
        .o_rw(o_rw),
        .o_addr(o_addr),
        .o_data(o_data),
        .o_Transfer(o_Transfer)
    );

    // Geração do clock (100 MHz, período de 10 ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Propriedades Formais
    property reset_property;
        @(posedge clk) disable iff (reset)
        (dut.state == dut.IDLE && o_Transfer == 0 && o_rw == 0 && o_addr == 0 && o_data == 0);
    endproperty
    assert property (reset_property) else $error("Erro: Após reset, estado ou saídas incorretas");

    property start_operation_property;
        @(posedge clk) disable iff (!reset)
        (i_ss && dut.state == dut.IDLE) |=> (dut.state == dut.WAIT_OP_PACKET);
    endproperty
    assert property (start_operation_property) else $error("Erro: Não transitou de IDLE para WAIT_OP_PACKET");

    property receive_op_packet_property;
        @(posedge clk) disable iff (!reset || !i_ss)
        (dut.state == dut.WAIT_OP_PACKET && i_ready) |=> (dut.state == dut.DECODE_OP);
    endproperty
    assert property (receive_op_packet_property) else $error("Erro: Não transitou de WAIT_OP_PACKET para DECODE_OP");

    property decode_read_property;
        @(posedge clk) disable iff (!reset || !i_ss)
        (dut.state == dut.DECODE_OP && !dut.op_type) |=> (dut.state == dut.READ_SETUP);
    endproperty
    assert property (decode_read_property) else $error("Erro: Não transitou de DECODE_OP para READ_SETUP");

    property decode_write_property;
        @(posedge clk) disable iff (!reset || !i_ss)
        (dut.state == dut.DECODE_OP && dut.op_type) |=> (dut.state == dut.WRITE_WAIT_DATA);
    endproperty
    assert property (decode_write_property) else $error("Erro: Não transitou de DECODE_OP para WRITE_WAIT_DATA");

    property read_setup_property;
        @(posedge clk) disable iff (!reset || !i_ss)
        (dut.state == dut.READ_SETUP) |=> (o_rw == 1 && o_Transfer == 1 && o_addr == dut.addr_reg && dut.state == dut.READ_WAIT_PREADY);
    endproperty
    assert property (read_setup_property) else $error("Erro: Saídas incorretas ou não transitou para READ_WAIT_PREADY");

    property read_wait_pready_property;
        @(posedge clk) disable iff (!reset || !i_ss)
        (dut.state == dut.READ_WAIT_PREADY && i_PREADY) |=> dut.state == dut.READ_SETUP;
    endproperty
    assert property (read_wait_pready_property) else $error("Erro: Comportamento incorreto em READ_WAIT_PREADY");

    property write_wait_data_property;
        @(posedge clk) disable iff (!reset || !i_ss)
        (dut.state == dut.WRITE_WAIT_DATA && i_ready) |=> (dut.state == dut.WRITE_SETUP);
    endproperty
    assert property (write_wait_data_property) else $error("Erro: Não transitou de WRITE_WAIT_DATA para WRITE_SETUP");

    property write_setup_property;
        @(posedge clk) disable iff (!reset || !i_ss)
        (dut.state == dut.WRITE_SETUP) |=> (o_rw == 0 && o_Transfer == 1 && o_addr == dut.addr_reg && o_data == dut.data_reg);
    endproperty
    assert property (write_setup_property) else $error("Erro: Saídas incorretas em WRITE_SETUP");

    property write_wait_pready_property;
        @(posedge clk) disable iff (!reset || !i_ss)
        (dut.state == dut.WRITE_WAIT_PREADY && i_PREADY) |=>  dut.state == dut.WRITE_WAIT_DATA;
    endproperty
    assert property (write_wait_pready_property) else $error("Erro: Comportamento incorreto em WRITE_WAIT_PREADY");

    property interruption_property;
        @(posedge clk) disable iff (!reset)
        (!i_ss) |=> (dut.state == dut.IDLE);
    endproperty
    assert property (interruption_property) else $error("Erro: Não retornou a IDLE quando i_ss é baixo");

    // Covergroup para cobertura de estados
    covergroup state_coverage @(posedge clk);
        coverpoint dut.state {
            bins IDLE = {dut.IDLE};
            bins WAIT_OP_PACKET = {dut.WAIT_OP_PACKET};
            bins DECODE_OP = {dut.DECODE_OP};
            bins READ_SETUP = {dut.READ_SETUP};
            bins READ_WAIT_PREADY = {dut.READ_WAIT_PREADY};
            bins WRITE_WAIT_DATA = {dut.WRITE_WAIT_DATA};
            bins WRITE_SETUP = {dut.WRITE_SETUP};
            bins WRITE_WAIT_PREADY = {dut.WRITE_WAIT_PREADY};
        }
    endgroup

    // Covergroup para cobertura de transições
    covergroup transition_coverage @(posedge clk);
        coverpoint dut.state {
            bins IDLE_to_WAIT_OP_PACKET = (dut.IDLE => dut.WAIT_OP_PACKET);
            bins WAIT_OP_PACKET_to_DECODE_OP = (dut.WAIT_OP_PACKET => dut.DECODE_OP);
            bins DECODE_OP_to_READ_SETUP = (dut.DECODE_OP => dut.READ_SETUP);
            bins DECODE_OP_to_WRITE_WAIT_DATA = (dut.DECODE_OP => dut.WRITE_WAIT_DATA);
            bins READ_SETUP_to_READ_WAIT_PREADY = (dut.READ_SETUP => dut.READ_WAIT_PREADY);
            bins READ_WAIT_PREADY_to_READ_SETUP = (dut.READ_WAIT_PREADY => dut.READ_SETUP);
            bins READ_WAIT_PREADY_to_IDLE = (dut.READ_WAIT_PREADY => dut.IDLE);
            bins WRITE_WAIT_DATA_to_WRITE_SETUP = (dut.WRITE_WAIT_DATA => dut.WRITE_SETUP);
            bins WRITE_SETUP_to_WRITE_WAIT_PREADY = (dut.WRITE_SETUP => dut.WRITE_WAIT_PREADY);
            bins WRITE_WAIT_PREADY_to_WRITE_WAIT_DATA = (dut.WRITE_WAIT_PREADY => dut.WRITE_WAIT_DATA);
            bins WRITE_WAIT_PREADY_to_IDLE = (dut.WRITE_WAIT_PREADY => dut.IDLE);
        }
    endgroup

    // Instanciação dos covergroups
    state_coverage state_cov = new();
    transition_coverage transition_cov = new();

    // Classe para geração de estímulos aleatórios
    class Stimulus;
        rand bit i_ss;
        rand bit i_ready;
        rand bit i_PREADY;
        rand logic [15:0] i_data;

        // Constraints para cenários realistas
        constraint valid_data { i_data[15] dist {0 := 50, 1 := 50}; } // 50% leitura, 50% escrita
        constraint addr_range { i_data[11:0] inside {[12'h000:12'hFFF]}; } // Endereços válidos
        constraint control_signals {i_ready + i_PREADY <= 2; } // Evita ativação simultânea desnecessária
        constraint i_ss_porcentage {i_ss dist{0 := 30, 1 := 70}; }
    endclass

    // Monitor automático
    int errors = 0;
    always @(posedge clk) begin
        if (reset && i_ss) begin
            if (dut.state == dut.READ_WAIT_PREADY && (o_rw !== 1 || o_Transfer !== 1 || o_addr !== dut.addr_reg)) begin
                $display("Monitor: Erro em READ_SETUP - Saídas esperadas: o_rw=1, o_Transfer=1, o_addr=%h, obtidas: o_rw=%b, o_Transfer=%b, o_addr=%h", 
                         dut.addr_reg, o_rw, o_Transfer, o_addr);
                errors++;
            end
            if (dut.state == dut.WRITE_WAIT_PREADY && (o_rw !== 0 || o_Transfer !== 1 || o_addr !== dut.addr_reg || o_data !== dut.data_reg)) begin
                $display("Monitor: Erro em WRITE_SETUP - Saídas esperadas: o_rw=0, o_Transfer=1, o_addr=%h, o_data=%h, obtidas: o_rw=%b, o_Transfer=%b, o_addr=%h, o_data=%h", 
                         dut.addr_reg, dut.data_reg, o_rw, o_Transfer, o_addr, o_data);
                errors++;
            end
        end
    end

    // Tarefas auxiliares
    task reset_dut;
        reset = 0;
        #10;
        reset = 1;
        #10;
    endtask

    task apply_stimulus(Stimulus stim);
        i_ss = stim.i_ss;
        i_ready = stim.i_ready;
        i_PREADY = stim.i_PREADY;
        i_data = stim.i_data;
        #10;
    endtask

    // Procedimento de teste automatizado
    initial begin
        Stimulus stim = new();
        int cycles = 1500; // Número de ciclos de teste

        $display("### Iniciando Testes Automatizados ###");
        i_ss = 0; i_ready = 0; i_PREADY = 0;
        reset_dut();
        

        // Teste aleatório com cobertura
        repeat (cycles) begin
            assert(stim.randomize()) else $fatal("Falha na randomização");
            apply_stimulus(stim);
        end

        // Forçar interrupção para verificar retorno a IDLE
        i_ss = 0;
        #50;

        // Verificar resultados
        $display("\n### Testes Concluídos ###");
        $display("Cobertura de estados alcançada: %0d%%", state_cov.get_coverage());
        $display("Cobertura de transições alcançada: %0d%%", transition_cov.get_coverage());
        $display("Erros detectados pelo monitor: %0d", errors);

        if (errors == 0 && state_cov.get_coverage() == 100 && transition_cov.get_coverage() == 100)
            $display("Teste bem-sucedido!");
        else
            $display("Teste falhou ou cobertura incompleta.");
        
        $finish;
    end

    // Monitoramento dos estados e saídas (opcional, para depuração)
    always @(posedge clk) begin
        $display("Tempo: %0t | Estado: %s | i_ss: %b | i_ready: %b | i_PREADY: %b | i_data: %h | o_addr: %h | o_data: %h | o_rw: %b | o_Transfer: %b",
                 $time, dut.state.name(), i_ss, i_ready, i_PREADY, i_data, o_addr, o_data, o_rw, o_Transfer);
    end

endmodule