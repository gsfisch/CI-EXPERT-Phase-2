`timescale 1ns / 1ps

//  Module: hds_4_phase
//
module hds_4_phase
  /*  package imports  */
  #(
    parameter int DATA_WIDTH = 5'd16
  )(
    // Sender
    input  logic                      i_sen_clk,
    input  logic                      i_sen_rst_n,
    input  logic                      i_sen_valid,
    input  logic [DATA_WIDTH - 1 : 0] i_sen_data,
    output logic                      o_sen_ready,

    // Receiver
    input  logic                      i_rcv_clk,
    input  logic                      i_rcv_rst_n,
    input  logic                      i_rcv_ready,
    output logic                      o_rcv_valid,
    output logic [DATA_WIDTH - 1 : 0] o_rcv_data
  );

  // (* dont_touch = "true" *) logic req;
  // (* dont_touch = "true" *) logic ack;
  // (* dont_touch = "true" *) logic [DATA_WIDTH - 1 : 0] data;

  logic req;
  logic ack;
  logic [DATA_WIDTH - 1 : 0] data;

  // logic sen_ready_d, sen_ready_q;
  // logic rcv_valid_d, rcv_valid_q;

  // The sender in the source domain.
  hds_4_phase_sen #(
    .DATA_WIDTH(DATA_WIDTH)
  ) sender (
    .i_clk    (i_sen_clk),
    .i_rst_n  (i_sen_rst_n),
    .i_data   (i_sen_data),
    .i_valid  (i_sen_valid),
    .i_ack    (ack),
    .o_ready  (o_sen_ready),
    .o_req    (req),
    .o_data   (data)
  );

  // The receiver in the destination domain.
  hds_4_phase_rcv #(
    .DATA_WIDTH(DATA_WIDTH)
  ) receiver (
    .i_clk    (i_rcv_clk),
    .i_rst_n  (i_rcv_rst_n),
    .i_ready  (i_rcv_ready),
    .i_req    (req),
    .i_data   (data),
    .o_valid  (o_rcv_valid),
    .o_ack    (ack),
    .o_data   (o_rcv_data)
  );

  // Sample the data and the request signal to filter combinational glitches
  // always_ff @(posedge i_sen_clk or negedge i_sen_rst_n) begin
  //   if (!i_sen_rst_n) begin
  //     o_sen_ready  <= 1'b0;
  //   end else begin
  //     o_sen_ready  <= sen_ready_d;
  //   end
  // end

  // always_ff @(posedge i_rcv_clk or negedge i_rcv_rst_n) begin
  //   if (!i_rcv_rst_n) begin
  //     o_rcv_valid  <= 1'b0;
  //   end else begin
  //     o_rcv_valid  <= rcv_valid_d;
  //   end
  // end

  // Async output assignments.
  // assign o_sen_ready = sen_ready_q;
  // assign o_rcv_valid = rcv_valid_q;

  // assign o_sen_ready = sen_ready_d;
  // assign o_rcv_valid = rcv_valid_d;

endmodule: hds_4_phase
