`timescale 1ns / 1ps

module tb_spi_top;
    // Parameters
    parameter CRC_WID = 8;
    parameter DATA_WID = 16;
    parameter CLK_PERIOD = 10; // System clock period in ns
    parameter SCK_PERIOD = 20; // SPI clock period in ns

    // Signals for external interface
    reg clk, i_sck, i_cpol, i_cpha, i_order, i_ss, i_mosi;
    wire o_miso, spi_busy;

    // Signals for internal interface
    reg [DATA_WID-1:0] i_data;
    wire [DATA_WID-1:0] o_data;

    // Instantiate the spi_top module
    spi_top #(.CRC_WID(CRC_WID), .DATA_WID(DATA_WID)) dut (
        .clk(clk),
        .i_sck(i_sck),
        .i_cpol(i_cpol),
        .i_cpha(i_cpha),
        .i_order(i_order),
        .i_ss(i_ss),
        .i_mosi(i_mosi),
        .o_miso(o_miso),
        .spi_busy(spi_busy),
        .i_data(i_data),
        .o_data(o_data)
    );

    // System clock generation
    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // SPI clock generation (i_sck)
    initial i_sck = 0;
    always #(SCK_PERIOD/2) i_sck = ~i_sck;

    // Task to send a bit stream over MOSI
    task send_bit_stream;
        input [DATA_WID+CRC_WID-1:0] data;
        integer i;
        begin
            for (i = DATA_WID+CRC_WID-1; i >= 0; i = i - 1) begin
                i_mosi = data[i];
                @(posedge i_sck);
                #1; // Small delay to ensure data is sampled correctly
            end
            i_mosi = 0;
        end
    endtask

    // Test stimulus and display
    initial begin
        // Initialize signals
        i_cpol = 0;
        i_cpha = 0;
        i_order = 0; // MSB first
        i_ss = 1; // Slave select inactive
        i_mosi = 0;
        i_data = 0;
        #50;
        $display("Time=%0t clk=%b i_sck=%b i_ss=%b i_mosi=%b o_miso=%b spi_busy=%b i_data=%h o_data=%h", $time, clk, i_sck, i_ss, i_mosi, o_miso, spi_busy, i_data, o_data);

        $display("Starting Testbench for spi_top with CRC_WID=%0d, DATA_WID=%0d", CRC_WID, DATA_WID);

        // Test case 1: Send data with CPOL=0, CPHA=0, MSB first
        $display("Test case 1: CPOL=0, CPHA=0, MSB first");
        i_ss = 0; // Activate slave select
        send_bit_stream({8'h07, 16'hA5A5}); // Send CRC and data
        #100;
        i_ss = 1; // Deactivate slave select
        #50;
        $display("Time=%0t clk=%b i_sck=%b i_ss=%b i_mosi=%b o_miso=%b spi_busy=%b i_data=%h o_data=%h", $time, clk, i_sck, i_ss, i_mosi, o_miso, spi_busy, i_data, o_data);
        if (o_data == 16'hA5A5) begin
            $display("PASS: Received data matches sent data");
        end else begin
            $display("FAIL: Received data=%h, expected=%h", o_data, 16'hA5A5);
        end

        // Test case 2: Send data with CPOL=1, CPHA=1, LSB first
        $display("Test case 2: CPOL=1, CPHA=1, LSB first");
        i_cpol = 1;
        i_cpha = 1;
        i_order = 1; // LSB first
        i_ss = 0; // Activate slave select
        send_bit_stream({8'h07, 16'h5A5A}); // Send CRC and data
        #100;
        i_ss = 1; // Deactivate slave select
        #50;
        $display("Time=%0t clk=%b i_sck=%b i_ss=%b i_mosi=%b o_miso=%b spi_busy=%b i_data=%h o_data=%h", $time, clk, i_sck, i_ss, i_mosi, o_miso, spi_busy, i_data, o_data);
        if (o_data == 16'h5A5A) begin
            $display("PASS: Received data matches sent data");
        end else begin
            $display("FAIL: Received data=%h, expected=%h", o_data, 16'h5A5A);
        end

        // Test case 3: Test internal data input to serializer
        $display("Test case 3: Internal data to serializer");
        i_data = 16'hBEEF; // Provide data to be serialized out
        i_ss = 0; // Activate slave select
        #200; // Wait for serialization
        i_ss = 1; // Deactivate slave select
        #50;
        $display("Time=%0t clk=%b i_sck=%b i_ss=%b i_mosi=%b o_miso=%b spi_busy=%b i_data=%h o_data=%h", $time, clk, i_sck, i_ss, i_mosi, o_miso, spi_busy, i_data, o_data);

        $display("Testbench completed");
        $finish;
    end
endmodule
