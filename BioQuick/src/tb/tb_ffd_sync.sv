// Testbench for 2-flip-flop synchronizer (ffd_sync)
// Validates reset, data synchronization, and handles various input patterns.

`timescale 1ns/1ps

module tb_ffd_sync;
  // Timing parameters
  localparam CLK_PERIOD = 10; // 100MHz clock

  // Signals
  logic clk;
  logic rst;
  logic i_data;
  logic o_data;

  logic random_data = 0;

  // Instantiate the DUT
  ffd_sync dut (
    .i_clk(clk),
    .i_rst_n(rst),
    .i_data(i_data),
    .o_data(o_data)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk;
  end

  // Test tracking
  int pass_count = 0;
  int fail_count = 0;

  // --- Tasks for Test Automation ---

  // Task to reset the DUT
  task automatic reset_dut();
    $display("[%0t] Resetting DUT...", $time);
    rst = 1;
    i_data = 0; // Drive a known value during reset
    repeat (2) @(posedge clk);
    rst = 0;
    @(posedge clk);
    $display("[%0t] Reset complete.", $time);
  endtask

  // Task to apply stimulus and check the output after the expected delay
  task automatic apply_and_check(input logic din, string test_name);
    logic expected_data;

    i_data = din;
    @(posedge clk);

    // Wait for 2 cycles for the data to propagate through the synchronizer
    repeat (2) @(posedge clk);

    expected_data = din;

    if (o_data === expected_data) begin
      $display("[%0t] PASS: %s (i_data=%b, o_data=%b)", $time, test_name, din, o_data);
      pass_count++;
    end else begin
      $display("[%0t] FAIL: %s (i_data=%b, o_data=%b, expected=%b)", $time, test_name, din, o_data, expected_data);
      fail_count++;
    end
  endtask

  // --- Test Sequence ---
  initial begin
    $display("--- Starting Testbench for ffd_sync ---");

    // 1. Initial Reset
    reset_dut();
    if (o_data === 0) begin
        $display("[%0t] PASS: Output is 0 after reset.", $time);
        pass_count++;
    end else begin
        $display("[%0t] FAIL: Output is not 0 after reset (is %b).", $time, o_data);
        fail_count++;
    end

    // 2. Basic Data Transitions
    apply_and_check(1, "Transition 0 -> 1");
    apply_and_check(0, "Transition 1 -> 0");

    // 3. Hold Value
    apply_and_check(1, "Hold 1 (A)");
    apply_and_check(1, "Hold 1 (B)");
    apply_and_check(0, "Hold 0 (A)");
    apply_and_check(0, "Hold 0 (B)");

    // 4. Test with random data

    $display("[%0t] Starting random data test...", $time);
    for (int i = 0; i < 20; i++) begin
      random_data = $urandom_range(0, 1);
      apply_and_check(random_data, $sformatf("Random Test #%0d", i + 1));
    end

    // 5. Test reset during operation
    $display("[%0t] Testing reset during operation...", $time);
    apply_and_check(1, "Pre-reset check");
    reset_dut();
    if (o_data === 0) begin
        $display("[%0t] PASS: Output successfully reset during operation.", $time);
        pass_count++;
    end else begin
        $display("[%0t] FAIL: Output not reset during operation (is %b).", $time, o_data);
        fail_count++;
    end
    apply_and_check(1, "Post-reset check");


    // --- Test Summary ---
    $display("\n--- Testbench Finished ---");
    $display("Passed: %0d", pass_count);
    $display("Failed: %0d", fail_count);
    $display("--------------------------");

    if (fail_count == 0) begin
      $display("All tests passed!");
    end else begin
      $display("There were test failures.");
    end

    $finish;
  end

  // Optional: Monitor for debugging
  initial begin
    $monitor("[%0t] clk=%b rst=%b i_data=%b o_data=%b", $time, clk, rst, i_data, o_data);
  end

endmodule
