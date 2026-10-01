`timescale 1ns / 1ps

//  Module: tb_top
//
module tb_top;

  // Parameters
  parameter APB_DATA = 16;
  parameter DATA_WIDTH = 16;

  parameter CLK_SRC_PERIOD = 5; // Source clock period (100 MHz)
  parameter CLK_DST_PERIOD = 13; // Destination clock period (~30.3 MHz)

  logic                   i_clk_a;
  logic                   i_clk_b;
  logic                   i_rst_n_a;
  logic                   i_rst_n_b;

  // SPI
  logic                   i_sck;
  logic                   i_cpol;
  logic                   i_cpha;
  logic                   i_bit_order;
  logic                   i_ss;
  logic                   i_mosi;
  logic                   o_miso;
  logic                   o_spi_busy;

  // APB
  logic                   i_PREADY;
  logic                   i_PSLVERR;
  logic [APB_DATA - 1:0]  i_PRDATA;
  logic                   o_PWRITE;
  logic                   o_PSEL0;
  logic [APB_DATA - 1:0]  o_PADDR;
  logic [APB_DATA - 1:0]  o_PWDATA;

  // Clock Generation
  always #(CLK_SRC_PERIOD/2) i_clk_a = ~i_clk_a;
  always #(CLK_DST_PERIOD/2) i_clk_b = ~i_clk_b;

  // Instantiate the DUT
  top #(
    .APB_DATA(APB_DATA),
    .DATA_WIDTH(DATA_WIDTH)
  ) dut (
    .clk_a(i_clk_a),
    .clk_b(i_clk_b),
    .rst_n_a(i_rst_n_a),
    .rst_n_b(i_rst_n_b),

    // SPI
    .sck(i_sck),
    .cpol(i_cpol),
    .cpha(i_cpha),
    .bit_order(i_bit_order),
    .ss(i_ss),
    .mosi(i_mosi),
    .miso(o_miso),
    .spi_busy(o_spi_busy),

    // APB
    .PREADY(i_PREADY),
    .PSLVERR(i_PSLVERR),
    .PRDATA(i_PRDATA),
    .PWRITE(o_PWRITE),
    .PSEL0(o_PSEL0),
    .PADDR(o_PADDR),
    .PWDATA(o_PWDATA)
  );

  // Task to reset the DUT
  task automatic reset_dut();
    $display("[%0t] Resetting DUT...", $time);
    i_rst_n_a = 0;
    i_rst_n_b = 0;
    repeat (5) @(posedge i_clk_b);
    i_rst_n_a = 1;
    i_rst_n_b = 1;
    repeat (1) @(posedge i_clk_b);
    $display("[%0t] Reset complete.", $time);
  endtask

  initial begin
    $dumpfile("top.vcd");
    $dumpvars(0, tb_top);

    $display("--- Starting Testbench for top ---");

    // Initialize signals
    i_clk_a = 0;
    i_clk_b = 0;
    i_rst_n_a = 1;
    i_rst_n_b = 1;

    i_cpol = 0;
    i_cpha = 0;
    i_bit_order = 1;

    // Apply reset
    reset_dut();

    #1000ns;

    $finish;
  end

endmodule: tb_top
