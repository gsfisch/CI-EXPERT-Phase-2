`timescale 1ns/1ps
module tb_spi_frontend;

    // Clock and reset
    logic clk;
    initial clk = 0;
    always #5 clk = ~clk;

    // DUT signals with matching port names
    logic i_sck = 0;
    logic i_cpol, i_cpha, i_order, i_ss = 1;
    logic i_mosi, i_busy, i_data;

    logic o_miso, spi_busy, o_ss, o_data, o_order;

    // Test control signals
    logic expected_data, expected_miso;
    logic sample_occurred, change_occurred;
    
    // Test data storage
    logic [7:0] tx_data, rx_data;
    int test_number = 0;
    int error_count = 0;

    // Instantiate the DUT with explicit port connections
    spi_frontend dut (
        .clk(clk),
        .i_sck(i_sck),
        .i_cpol(i_cpol),
        .i_cpha(i_cpha),
        .i_order(i_order),
        .i_ss(i_ss),
        .i_mosi(i_mosi),
        .i_busy(i_busy),
        .i_data(i_data),
        .o_miso(o_miso),
        .spi_busy(spi_busy),
        .o_ss(o_ss),
        .o_data(o_data),
        .o_order(o_order)
    );

    // Task to test a specific SPI mode with basic operation
    task test_mode(input logic [1:0] mode);
        test_number++;
        $display("\n[Test %0d] Testing SPI Mode %0d (CPOL=%0d, CPHA=%0d)", 
                 test_number, mode, mode[1], mode[0]);
                 
        i_cpol = mode[1];
        i_cpha = mode[0];
        i_order = 0; // MSB first
        i_ss = 0;
        i_mosi = ($random % 2) ? 1'b1 : 1'b0;
        i_data = ($random % 2) ? 1'b1 : 1'b0;
        i_busy = 1;
        
        // Reset tracking flags
        sample_occurred = 0;
        change_occurred = 0;
        
        #20; // Wait for synchronization
        
        // Simulate 8 bits
        repeat (8) begin
            // Toggle SCK
            i_sck = ~i_sck;
            #5; // Wait for signals to propagate
            
            // Check if this edge should cause sampling or changing based on mode
            if ((~i_cpha && ((~i_cpol && i_sck) || (i_cpol && ~i_sck))) || 
                (i_cpha && ((~i_cpol && ~i_sck) || (i_cpol && i_sck)))) begin
                // This is a sample edge
                sample_occurred = 1;
                expected_data = i_mosi;
            end
            
            if ((~i_cpha && ((~i_cpol && ~i_sck) || (i_cpol && i_sck))) || 
                (i_cpha && ((~i_cpol && i_sck) || (i_cpol && ~i_sck)))) begin
                // This is a change edge
                change_occurred = 1;
                expected_miso = i_data;
            end
            
            #5; // Complete the clock cycle
            
            // Set new random values for next cycle
            i_mosi = ($random % 2) ? 1'b1 : 1'b0;
            i_data = ($random % 2) ? 1'b1 : 1'b0;
        end
        
        // Final check after all bits
        #10;
        i_ss = 1;
        #10;
        
        // Check outputs
        if (sample_occurred) begin
            assert (o_data == expected_data) else begin
                $error("[Test %0d] o_data mismatch in mode %b: expected %b, got %b", 
                       test_number, mode, expected_data, o_data);
                error_count++;
            end
        end
        
        assert (o_order == i_order) else begin
            $error("[Test %0d] o_order mismatch in mode %b: expected %b, got %b", 
                   test_number, mode, i_order, o_order);
            error_count++;
        end
        
        assert (o_ss == ~i_ss) else begin
            $error("[Test %0d] o_ss mismatch in mode %b: expected %b, got %b", 
                   test_number, mode, ~i_ss, o_ss);
            error_count++;
        end
        
        if (change_occurred) begin
            assert (o_miso == expected_miso) else begin
                $error("[Test %0d] miso mismatch in mode %b: expected %b, got %b", 
                       test_number, mode, expected_miso, o_miso);
                error_count++;
            end
        end
        
        #10;
        $display("[Test %0d] SPI Mode %0d test completed", test_number, mode);
    endtask

    // Task to test bit order (MSB first vs LSB first)
    task test_bit_order(input logic order, input logic [7:0] data);
        test_number++;
        $display("\n[Test %0d] Testing bit order: %s with data 0x%h", 
                 test_number, order ? "LSB first" : "MSB first", data);
        
        // Setup for mode 0 (CPOL=0, CPHA=0)
        i_cpol = 0;
        i_cpha = 0;
        i_order = order;
        i_ss = 1;
        i_busy = 1;
        tx_data = data;
        rx_data = 0;
        
        // Wait for synchronization
        #20;
        
        // Start transfer
        i_ss = 0;
        #10;
        
        // Transfer 8 bits
        for (int i = 0; i < 8; i++) begin
            // Set MOSI based on bit order
            if (order == 0) // MSB first
                i_mosi = tx_data[7-i];
            else // LSB first
                i_mosi = tx_data[i];
                
            // Set internal data for MISO
            i_data = ~i_mosi; // Just invert for testing
            
            // Clock cycle
            i_sck = 1;
            #10;
            i_sck = 0;
            #10;
            
            // Capture received data
            if (order == 0) // MSB first
                rx_data[7-i] = o_data;
            else // LSB first
                rx_data[i] = o_data;
        end
        
        // End transfer
        i_ss = 1;
        #20;
        
        // Verify results
        assert (rx_data == tx_data) else begin
            $error("[Test %0d] Data mismatch with %s order: sent 0x%h, received 0x%h", 
                   test_number, order ? "LSB first" : "MSB first", tx_data, rx_data);
            error_count++;
        end
        
        assert (o_order == i_order) else begin
            $error("[Test %0d] o_order mismatch: expected %b, got %b", 
                   test_number, i_order, o_order);
            error_count++;
        end
        
        $display("[Test %0d] Bit order test completed: %s", 
                 test_number, order ? "LSB first" : "MSB first");
    endtask

    // Task to test busy signal behavior
    task test_busy_behavior();
        test_number++;
        $display("\n[Test %0d] Testing busy signal behavior", test_number);
        
        // Setup for mode 0
        i_cpol = 0;
        i_cpha = 0;
        i_order = 0;
        i_ss = 1;
        i_busy = 0; // Start with not busy
        
        // Wait for synchronization
        #20;
        
        // Start transfer with busy = 0
        i_ss = 0;
        #10;
        
        // First bit with busy = 0
        i_mosi = 1;
        i_data = 1;
        i_sck = 1;
        #10;
        
        // Check that o_miso didn't change since busy = 0
        assert (o_miso !== i_data) else begin
            $error("[Test %0d] o_miso changed when busy=0", test_number);
            error_count++;
        end
        
        i_sck = 0;
        #10;
        
        // Set busy and try again
        i_busy = 1;
        i_mosi = 0;
        i_data = 0;
        i_sck = 1;
        #10;
        i_sck = 0;
        #10;
        
        // Check that o_miso changed now that busy = 1
        assert (o_miso == 0) else begin
            $error("[Test %0d] o_miso didn't change when busy=1", test_number);
            error_count++;
        end
        
        // End transfer
        i_ss = 1;
        #20;
        
        $display("[Test %0d] Busy signal test completed", test_number);
    endtask

    // Task to test multiple consecutive transfers
    task test_consecutive_transfers(input int num_transfers);
        test_number++;
        $display("\n[Test %0d] Testing %0d consecutive transfers", test_number, num_transfers);
        
        // Setup for mode 0
        i_cpol = 0;
        i_cpha = 0;
        i_order = 0;
        i_busy = 1;
        
        for (int t = 0; t < num_transfers; t++) begin
            // Generate random data
            tx_data = $random;
            rx_data = 0;
            
            $display("  Transfer %0d: Sending data 0x%h", t+1, tx_data);
            
            // Start transfer
            i_ss = 0;
            #10;
            
            // Transfer 8 bits
            for (int i = 0; i < 8; i++) begin
                i_mosi = tx_data[7-i];
                i_data = ~i_mosi; // Just invert for testing
                
                // Clock cycle
                i_sck = 1;
                #10;
                i_sck = 0;
                #10;
                
                // Capture received data
                rx_data[7-i] = o_data;
            end
            
            // End transfer with minimal gap
            i_ss = 1;
            #20;
            
            // Verify results
            assert (rx_data == tx_data) else begin
                $error("[Test %0d] Data mismatch in transfer %0d: sent 0x%h, received 0x%h", 
                       test_number, t+1, tx_data, rx_data);
                error_count++;
            end
        end
        
        $display("[Test %0d] Consecutive transfers test completed", test_number);
    endtask

    // Task to test changing configuration mid-transfer
    task test_mid_transfer_config_change();
        test_number++;
        $display("\n[Test %0d] Testing configuration change mid-transfer", test_number);
        
        // Start with mode 0
        i_cpol = 0;
        i_cpha = 0;
        i_order = 0;
        i_busy = 1;
        tx_data = 8'hA5; // 10100101
        
        // Start transfer
        i_ss = 0;
        #10;
        
        // Transfer first 4 bits in mode 0
        for (int i = 0; i < 4; i++) begin
            i_mosi = tx_data[7-i];
            
            // Clock cycle
            i_sck = 1;
            #10;
            i_sck = 0;
            #10;
        end
        
        // Change mode mid-transfer
        i_cpol = 1; // Change to mode 2
        #10;
        
        // Transfer remaining 4 bits in new mode
        for (int i = 4; i < 8; i++) begin
            i_mosi = tx_data[7-i];
            
            // Clock cycle (adjusted for new CPOL)
            i_sck = 0; // For CPOL=1, idle is high, so active is low
            #10;
            i_sck = 1;
            #10;
        end
        
        // End transfer
        i_ss = 1;
        #20;
        
        $display("[Test %0d] Mid-transfer configuration change test completed", test_number);
        $display("  Note: This test checks behavior but doesn't verify correctness");
        $display("  as changing configuration mid-transfer is not a standard operation");
    endtask

    // Task to test timing and synchronization
    task test_timing_and_sync();
        test_number++;
        $display("\n[Test %0d] Testing timing and synchronization", test_number);
        
        // Setup for mode 0
        i_cpol = 0;
        i_cpha = 0;
        i_order = 0;
        i_busy = 1;
        i_ss = 1;
        
        // Test rapid toggling of SCK
        $display("  Testing rapid SCK toggling");
        i_ss = 0;
        #1;
        
        repeat (20) begin
            i_sck = ~i_sck;
            #1;
        end
        
        i_ss = 1;
        #20;
        
        // Test asynchronous SCK relative to system clock
        $display("  Testing asynchronous SCK");
        i_ss = 0;
        #1;
        
        repeat (10) begin
            i_sck = ~i_sck;
            #3; // Not a multiple of system clock period
        end
        
        i_ss = 1;
        #20;
        
        $display("[Test %0d] Timing and synchronization test completed", test_number);
    endtask

    // Task to test slave select behavior
    task test_slave_select_behavior();
        test_number++;
        $display("\n[Test %0d] Testing slave select behavior", test_number);
        
        // Setup for mode 0
        i_cpol = 0;
        i_cpha = 0;
        i_order = 0;
        i_busy = 1;
        i_ss = 1;
        
        // Test SS transition
        #10;
        i_ss = 0;
        #10;
        
        // Verify o_ss
        assert (o_ss == 1) else begin
            $error("[Test %0d] o_ss not active when SS active", test_number);
            error_count++;
        end
        
        // Test brief SS deactivation
        i_ss = 1;
        #2;
        i_ss = 0;
        #10;
        
        // Test SS during transfer
        i_mosi = 1;
        i_sck = 1;
        #10;
        i_sck = 0;
        #10;
        
        // Deactivate SS mid-transfer
        i_ss = 1;
        #10;
        
        // Verify o_ss
        assert (o_ss == 0) else begin
            $error("[Test %0d] o_ss not inactive when SS inactive", test_number);
            error_count++;
        end
        
        $display("[Test %0d] Slave select behavior test completed", test_number);
    endtask

    // Task to test initialization state
    task test_initialization();
        test_number++;
        $display("\n[Test %0d] Testing initialization state", test_number);
        
        // Reset all inputs to default
        i_cpol = 0;
        i_cpha = 0;
        i_order = 0;
        i_ss = 1;
        i_busy = 0;
        i_sck = 0;
        i_mosi = 0;
        i_data = 0;
        
        // Wait for synchronization
        #20;
        
        // Check initial state of outputs
        assert (o_ss == 0) else begin
            $error("[Test %0d] o_ss not initialized to inactive", test_number);
            error_count++;
        end
        
        $display("[Test %0d] Initialization test completed", test_number);
    endtask

    initial begin
        $display("Starting SPI Frontend Tests");
        
        // Test initialization state
        test_initialization();
        
        // Test all four SPI modes
        test_mode(2'b00); // Mode 0: CPOL=0, CPHA=0
        test_mode(2'b01); // Mode 1: CPOL=0, CPHA=1
        test_mode(2'b10); // Mode 2: CPOL=1, CPHA=0
        test_mode(2'b11); // Mode 3: CPOL=1, CPHA=1
        
        // Test bit order
        test_bit_order(0, 8'hA5); // MSB first
        test_bit_order(1, 8'h5A); // LSB first
        
        // Test busy signal behavior
        test_busy_behavior();
        
        // Test multiple consecutive transfers
        test_consecutive_transfers(3);
        
        // Test changing configuration mid-transfer
        test_mid_transfer_config_change();
        
        // Test timing and synchronization
        test_timing_and_sync();
        
        // Test slave select behavior
        test_slave_select_behavior();
        
        // Report results
        $display("\n=== SPI Frontend Test Results ===");
        $display("Total tests run: %0d", test_number);
        $display("Total errors: %0d", error_count);
        
        if (error_count == 0)
            $display("All tests PASSED!");
        else
            $display("Some tests FAILED!");
            
        $display("=================================\n");
        $finish;
    end

endmodule
