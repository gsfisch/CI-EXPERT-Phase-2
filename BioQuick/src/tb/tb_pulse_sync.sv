`timescale 1ns / 1ps

module tb_pulse_sync;

  // Clock periods
  parameter CLK_S_PERIOD = 20; // Slow clock period (e.g., 50 MHz)
  parameter CLK_F_PERIOD = 10; // Fast clock period (e.g., 100 MHz)

  // Signals
  logic i_clk_s;
  logic i_rst_s;
  logic i_clk_f;
  logic i_rst_f;
  logic i_data;
  logic o_data;

  // Pass/Fail counters
  integer pass_count = 0;
  integer fail_count = 0;

  // Instantiate the DUT
  pulse_sync dut (
    .i_clk_s(i_clk_s),
    .i_rst_s(i_rst_s),
    .i_clk_f(i_clk_f),
    .i_rst_f(i_rst_f),
    .i_data(i_data),
    .o_data(o_data)
  );

  // Clock Generation
  // initial begin
  //   i_clk_s = 0;
  //   i_clk_f = 0;
  //   forever #(CLK_S_PERIOD / 2) i_clk_s = ~i_clk_s;
  //   forever #(CLK_F_PERIOD / 2) i_clk_f = ~i_clk_f;
  // end

  always #(CLK_S_PERIOD/2) i_clk_s = ~i_clk_s;
  always #(CLK_F_PERIOD/2) i_clk_f = ~i_clk_f;

  // Task to reset the DUT
  task automatic reset_dut();
    $display("[%0t] Resetting DUT...", $time);
    i_rst_s = 0;
    i_rst_f = 0;
    repeat (5) @(posedge i_clk_f);
    i_rst_s = 1;
    i_rst_f = 1;
    //repeat (5) @(posedge i_clk_f);
    $display("[%0t] Reset complete.", $time);
  endtask

  // Task to apply input pulse and check for output pulse
  // This task applies a single-cycle pulse on i_data (in slow clock domain)
  // and then checks if a single-cycle pulse appears on o_data (in fast clock domain)
  // within a reasonable timeframe.
  task automatic apply_input_and_check_output_pulse(string test_name);
    logic pulse_seen_high = 0;
    logic pulse_seen_low_after_high = 0;
    integer pulse_high_cycles = 0;
    integer check_start_time;
    integer monitor_cycles = 2;

    $display("[%0t] Starting Test: %s", $time, test_name);

    // Apply input pulse (one slow clock cycle)
    @(posedge i_clk_s);
    i_data = 1;
    @(posedge i_clk_s);
    i_data = 0;

    // Wait for a few fast clock cycles for the pulse to propagate
    // The synchronization latency is typically 2 fast clock cycles.
    // Wait a bit more to be safe before starting the check window.
    repeat (2) @(posedge i_clk_f);

    check_start_time = $time;

    // Monitor for the output pulse for a limited time window
    // The pulse should appear within a few fast clock cycles after the delay
    // Let's monitor for 10 fast clock cycles
    repeat (monitor_cycles) begin
      @(posedge i_clk_f);
      if (o_data == 1) begin
        if (!pulse_seen_high) begin
          pulse_seen_high = 1;
          pulse_high_cycles = 1;
          $display("[%0t] %s: Output pulse detected high.", $time, test_name);
        end else begin
          pulse_high_cycles++;
        end
      end else begin // o_data == 0
        if (pulse_seen_high && !pulse_seen_low_after_high) begin
          pulse_seen_low_after_high = 1;
          $display("[%0t] %s: Output pulse detected low after high.", $time, test_name);
        end
      end
    end // repeat monitor_cycles

    // Evaluate the results
    if (pulse_seen_high && pulse_seen_low_after_high && (pulse_high_cycles == 1)) begin
      $display("[%0t] %s: PASS - Output pulse detected (1 fast clock cycle wide).", $time, test_name);
      pass_count++;
    end else if (pulse_seen_high && pulse_seen_low_after_high && (pulse_high_cycles > 1)) begin
       $display("[%0t] %s: FAIL - Output pulse detected but width is %0d fast clock cycles (expected 1).", $time, test_name, pulse_high_cycles);
       fail_count++;
    end else if (pulse_seen_high && !pulse_seen_low_after_high) begin
       $display("[%0t] %s: FAIL - Output pulse detected high but did not return low within window.", $time, test_name);
       fail_count++;
    end
    else begin
      $display("[%0t] %s: FAIL - No output pulse detected within window.", $time, test_name);
      fail_count++;
    end

    // Ensure i_data is low after the test
    i_data = 0;

  endtask


  // Test Sequence
  initial begin
    $display("--- Starting Testbench for pulse_sync ---");

    // Initialize signals
    i_clk_s = 0;
    i_clk_f = 0;
    i_rst_s = 1; // Active low reset
    i_rst_f = 1; // Active low reset
    i_data  = 0;

    // Apply reset
    reset_dut();
    if (o_data === 0) begin
        $display("[%0t] PASS: Output is 0 after reset.", $time);
        pass_count++;
    end else begin
        $display("[%0t] FAIL: Output is not 0 after reset (is %b).", $time, o_data);
        fail_count++;
    end

    // --- Test Cases ---

    // Test Case 1: Single pulse
    apply_input_and_check_output_pulse("Test Case 1: Single pulse");

    // Test Case 2: Another single pulse
    apply_input_and_check_output_pulse("Test Case 2: Another single pulse");

    // // Test Case 3: Pulses close together
    // // This test applies two input pulses with a short delay.
    // // The checker task is designed for one pulse per call, so we call it twice
    // // with a delay in between the checks. This is a simplification; a robust
    // // test for close pulses would need a checker that counts pulses over a window.
    // apply_input_and_check_output_pulse("Test Case 3: Pulses close together (Pulse 1)");
    // //# (CLK_F_PERIOD * 5); // Wait a bit after the first check window before starting the second
    // apply_input_and_check_output_pulse("Test Case 3: Pulses close together (Pulse 2)");
    // # (CLK_F_PERIOD * 10); // Wait after the last pulse

    fork
      begin
        apply_input_and_check_output_pulse("Test Case 3: Pulses close together (Pulse 1)");
      end
      begin
        # (CLK_S_PERIOD * 3);
        apply_input_and_check_output_pulse("Test Case 3: Pulses close together (Pulse 2)");
      end
    join

    // Test Case 4: Reset during operation
    $display("[%0t] Starting Test: Test Case 4: Reset during operation", $time);
    @(posedge i_clk_s);
    i_data = 1;
    //# (CLK_F_PERIOD * 2); // Apply reset while pulse is high
    reset_dut();
    i_data = 0; // Release input data
    //# (CLK_F_PERIOD * 10); // Wait for stability after reset

    // Check output after reset during operation - should be 0
    if (o_data === 0) begin
      $display("[%0t] PASS: Output is 0 after reset during operation.", $time);
      pass_count++;
    end else begin
      $display("[%0t] FAIL: Output is not 0 after reset during operation (is %b).", $time, o_data);
      fail_count++;
    end

    # (CLK_F_PERIOD * 10);

    // End simulation and report
    $display("[%0t] --- Testbench finished ---", $time);
    $display("--- Test Summary ---");
    $display("PASS: %0d", pass_count);
    $display("FAIL: %0d", fail_count);
    $display("--------------------");

    if (fail_count == 0) begin
      $display("All tests passed!");
    end else begin
      $display("There were test failures.");
    end

    $finish;
  end

  // Optional: Monitor signals (useful for debugging)
  initial begin
    $monitor("[%0t] i_clk_s=%b, i_rst_s=%b, i_clk_f=%b, i_rst_f=%b, i_data=%b, pulse_mux=%b, pulse_mux_sync=%b, ffd=%b, o_data=%b",
             $time, i_clk_s, i_rst_s, i_clk_f, i_rst_f, i_data, dut.pulse_mux, dut.pulse_mux_sync, dut.ffd, o_data);
  end

endmodule: tb_pulse_sync