`timescale 1ns/1ps

module tb_comparator;
    // Parameters
    localparam WIDTH = 4;
    localparam CLK_PERIOD = 10; // 10ns period for 100MHz clock

    // Signals
    reg clk;
    reg [WIDTH-1:0] i_recv, i_expc;
    wire o_eq;

    // Instantiate the comparator
    comparator #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .i_recv(i_recv),
        .i_expc(i_expc),
        .o_eq(o_eq)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Waveform dumping for Verilator
    initial begin
        $dumpfile(".verilator/waveform.vcd");
        $dumpvars(0, tb_comparator);
    end

    // Test stimulus and checking
    initial begin
        // Initialize signals
        i_recv = 0;
        i_expc = 0;
        # (CLK_PERIOD * 2); // Wait for initial stabilization
        $display("Starting Testbench for Comparator");

        // Test 1: Equal Inputs - All Zeros
        $display("Test 1: Equal Inputs - All Zeros");
        i_recv = 0;
        i_expc = 0;
        #CLK_PERIOD;
        if (o_eq == 1) $display("PASS: Equal inputs (0) correctly detected, o_eq=%b", o_eq);
        else $display("FAIL: Equal inputs (0) not detected, o_eq=%b", o_eq);

        // Test 2: Equal Inputs - All Ones
        $display("Test 2: Equal Inputs - All Ones");
        i_recv = {WIDTH{1'b1}};
        i_expc = {WIDTH{1'b1}};
        #CLK_PERIOD;
        if (o_eq == 1) $display("PASS: Equal inputs (all ones) correctly detected, o_eq=%b", o_eq);
        else $display("FAIL: Equal inputs (all ones) not detected, o_eq=%b", o_eq);

        // Test 3: Unequal Inputs
        $display("Test 3: Unequal Inputs");
        i_recv = 4'hA;
        i_expc = 4'h5;
        #CLK_PERIOD;
        if (o_eq == 0) $display("PASS: Unequal inputs correctly detected, o_eq=%b", o_eq);
        else $display("FAIL: Unequal inputs not detected, o_eq=%b", o_eq);

        // Test 4: Equal Inputs - Alternating Bits
        $display("Test 4: Equal Inputs - Alternating Bits");
        i_recv = 4'hA; // 1010
        i_expc = 4'hA;
        #CLK_PERIOD;
        if (o_eq == 1) $display("PASS: Equal inputs (alternating bits) correctly detected, o_eq=%b", o_eq);
        else $display("FAIL: Equal inputs (alternating bits) not detected, o_eq=%b", o_eq);

        // Test 5: Single Bit Difference
        $display("Test 5: Single Bit Difference");
        i_recv = 4'hF;
        i_expc = 4'hE;
        #CLK_PERIOD;
        if (o_eq == 0) $display("PASS: Unequal inputs (single bit difference) correctly detected, o_eq=%b", o_eq);
        else $display("FAIL: Unequal inputs (single bit difference) not detected, o_eq=%b", o_eq);

        // Test 6: Changing Inputs Over Time
        $display("Test 6: Changing Inputs Over Time");
        i_recv = 4'h3;
        i_expc = 4'h3;
        #CLK_PERIOD;
        if (o_eq == 1) $display("PASS: Equal inputs at time step 1, o_eq=%b", o_eq);
        else $display("FAIL: Equal inputs at time step 1, o_eq=%b", o_eq);
        i_recv = 4'h4;
        #CLK_PERIOD;
        if (o_eq == 0) $display("PASS: Unequal inputs at time step 2, o_eq=%b", o_eq);
        else $display("FAIL: Unequal inputs at time step 2, o_eq=%b", o_eq);
        i_expc = 4'h4;
        #CLK_PERIOD;
        if (o_eq == 1) $display("PASS: Equal inputs at time step 3, o_eq=%b", o_eq);
        else $display("FAIL: Equal inputs at time step 3, o_eq=%b", o_eq);

        // End simulation
        $display("All tests completed");
        $finish;
    end
endmodule
