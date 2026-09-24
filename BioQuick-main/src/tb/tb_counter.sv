`timescale 1ns/1ps

module tb_counter;
    // Parameters
    localparam UPTO = 3;
    localparam CLK_PERIOD = 10; // 10ns period for 100MHz clock

    // Signals
    reg clk;
    reg rst;
    reg incr;
    wire done;

    // Instantiate the counter
    counter #(.UPTO(UPTO)) dut (
        .clk(clk),
        .rst(rst),
        .incr(incr),
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

    // Test stimulus and checking
    initial begin
        // Initialize signals
        rst = 1;
        incr = 0;

        # (CLK_PERIOD * 2); // Wait for initial stabilization
        $display("Starting Testbench for Counter");

        // Test 1: Reset and Initial State
        $display("Test 1: Reset and Initial State");
        #CLK_PERIOD;
        if (dut.counter == UPTO && done == 0) $display("PASS: Counter initialized to UPTO=%0d after reset", UPTO);
        else $display("FAIL: Counter not initialized correctly, counter=%0d done=%b", dut.counter, done);
        rst = 0;
        # (CLK_PERIOD * 2);

        // Test 2: Normal Operation - Countdown to Zero
        $display("Test 2: Normal Operation - Countdown to Zero");
        incr = 1;
        repeat (UPTO) begin
            #CLK_PERIOD;
            $display("Time=%0t clk=%b rst=%b incr=%b counter=%0d done=%b", $time, clk, rst, incr, dut.counter, done);
        end
        if (done) $display("PASS: Countdown completed, done asserted");
        else $display("FAIL: Countdown did not complete, done=%b", done);
        incr = 0;
        #CLK_PERIOD;
        if (dut.counter == UPTO) $display("PASS: Counter auto-reset to UPTO=%0d after done", UPTO);
        else $display("FAIL: Counter did not auto-reset, counter=%0d", dut.counter);
        # (CLK_PERIOD * 2);

        // Test 3: Reset During Countdown
        $display("Test 3: Reset During Countdown");
        incr = 1;
        # (CLK_PERIOD * 2); // Count down a couple of steps
        rst = 1;
        #CLK_PERIOD;
        if (dut.counter == UPTO && done == 0) $display("PASS: Counter reset to UPTO=%0d during countdown", UPTO);
        else $display("FAIL: Counter did not reset correctly, counter=%0d done=%b", dut.counter, done);
        rst = 0;
        incr = 0;
        # (CLK_PERIOD * 2);

        // Test 4: No Increment When incr is Low
        $display("Test 4: No Increment When incr is Low");
        incr = 0;
        # (CLK_PERIOD * 2);
        if (dut.counter == UPTO) $display("PASS: Counter did not change when incr=0, counter=%0d", dut.counter);
        else $display("FAIL: Counter changed when incr=0, counter=%0d", dut.counter);
        incr = 1;
        #CLK_PERIOD;
        if (dut.counter == UPTO - 1) $display("PASS: Counter decremented when incr=1, counter=%0d", dut.counter);
        else $display("FAIL: Counter did not decrement correctly, counter=%0d", dut.counter);
        incr = 0;
        rst = 1;
        # (CLK_PERIOD * 2);

        // Test 5: Sequential Countdowns
        $display("Test 5: Sequential Countdowns");
        rst = 0;
        incr = 1;
        repeat (UPTO) begin
            #CLK_PERIOD;
        end
        if (done) $display("PASS: First countdown completed");
        else $display("FAIL: First countdown did not complete");
        #CLK_PERIOD;
        if (dut.counter == UPTO) $display("PASS: Counter auto-reset after first countdown");
        else $display("FAIL: Counter did not auto-reset after first countdown, counter=%0d", dut.counter);
        repeat (UPTO-1) begin
            #CLK_PERIOD;
            $display("Time=%0t clk=%b rst=%b incr=%b counter=%0d done=%b", $time, clk, rst, incr, dut.counter, done);
        end
        if (done) $display("PASS: Second countdown completed");
        else $display("FAIL: Second countdown did not complete");
        incr = 0;
        # (CLK_PERIOD * 2);

        // End simulation
        $display("All tests completed");
        $finish;
    end
endmodule
