`timescale 1ns / 1ps

module tb_hds_4_phase;

  // Parameters
  parameter DATA_WIDTH = 16;
  parameter type T = logic[DATA_WIDTH-1:0];
  parameter CLK_SRC_PERIOD = 5;
  parameter CLK_DST_PERIOD = 13;

  // Signals
  logic        i_sen_rst_n;
  logic        i_sen_clk;
  T            i_sen_data;
  logic        i_sen_valid;
  logic        o_sen_ready;
  logic        i_rcv_rst_n;
  logic        i_rcv_clk;
  T            o_rcv_data;
  logic        o_rcv_valid;
  logic        i_rcv_ready;

  // Pass/Fail counters
  integer pass_count = 0;
  integer fail_count = 0;

  // Expected and received data queues
  T expected_data [$];
  T received_data [$];

  // Instantiate the DUT
  hds_4_phase #(
    .DATA_WIDTH(DATA_WIDTH)
  ) dut (
    .i_sen_rst_n(i_sen_rst_n),
    .i_sen_clk(i_sen_clk),
    .i_sen_data(i_sen_data),
    .i_sen_valid(i_sen_valid),
    .o_sen_ready(o_sen_ready),
    .i_rcv_rst_n(i_rcv_rst_n),
    .i_rcv_clk(i_rcv_clk),
    .o_rcv_data(o_rcv_data),
    .o_rcv_valid(o_rcv_valid),
    .i_rcv_ready(i_rcv_ready)
  );

  // Clock Generation
  always #(CLK_SRC_PERIOD/2) i_sen_clk = ~i_sen_clk;
  always #(CLK_DST_PERIOD/2) i_rcv_clk = ~i_rcv_clk;

  // Assertions for protocol checks
  property p_sen_valid_ready;
    @(posedge i_sen_clk) disable iff (!i_sen_rst_n)
    i_sen_valid && !o_sen_ready |=> !i_sen_valid || o_sen_ready;
  endproperty
  assert property (p_sen_valid_ready) else
    $error("[%0t] Assertion failed: i_sen_valid stayed high without o_sen_ready.", $time);

  property p_rcv_valid_ready;
    @(posedge i_rcv_clk) disable iff (!i_rcv_rst_n)
    o_rcv_valid && !i_rcv_ready |=> o_rcv_valid until i_rcv_ready;
  endproperty
  assert property (p_rcv_valid_ready) else
    $error("[%0t] Assertion failed: o_rcv_valid changed without i_rcv_ready.", $time);

  // Coverage group
  covergroup cg_cdc_4phase @(posedge i_rcv_clk);
    coverpoint dut.sender.CS {
      bins idle = {dut.sender.IDLE};
      bins wait_ack_assert = {dut.sender.WAIT_ACK_ASSERT};
      bins wait_ack_deassert = {dut.sender.WAIT_ACK_DEASSERT};
    }
    coverpoint dut.receiver.CS {
      bins idle = {dut.receiver.IDLE};
      bins wait_req_deassert = {dut.receiver.WAIT_REQ_DEASSERT};
    }
    coverpoint i_sen_valid {
      bins low = {0};
      bins high = {1};
    }
    coverpoint o_sen_ready {
      bins low = {0};
      bins high = {1};
    }
    coverpoint o_rcv_valid {
      bins low = {0};
      bins high = {1};
    }
    coverpoint i_rcv_ready {
      bins low = {0};
      bins high = {1};
    }
    cross dut.sender.CS, dut.receiver.CS, i_sen_valid, o_sen_ready, o_rcv_valid, i_rcv_ready;
  endgroup

  cg_cdc_4phase cg = new();

  // Task to reset the DUT
  task automatic reset_dut();
    $display("[%0t] Resetting DUT...", $time);
    i_sen_rst_n = 0;
    i_rcv_rst_n = 0;
    i_sen_valid = 0;
    i_sen_data = '0;
    i_rcv_ready = 0;
    expected_data.delete();
    received_data.delete();
    repeat (5) @(posedge i_sen_clk);
    i_sen_rst_n = 1;
    i_rcv_rst_n = 1;
    repeat (2) @(posedge i_sen_clk);
    $display("[%0t] Reset complete.", $time);
  endtask

  // Task to send a data pulse and check handshake
  task automatic send_data_and_check(input string test_name, input integer rcv_ready_delay = 5);
    T test_data;
    integer check_start_time;
    integer monitor_cycles = 10;

    $display("[%0t] Starting Test: %s (rcv_ready_delay=%0d cycles)", $time, test_name, rcv_ready_delay);

    // Wait for o_sen_ready
    check_start_time = $time;
    $display("[%0t] test 1", $time);
    wait(o_sen_ready == 1'b1);
    $display("[%0t] %s: o_sen_ready high.", $time, test_name);

    $display("[%0t] test 2", $time);

    // Send data
    test_data = $urandom;
    @(posedge i_sen_clk);
    $display("[%0t] test 3", $time);
    i_sen_valid = 1;
    i_sen_data = test_data;
    expected_data.push_back(test_data);
    @(posedge i_sen_clk);
    $display("[%0t] test 4", $time);
    i_sen_valid = 0;
    $display("[%0t] %s: Sent i_sen_valid with data=%0h.", $time, test_name, test_data);

    // Monitor for o_rcv_valid and apply i_rcv_ready
    check_start_time = $time;
    repeat (monitor_cycles) begin
      @(posedge i_rcv_clk);
      if (o_rcv_valid) break;
      if (($time - check_start_time) > (CLK_DST_PERIOD * monitor_cycles)) begin
        $display("[%0t] %s: FAIL - Timeout waiting for o_rcv_valid.", $time, test_name);
        fail_count++;
        return;
      end
    end
    $display("[%0t] %s: o_rcv_valid high, received data=%0h.", $time, test_name, o_rcv_data);
    repeat (rcv_ready_delay) @(posedge i_rcv_clk);
    i_rcv_ready = 1;
    @(posedge i_rcv_clk);
    i_rcv_ready = 0;
    received_data.push_back(o_rcv_data);

    // Verify data
    if (received_data.size() > 0 && expected_data.size() > 0) begin
      if (received_data[$] === expected_data[$]) begin
        $display("[%0t] %s: PASS - Data %0h transferred correctly.", $time, test_name, test_data);
        pass_count++;
      end else begin
        $display("[%0t] %s: FAIL - Expected data=%0h, received data=%0h.", $time, test_name, expected_data[$], received_data[$]);
        fail_count++;
      end
    end else begin
      $display("[%0t] %s: FAIL - No data received.", $time, test_name);
      fail_count++;
    end
  endtask

  // Task to test premature i_sen_valid
  task automatic test_premature_valid();
    string test_name = "Test Case 4: Premature i_sen_valid";
    T test_data;

    $display("[%0t] Starting Test: %s", $time, test_name);
    test_data = $urandom;
    @(posedge i_sen_clk);
    i_sen_valid = 1;
    i_sen_data = test_data;
    @(posedge i_sen_clk);
    i_sen_valid = 0;
    $display("[%0t] %s: i_sen_valid asserted without waiting for o_sen_ready.", $time, test_name);
    # (CLK_SRC_PERIOD * 20);
    send_data_and_check("Test Case 4: Valid pulse after premature assertion", 5);
  endtask

  // Task to test back-to-back data transfers
  task automatic test_back_to_back_data();
    string test_name = "Test Case 7: Back-to-back data transfers";
    integer pulses_completed = 0;

    $display("[%0t] Starting Test: %s", $time, test_name);
    for (int i = 0; i < 3; i++) begin
      send_data_and_check($sformatf("%s: Pulse %0d", test_name, i+1), 1);
      if (fail_count == 0) pulses_completed++;
      //# (CLK_SRC_PERIOD * 5);
    end
    if (pulses_completed == 3) begin
      $display("[%0t] %s: PASS - All 3 back-to-back transfers completed.", $time, test_name);
      pass_count++;
    end else begin
      $display("[%0t] %s: FAIL - Only %0d of 3 transfers completed.", $time, test_name, pulses_completed);
      fail_count++;
    end
  endtask

  // Task to test long delay for i_rcv_ready
  task automatic test_long_delay();
    string test_name = "Test Case 8: Long delay for i_rcv_ready";
    send_data_and_check(test_name, 20);
  endtask

  // Task to test rapid data transfers
  task automatic test_stress_data();
    string test_name = "Test Case 9: Rapid data transfers";
    integer pulses_sent = 0;
    integer pulses_completed = 0;
    integer cycles = 10;

    $display("[%0t] Starting Test: %s", $time, test_name);
    repeat (cycles) begin
      send_data_and_check($sformatf("%s: Pulse %0d", test_name, pulses_sent+1), 2);
      if (fail_count == 0) pulses_completed++;
      pulses_sent++;
      # (CLK_SRC_PERIOD * 2);
    end
    if (pulses_completed == cycles) begin
      $display("[%0t] %s: PASS - All %0d pulses completed successfully.", $time, test_name, cycles);
      pass_count++;
    end else begin
      $display("[%0t] %s: FAIL - Only %0d of %0d pulses completed.", $time, test_name, pulses_completed, cycles);
      fail_count++;
    end
  endtask

  // Task to test asynchronous reset during transfer
  task automatic test_async_reset_during_transfer();
    string test_name = "Test Case 10: Async reset during transfer";
    T test_data;
    integer check_start_time;
    integer monitor_cycles = 50;

    $display("[%0t] Starting Test: %s", $time, test_name);
    check_start_time = $time;
    wait(o_sen_ready == 1'b1);
    test_data = $urandom;
    @(posedge i_sen_clk);
    i_sen_valid = 1;
    i_sen_data = test_data;
    expected_data.push_back(test_data);
    @(posedge i_sen_clk);
    i_sen_valid = 0;
    $display("[%0t] %s: i_sen_valid asserted with data=%0h.", $time, test_name, test_data);
    repeat (2) @(posedge i_rcv_clk);
    i_sen_rst_n = 0;
    i_rcv_rst_n = 0;
    # (CLK_DST_PERIOD * 2);
    i_sen_rst_n = 1;
    i_rcv_rst_n = 1;
    $display("[%0t] %s: Async reset applied during transfer.", $time, test_name);
    repeat (5) @(posedge i_rcv_clk);
    if (o_rcv_valid == 0 && o_rcv_data == '0) begin
      $display("[%0t] %s: PASS - Correct state after async reset.", $time, test_name);
      pass_count++;
    end else begin
      $display("[%0t] %s: FAIL - Incorrect state after async reset (o_rcv_valid=%b, o_rcv_data=%0h).", $time, test_name, o_rcv_valid, o_rcv_data);
      fail_count++;
    end
  endtask

  // Test Sequence
  initial begin
    $dumpfile("cdc_4phase.vcd");
    $dumpvars(0, tb_hds_4_phase);

    $display("--- Starting Testbench for hds_4_phase ---");

    // Initialize signals
    i_sen_clk = 0;
    i_rcv_clk = 0;
    i_sen_rst_n = 1;
    i_rcv_rst_n = 1;
    i_sen_valid = 0;
    i_sen_data = '0;
    i_rcv_ready = 0;

    // Apply reset
    reset_dut();

    // Test Case 1: Check output after reset
    if (o_rcv_valid === 0 && o_sen_ready === 1) begin
      $display("[%0t] PASS: Output is o_rcv_valid=0, o_sen_ready=1 after reset.", $time);
      pass_count++;
    end else begin
      $display("[%0t] FAIL: Output is not o_rcv_valid=0, o_sen_ready=1 after reset (o_rcv_valid=%b, o_sen_ready=%b).", $time, o_rcv_valid, o_sen_ready);
      fail_count++;
    end

    // Test Case 2: Single data transfer
    send_data_and_check("Test Case 2: Single data transfer", 0);
    //# (CLK_SRC_PERIOD * 10);

    // Test Case 3: Multiple data transfers
    send_data_and_check("Test Case 3: Multiple data transfers (1)", 5);
    # (CLK_SRC_PERIOD * 5);
    send_data_and_check("Test Case 3: Multiple data transfers (2)", 3);
    # (CLK_SRC_PERIOD * 5);
    send_data_and_check("Test Case 3: Multiple data transfers (3)", 7);
    # (CLK_SRC_PERIOD * 10);

    // // Test Case 4: Premature i_sen_valid
    // test_premature_valid();
    // # (CLK_SRC_PERIOD * 10);

    // Test Case 5: Reset during operation
    send_data_and_check("Test Case 5: Pulse before reset", 5);
    # (CLK_SRC_PERIOD * 2);
    i_sen_rst_n = 0;
    i_rcv_rst_n = 0;
    # (CLK_SRC_PERIOD * 10);
    i_sen_rst_n = 1;
    i_rcv_rst_n = 1;
    i_sen_valid = 0;
    # (CLK_SRC_PERIOD * 10);
    if (o_rcv_valid === 0 && o_rcv_data === '0) begin
      $display("[%0t] PASS: Output is o_rcv_valid=0, o_rcv_data=0 after reset during operation.", $time);
      pass_count++;
    end else begin
      $display("[%0t] FAIL: Output is not o_rcv_valid=0, o_rcv_data=0 after reset (o_rcv_valid=%b, o_rcv_data=%0h).", $time, o_rcv_valid, o_rcv_data);
      fail_count++;
    end

    // // Test Case 6: Test SEND_RESET_MSG mode
    // $display("[%0t] Test Case 6: Skipped - SEND_RESET_MSG not supported in this design.", $time);
    // pass_count++; // Mark as passed since not applicable
    // # (CLK_SRC_PERIOD * 10);

    // Test Case 7: Back-to-back data transfers
    test_back_to_back_data();
    # (CLK_SRC_PERIOD * 10);

    // Test Case 8: Long delay for i_rcv_ready
    test_long_delay();
    # (CLK_SRC_PERIOD * 10);

    // Test Case 9: Rapid data transfers
    test_stress_data();
    # (CLK_SRC_PERIOD * 10);

    // Test Case 10: Asynchronous reset during transfer
    test_async_reset_during_transfer();
    # (CLK_SRC_PERIOD * 10);

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

    // Report coverage
    $display("\n### Tests completed ###");
    $display("Coverage achieved: %0d%%", cg.get_coverage());

    if (cg.get_coverage() >= 95)
      $display("Successful test with high coverage");
    else
      $display("Test may have incomplete coverage");

    $finish;
  end

endmodule: tb_hds_4_phase