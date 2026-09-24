`timescale 1ns / 1ps

//  Module: wrap_apb
//
module wrap_apb
  /*  package imports  */
  #(
    parameter APB_DATA = 16,
    parameter DATA_WIDTH = 16
  )(
    input   logic                     i_clk,
    input   logic                     i_rst_n,
    input   logic [DATA_WIDTH - 1:0]  i_data,

    output  logic [DATA_WIDTH - 1:0]  o_data,

    // APB sinals
    input   logic                     i_PREADY,
    input   logic                     i_PSLVERR,
    input   logic [APB_DATA - 1:0]    i_PRDATA,

    output  logic                     o_PWRITE,
    output  logic                     o_PSEL0,
    output  logic [APB_DATA - 1:0]    o_PADDR,
    output  logic [APB_DATA - 1:0]    o_PWDATA,

    // Controll signals
    input   logic                     i_crc_error,
    input   logic                     i_ss,

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

  // // APB sinals
  // logic i_PREADY;
  // logic i_PSLVERR;
  // logic [APB_DATA - 1:0] i_PRDATA;
  // logic o_PWRITE;
  // logic o_PSEL0;
  // logic [APB_DATA - 1:0] o_PADDR;
  // logic [APB_DATA - 1:0] o_PWDATA;

  // // Controll signals
  // logic i_crc_error;
  // logic i_ss;

  // // Sync signals
  // logic i_sen_ready;
  // logic i_rcv_valid;
  // logic o_rcv_ready;
  // logic o_sen_valid;

  assign o_data = i_data;

endmodule: wrap_apb
