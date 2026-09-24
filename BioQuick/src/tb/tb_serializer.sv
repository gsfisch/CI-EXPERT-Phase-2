`timescale 1ns / 1ps

module tb_serializer;
    // Parameters
    parameter WIDTH = 16;
    parameter OP_LEN = 0;
    parameter CLK_PERIOD = 10;

    // Signals
    reg clk, en, dir;
    reg [WIDTH-1:0] i_data;
    /* verilator lint_off UNUSEDSIGNAL */
    wire o_data;
    /* verilator lint_on UNUSEDSIGNAL */
    wire done;

    // Instantiate the serializer
    serializer #(.WIDTH(WIDTH), .OP_LEN(OP_LEN)) dut (
        .clk(clk),
        .en(en),
        .dir(dir),
        .i_data(i_data),
        .o_data(o_data),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Waveform dumping for Verilator
    initial begin
        $dumpfile(".verilator/waveform.vcd");
        $dumpvars(0, tb_counter);
    end

    // Test stimulus
    initial begin
        $display("Starting Testbench for Serializer with WIDTH=%0d, OP_LEN=%0d", WIDTH, OP_LEN);
        // Initialize signals
        en = 0; dir = 0; i_data = 0;
        #CLK_PERIOD;

        en = 0; dir = 0; i_data = 0;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 1: Serialize %d with dir %d", i_data, dir);
        $display("==================================================");
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0; dir = 1; i_data = 0;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 2: Serialize %d with dir %d", i_data, dir);
        $display("==================================================");
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0; dir = 0; i_data = 16'h5A5A;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 3: Serialize %d with dir %d", i_data, dir);
        $display("==================================================");
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0; dir = 1; i_data = 16'h5A5A;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 4: Serialize %d with dir %d", i_data, dir);
        $display("==================================================");
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0; dir = 0; i_data = 16'hFFFF;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 5: Serialize %d with dir %d", i_data, dir);
        $display("==================================================");
        en = 1;
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0; dir = 1; i_data = 16'hFFFF;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 6: Serialize %d with dir %d", i_data, dir);
        $display("==================================================");
        en = 1;
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0; dir = 0; i_data = 16'hAA55;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 7: Serialize %d with dir %d", i_data, dir);
        $display("==================================================");
        en = 1;
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0; dir = 0; i_data = 16'hAA55;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 8: Serialize consicutive signals dir %d", dir);
        $display("==================================================");
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");
        i_data = 16'h5A5A;
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");
        i_data = 16'h3F8A;
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0; dir = 1; i_data = 16'hAA55;
        #CLK_PERIOD;
        en = 1;
        $display("==================================================");
        $display("TEST 9: Serialize consicutive signals dir %d", dir);
        $display("==================================================");
        en = 1;
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");
        i_data = 16'h5A5A;
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");
        i_data = 16'h3F8A;
        # (WIDTH*CLK_PERIOD);
        if (done) $display("PASS: done signal asserted");
        else $display("FAIL: done signal miss");

        en = 0;
        #CLK_PERIOD;
        $display("Testbench completed");
        $finish;
    end
endmodule
