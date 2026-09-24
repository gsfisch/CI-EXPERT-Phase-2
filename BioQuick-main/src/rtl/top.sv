`timescale 1ns / 1ps

//  Module: top
//
module top
  /*  package imports  */
  #(
    parameter APB_DATA = 16,
    parameter DATA_WIDTH = 16
  )(
    input   logic                   clk_a,
    input   logic                   clk_b,
    input   logic                   rst_n_a,
    input   logic                   rst_n_b,

    // SPI
    input   logic                   sck,
    input   logic                   cpol,
    input   logic                   cpha,
    input   logic                   bit_order,
    input   logic                   ss,
    input   logic                   mosi,

    output  logic                   miso,
    output  logic                   spi_busy,

    // APB
    input   logic                   PREADY,
    input   logic                   PSLVERR,
    input   logic [APB_DATA - 1:0]  PRDATA,

    output  logic                   PWRITE,
    output  logic                   PSEL0,
    output  logic [APB_DATA - 1:0]  PADDR,
    output  logic [APB_DATA - 1:0]  PWDATA
  );

  logic crc_error, crc_error_synced;

  logic spi_ss, spi_ss_synced;
  logic spi_sen_ready;
  logic spi_sen_valid;
  logic spi_rcv_ready;
  logic spi_rcv_valid;

  logic apb_sen_ready;
  logic apb_sen_valid;
  logic apb_rcv_ready;
  logic apb_rcv_valid;

  logic [DATA_WIDTH - 1:0] spi_data, spi_data_synced;
  logic [DATA_WIDTH - 1:0] apb_data, apb_data_synced;

  wrap_spi #(
    .DATA_WIDTH(DATA_WIDTH)
  ) SPI (
    .i_clk(clk_a),
    .i_rst_n(rst_n_a),
    .i_data(apb_data_synced),
    .o_data(spi_data),

    // SPI signals
    .i_sck(sck),
    .i_cpol(cpol),
    .i_cpha(cpha),
    .i_bit_order(bit_order),
    .i_ss(ss),
    .i_mosi(mosi),
    .o_miso(miso),
    .o_spi_busy(spi_busy),

    // controll signals
    .o_crc_error(crc_error),
    .o_ss(spi_ss),

    // Sync signals
    .i_sen_ready(spi_sen_ready),
    .i_rcv_valid(spi_rcv_valid),
    .o_rcv_ready(spi_rcv_ready),
    .o_sen_valid(spi_sen_valid)
  );

  wrap_apb #(
    .APB_DATA(APB_DATA),
    .DATA_WIDTH(DATA_WIDTH)
  ) APB (
    .i_clk(clk_b),
    .i_rst_n(rst_n_b),
    .i_data(spi_data_synced),
    .o_data(apb_data),

    // APB sinals
    .i_PREADY(PREADY),
    .i_PSLVERR(PSLVERR),
    .i_PRDATA(PRDATA),
    .o_PWRITE(PWRITE),
    .o_PSEL0(PSEL0),
    .o_PADDR(PADDR),
    .o_PWDATA(PWDATA),

    // controll signals
    .i_crc_error(crc_error_synced),
    .i_ss(spi_ss_synced),

    // Sync signals
    .i_sen_ready(apb_sen_ready),
    .i_rcv_valid(apb_rcv_valid),
    .o_rcv_ready(apb_rcv_ready),
    .o_sen_valid(apb_sen_valid)
  );

  // Synchronize crc_error
  ffd_sync ffd_sync_crc_error (
    .i_clk(clk_b),
    .i_rst_n(rst_n_b),
    .i_data(crc_error),
    .o_data(crc_error_synced)
  );

  // Synchronize ss_spi
  ffd_sync ffd_sync_ss_spi (
    .i_clk(clk_b),
    .i_rst_n(rst_n_b),
    .i_data(spi_ss),
    .o_data(spi_ss_synced)
  );

  // Synchronize data SPI to APB
  hds_4_phase #(
    .DATA_WIDTH(DATA_WIDTH)
  ) hds_spi_apb (
    // Sender
    .i_sen_clk(clk_a),
    .i_sen_rst_n(rst_n_a),
    .i_sen_valid(spi_sen_valid),
    .i_sen_data(spi_data),
    .o_sen_ready(spi_sen_ready),
    // Receiver
    .i_rcv_clk(clk_b),
    .i_rcv_rst_n(rst_n_b),
    .i_rcv_ready(apb_rcv_ready),
    .o_rcv_valid(apb_rcv_valid),
    .o_rcv_data(spi_data_synced)
  );

  // Synchronize data APB to SPI
  hds_4_phase #(
    .DATA_WIDTH(DATA_WIDTH)
  ) hds_apb_spi (
    // Sender
    .i_sen_clk(clk_b),
    .i_sen_rst_n(rst_n_b),
    .i_sen_valid(apb_sen_valid),
    .i_sen_data(apb_data),
    .o_sen_ready(apb_sen_ready),
    // Receiver
    .i_rcv_clk(clk_a),
    .i_rcv_rst_n(rst_n_a),
    .i_rcv_ready(spi_rcv_ready),
    .o_rcv_valid(spi_rcv_valid),
    .o_rcv_data(apb_data_synced)
  );

endmodule: top
