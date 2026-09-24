`timescale 1ns/1ps

module tb_crc;
    // Parameters
    localparam WIDTH = 8;
    localparam CLK_PERIOD = 10; // 10ns period for 100MHz clock

    // Signals
    reg clk;
    reg en;
    reg rst;
    reg i_bit;
    reg i_order;
    reg [WIDTH-1:0] i_poly;
    reg [WIDTH-1:0] i_val;
    wire [WIDTH-1:0] o_crc;
    integer i, j;

    reg [WIDTH-1:0] test_vectors [2:0];
    reg [WIDTH-1:0] expected_crcs [2:0];
    
    // Instantiate the CRC module
    crc #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .en(en),
        .rst(rst),
        .i_bit(i_bit),
        .i_order(i_order),
        .i_poly(i_poly),
        .o_crc(o_crc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Waveform dumping for Verilator
    initial begin
        $dumpfile(".verilator/waveform.vcd");
        $dumpvars(0, tb_crc);
    end

    // Test stimulus and checking
    initial begin
        // Initialize signals
        en = 0;
        rst = 1;
        i_bit = 0;
        i_order = 0;
        i_poly = 8'h07; // CRC-8-CCIT polynomial (x^8 + x^2 + x + 1)
        i_val = 0;
        # (CLK_PERIOD * 2);
        rst = 0;
        # (CLK_PERIOD * 2);

        $display("Starting Testbench for CRC");

        // Test 1: Initialization Test
        $display("==================================================");
        $display("Test 1: Initialization Test");
        $display("==================================================");
        rst = 1;
        #CLK_PERIOD;
        rst = 0;
        if (o_crc == {WIDTH{1'b0}}) $display("PASS: CRC reset to all 0's");
        else $display("FAIL: CRC reset value incorrect, o_crc=%h", o_crc);
        en = 1;
        #CLK_PERIOD;
        en = 0;
        if (o_crc == {WIDTH{1'b0}}) $display("PASS: CRC reset to all 0's");
        else $display("FAIL: CRC reset value incorrect, o_crc=%h", o_crc);
        #CLK_PERIOD;

        // Test 2: Basic CRC Calculation - MSB First
        $display("==================================================");
        $display("Test 2: Basic CRC Calculation - MSB First");
        $display("==================================================");
        en = 1;
        i_order = 0;
        // Input sequence: 0xAA, 0x37, 0x82
        test_vectors[0] = 8'hAA;
        test_vectors[1] = 8'h37;
        test_vectors[2] = 8'h82;
        expected_crcs[0] = 8'h5F;
        expected_crcs[1] = 8'h1F;
        expected_crcs[2] = 8'hDA;
        for (j = 0; j < 3; j = j + 1) begin
            i_val = test_vectors[j];
            for (i = WIDTH-1; i >= 0; i = i - 1) begin
                i_bit = i_val[i];
                #CLK_PERIOD;
                $display("Time=%0t clk=%b en=%b rst=%b i_bit=%b i_order=%b i_poly=%h o_crc=%h (Bit %0d of 0x%0h)", 
                         $time, clk, en, rst, i_bit, i_order, i_poly, o_crc, i, i_val);
            end
            if (o_crc == expected_crcs[j]) $display("[PASS]: CRC match for 0x%0h, expected=%h, got=%h", i_val, expected_crcs[j], o_crc);
            else $display("[FAIL]: CRC mismatch for 0x%0h, expected=%h, got=%h", i_val, expected_crcs[j], o_crc);
        end
        en = 0;
        # (CLK_PERIOD * 2);

        // Test 3: Basic CRC Calculation - LSB First
        $display("==================================================");
        $display("Test 3: Basic CRC Calculation - LSB First");
        $display("==================================================");
        i_poly = 8'h7; // CRC-8-CCIT polynomial reversed (x^8 + x^2 + x)
        rst = 1;
        #CLK_PERIOD;
        rst = 0;
        en = 1;
        i_order = 1;
        // Reuse test vectors: 0xAA, 0x37, 0x82
        expected_crcs[0] = 8'h35;
        expected_crcs[1] = 8'hE3;
        expected_crcs[2] = 8'hD9;
        for (j = 0; j < 3; j = j + 1) begin
            i_val = test_vectors[j];
            for (i = 0; i < WIDTH; i = i + 1) begin
                i_bit = i_val[i];
                #CLK_PERIOD;
                $display("Time=%0t clk=%b en=%b rst=%b i_bit=%b i_order=%b i_poly=%h o_crc=%h (Bit %0d of 0x%0h)", 
                        $time, clk, en, rst, i_bit, i_order, i_poly, o_crc, i, i_val);
            end
            if (o_crc == expected_crcs[j]) $display("[PASS]: CRC match for 0x%0h, expected=%h, got=%h", i_val, expected_crcs[j], o_crc);
            else $display("[FAIL]: CRC mismatch for 0x%0h, expected=%h, got=%h", i_val, expected_crcs[j], o_crc);
            $display("Note: CRC for 0x%0h (LSB-first) with poly 0x07 = %h, please verify manually", i_val, o_crc);
        end
        en = 0;
        # (CLK_PERIOD * 2);

        // Test 4: Edge Cases
        $display("==================================================");
        $display("Test 4: Edge Cases");
        $display("==================================================");
        rst = 1;
        #CLK_PERIOD;
        rst = 0;
        en = 1;
        i_order = 0;
        // Test all zeros and all ones
        test_vectors[0] = 8'h00;
        test_vectors[1] = 8'hFF;
        expected_crcs[0] = 8'h00; // Expected for 0x00
        expected_crcs[1] = 8'hFE; // Expected for 0xFF
        for (j = 0; j < 2; j = j + 1) begin
            i_val = test_vectors[j];
        for (i = WIDTH-1; i >= 0; i = i - 1) begin
            i_bit = i_val[i];
            #CLK_PERIOD;
                $display("Time=%0t clk=%b en=%b rst=%b i_bit=%b i_order=%b i_poly=%h o_crc=%h (Bit %0d of 0x%0h)", 
                         $time, clk, en, rst, i_bit, i_order, i_poly, o_crc, i, i_val);
            end
            if (o_crc == expected_crcs[j]) $display("PASS: CRC match for 0x%0h, expected=%h, got=%h", i_val, expected_crcs[j], o_crc);
            else $display("FAIL: CRC mismatch for 0x%0h, expected=%h, got=%h", i_val, expected_crcs[j], o_crc);
        end
        en = 0;
        # (CLK_PERIOD * 2);

        // Test 5: Enable/Disable Functionality
        $display("==================================================");
        $display("Test 5: Enable/Disable Functionality");
        $display("==================================================");
        rst = 1;
        #CLK_PERIOD;
        rst = 0;
        en = 1;
        i_order = 0;
        i_val = 8'hAA;
        for (i = WIDTH-1; i >= WIDTH/2; i = i - 1) begin
            i_bit = i_val[i];
            #CLK_PERIOD;
            $display("Time=%0t clk=%b en=%b rst=%b i_bit=%b i_order=%b i_poly=%h o_crc=%h (Bit %0d of 0xAA)", 
                     $time, clk, en, rst, i_bit, i_order, i_poly, o_crc, i);
        end
        en = 0;
        #CLK_PERIOD;
        if (o_crc == 8'h00) $display("PASS: CRC reset to 0 when en=0, o_crc=%h", o_crc);
        else $display("FAIL: CRC did not reset when en=0, expected=%h, got=%h", 8'h00, o_crc);
        en = 1;
        rst = 1;
        #CLK_PERIOD;
        rst = 0;
        for (i = WIDTH-1; i >= 0; i = i - 1) begin
            i_bit = i_val[i];
            #CLK_PERIOD;
            $display("Time=%0t clk=%b en=%b rst=%b i_bit=%b i_order=%b i_poly=%h o_crc=%h (Bit %0d of 0xAA)", 
                     $time, clk, en, rst, i_bit, i_order, i_poly, o_crc, i);
        end
        if (o_crc == 8'hE7) $display("PASS: CRC calculation correct after re-enabling, expected=%h, got=%h", 8'hE7, o_crc);
        else $display("FAIL: CRC calculation incorrect after re-enabling, expected=%h, got=%h", 8'hE7, o_crc);
        en = 0;
        # (CLK_PERIOD * 2);

        // Test 6: Different Polynomial
        $display("==================================================");
        $display("Test 6: Different Polynomial");
        $display("==================================================");
        rst = 1;
        #CLK_PERIOD;
        rst = 0;
        en = 1;
        i_order = 0;
        i_poly = 8'h1D; // CRC-8-Dallas/Maxim polynomial
        i_val = 8'hAA;
        for (i = WIDTH-1; i >= 0; i = i - 1) begin
            i_bit = i_val[i];
            #CLK_PERIOD;
            $display("Time=%0t clk=%b en=%b rst=%b i_bit=%b i_order=%b i_poly=%h o_crc=%h (Bit %0d of 0xAA)", 
                     $time, clk, en, rst, i_bit, i_order, i_poly, o_crc, i);
        end
        if (o_crc == 8'h7C) $display("PASS: CRC match for 0x%0h with poly 0x1D, expected=%h, got=%h", i_val, 8'h7C, o_crc);
        else $display("FAIL: CRC mismatch for 0x%0h with poly 0x1D, expected=%h, got=%h", i_val, 8'h7C, o_crc);
        en = 0;
        # (CLK_PERIOD * 2);

        // Test 7: Polynomial Change Mid-Calculation
        $display("==================================================");
        $display("Test 7: Polynomial Change Mid-Calculation");
        $display("==================================================");
        rst = 1;
        #CLK_PERIOD;
        rst = 0;
        en = 1;
        i_order = 0;
        i_poly = 8'h07;
        i_val = 8'hAA;
        for (i = WIDTH-1; i >= WIDTH/2; i = i - 1) begin
            i_bit = i_val[i];
            #CLK_PERIOD;
            $display("Time=%0t clk=%b en=%b rst=%b i_bit=%b i_order=%b i_poly=%h o_crc=%h (Bit %0d of 0xAA)", 
                     $time, clk, en, rst, i_bit, i_order, i_poly, o_crc, i);
        end
        i_poly = 8'h1D; // Change polynomial mid-calculation
        for (i = (WIDTH/2)-1; i >= 0; i = i - 1) begin
            i_bit = i_val[i];
            #CLK_PERIOD;
            $display("Time=%0t clk=%b en=%b rst=%b i_bit=%b i_order=%b i_poly=%h o_crc=%h (Bit %0d of 0xAA)", 
                     $time, clk, en, rst, i_bit, i_order, i_poly, o_crc, i);
        end
        $display("Note: CRC with mid-calculation polynomial change = %h, please verify manually", o_crc);
        en = 0;
        # (CLK_PERIOD * 2);

        // End simulation
        $display("All tests completed");
        $finish;
    end
endmodule
