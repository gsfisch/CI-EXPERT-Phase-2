`timescale 1ns/1ps

module tb_sar_adc;

    // ============================================================
    // ADC parameters
    // ============================================================

    localparam int N = 10;

    // Reference voltage
    real VREF = 1.0;

    // Analog input voltage
    real VIN;

    // DAC voltage
    real VDAC;

    // ============================================================
    // DUT / Testbench signals
    // ============================================================

    logic clk;
    logic rst_n;
    logic start;

    logic comp_out;

    logic [N-1:0] dac_code;
    logic [N-1:0] adc_code;

    logic busy;
    logic done;


    // ============================================================
    // DUT
    // ============================================================

    sar_adc #(
        .N(N)
    ) dut (
        .clk      (clk),
        .rst_n    (rst_n),
        .start    (start),
        .comp_out (comp_out),
        .dac_code (dac_code),
        .adc_code (adc_code),
        .busy     (busy),
        .done     (done)
    );


    // ============================================================
    // Clock
    // ============================================================

    initial begin

        clk = 1'b0;

        forever #5 clk = ~clk;

    end


    // ============================================================
    // Behavioral DAC
    //
    // VDAC = DAC_CODE / 1024 * VREF
    // ============================================================

    always_comb begin

        VDAC = (real'(dac_code) / (2.0 ** N)) * VREF;

    end


    // ============================================================
    // Behavioral comparator
    //
    // comp_out = 1 when VIN >= VDAC
    // comp_out = 0 when VIN < VDAC
    // ============================================================

    always_comb begin

        if (VIN >= VDAC)
            comp_out = 1'b1;
        else
            comp_out = 1'b0;

    end


    // ============================================================
    // Waveform dump
    // ============================================================

    initial begin

        $dumpfile("sar_adc.vcd");
        $dumpvars(0, tb_sar_adc);

    end


    // ============================================================
    // Statistics
    // ============================================================

    integer total_tests;
    integer passed_tests;
    integer failed_tests;

    real expected_code;
    real error_code;
    real abs_error;

    real max_abs_error;


    // ============================================================
    // Conversion task
    // ============================================================

    task automatic convert(input real input_voltage);

        integer expected_int;
        integer actual_int;

        begin

            // ----------------------------------------------------
            // Apply analog input
            // ----------------------------------------------------

            VIN = input_voltage;


            // ----------------------------------------------------
            // Calculate ideal ADC code
            //
            // For an N-bit ADC:
            //
            // expected = VIN / VREF * (2^N - 1)
            // ----------------------------------------------------

            expected_code =
		(VIN / VREF) * (2.0 ** N);

            // Round to nearest integer

            expected_int =
		$rtoi(expected_code);


            // Saturation protection

            if (expected_int < 0)
                expected_int = 0;

            if (expected_int > ((1 << N) - 1))
                expected_int = ((1 << N) - 1);


            // ----------------------------------------------------
            // Start conversion
            //
            // This is EXACTLY the sequence from the original
            // working testbench.
            // ----------------------------------------------------

            @(posedge clk);

            start <= 1'b1;

            @(posedge clk);

            start <= 1'b0;


            // ----------------------------------------------------
            // Wait for conversion to finish
            // ----------------------------------------------------

            @(posedge done);

            #1;


            // ----------------------------------------------------
            // Read result
            // ----------------------------------------------------

            actual_int = adc_code;

            error_code =
                real'(actual_int) - expected_code;


            // Absolute error

            if (error_code < 0.0)
                abs_error = -error_code;
            else
                abs_error = error_code;


            if (abs_error > max_abs_error)
                max_abs_error = abs_error;


            // ----------------------------------------------------
            // Statistics
            // ----------------------------------------------------

            total_tests = total_tests + 1;


            if (actual_int == expected_int) begin

                passed_tests = passed_tests + 1;

            end
            else begin

                failed_tests = failed_tests + 1;

                $display("");
                $display("************ ADC ERROR ************");
                $display("VIN           = %0.6f V", VIN);
                $display("Expected code = %0d", expected_int);
                $display("Actual code   = %0d", actual_int);
                $display("Ideal code    = %0.4f", expected_code);
                $display("Error         = %0.4f LSB", error_code);
                $display("DAC code      = %0d", dac_code);
                $display("VDAC          = %0.6f V", VDAC);
                $display("***********************************");
                $display("");

            end


            // ----------------------------------------------------
            // Wait for return to IDLE
            // ----------------------------------------------------

            @(posedge clk);

        end

    endtask


    // ============================================================
    // Reset
    // ============================================================

    initial begin

        rst_n = 1'b0;
        start = 1'b0;

        VIN = 0.0;

        #30;

        rst_n = 1'b1;

    end


    // ============================================================
    // Main test
    // ============================================================

    initial begin

        // --------------------------------------------------------
        // Initialize statistics
        // --------------------------------------------------------

        total_tests   = 0;
        passed_tests  = 0;
        failed_tests  = 0;

        max_abs_error = 0.0;


        // --------------------------------------------------------
        // Wait for reset
        // --------------------------------------------------------

        wait(rst_n == 1'b1);

        #20;


        // --------------------------------------------------------
        // Test header
        // --------------------------------------------------------

        $display("");
        $display("==============================================");
        $display("       SAR ADC AUTOMATIC SWEEP TEST");
        $display("==============================================");
        $display("Resolution     = %0d bits", N);
        $display("VREF           = %0.3f V", VREF);
        $display("Input range    = 0.000 -> 1.000 V");
        $display("Step           = 0.001 V");
        $display("Total tests    = 1001");
        $display("==============================================");
        $display("");


        // --------------------------------------------------------
        // Sweep from 0 V to 1 V
        //
        // 0.000
        // 0.001
        // 0.002
        // ...
        // 0.999
        // 1.000
        //
        // Total = 1001 conversions
        // --------------------------------------------------------

        for (integer i = 0; i <= 1000; i++) begin

            convert(i / 1000.0);

        end


        // --------------------------------------------------------
        // Final report
        // --------------------------------------------------------

        $display("");
        $display("==============================================");
        $display("             SIMULATION SUMMARY");
        $display("==============================================");

        $display("Total tests   = %0d", total_tests);
        $display("Passed tests  = %0d", passed_tests);
        $display("Failed tests  = %0d", failed_tests);
        $display("Max abs error = %0.4f LSB", max_abs_error);

        $display("==============================================");


        if (failed_tests == 0) begin

            $display("RESULT: PASS");
            $display("All sweep points passed.");

        end
        else begin

            $display("RESULT: FAIL");
            $display("%0d conversion(s) failed.", failed_tests);

        end


        $display("==============================================");
        $display("");


        #50;

        $finish;

    end

endmodule
