`timescale 1ns / 1ps

//  Module: wrap_spi
//
module wrap_spi
  /*  package imports  */
  #(
    parameter DATA_WIDTH = 16
  )
  (
    input   logic                     i_clk,
    input   logic                     i_rst_n,
    input   logic [DATA_WIDTH - 1:0]  i_data,

    output  logic [DATA_WIDTH - 1:0]  o_data,

    // SPI signals
    input   logic                     i_sck,
    input   logic                     i_cpol,
    input   logic                     i_cpha,
    input   logic                     i_bit_order,
    input   logic                     i_ss,
    input   logic                     i_mosi,

    output  logic                     o_miso,
    output  logic                     o_spi_busy,

    // Controll signals
    output  logic                     o_crc_error,
    output  logic                     o_ss,

    // Sync signals
    input   logic                     i_sen_ready,
    input   logic                     i_rcv_valid,

    output  logic                     o_rcv_ready,
    output  logic                     o_sen_valid
  );

  // logic i_clk;
  // logic i_rst_n;
  // logic [DATA_WIDTH - 1:0] i_data;
  // logic [DATA_WIDTH - 1:0] o_data;

  // // SPI signals
  // logic i_sck;
  // logic i_cpol;
  // logic i_cpha;
  // logic i_bit_order;
  // logic i_ss;
  // logic i_mosi;
  // logic o_miso;
  // logic o_spi_busy;

  // // Controll signals
  // logic o_crc_error;
  // logic o_ss;

  // // Sync signals
  // logic i_sen_ready;
  // logic i_rcv_valid;
  // logic o_rcv_ready;
  // logic o_sen_valid;

  assign o_data = i_data;

endmodule: wrap_spi
