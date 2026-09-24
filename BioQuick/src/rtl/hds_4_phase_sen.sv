`timescale 1ns / 1ps

//  Module: hds_4_phase_sen
//
module hds_4_phase_sen
  /*  package imports  */
  #(
    parameter int DATA_WIDTH = 5'd16
  )(
    input  logic                      i_clk,
    input  logic                      i_rst_n,
    input  logic                      i_valid,
    input  logic                      i_ack,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic                      o_ready,
    output logic                      o_req,
    output logic [DATA_WIDTH - 1 : 0] o_data
  );

  // (* dont_touch = "true" *)
  // logic  req_src_d, req_src_q;
  // (* dont_touch = "true" *)
  // logic [DATA_WIDTH - 1 : 0] data_src_d, data_src_q;
  // (* dont_touch = "true" *)
  // logic  ack_synced;

  logic  req_src_d, req_src_q;
  logic [DATA_WIDTH - 1 : 0] data_src_d, data_src_q;
  logic  ack_synced;

  typedef enum logic[1:0] {IDLE, WAIT_ACK_ASSERT, WAIT_ACK_DEASSERT} STATE;
  STATE CS, NS;

  // Synchronize the ACK
  ffd_sync ffd_sync_ack (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_data(i_ack),
    .o_data(ack_synced)
  );

  always_ff @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      CS <= IDLE;
    end else begin
      CS <= NS;
    end
  end

  // FSM for the 4-phase handshake
  always_comb begin
    NS = CS;
    req_src_d  = 1'b0;
    o_ready    = 1'b0;
    data_src_d = data_src_q;

    case (CS)
      IDLE: begin
        o_ready = 1'b1;

        // Sample a new item when the valid signal is asserted.
        if (i_valid) begin
          NS = WAIT_ACK_ASSERT;
        end
      end
      WAIT_ACK_ASSERT: begin
        req_src_d = 1'b1;
        data_src_d = i_data;

        if (ack_synced) begin
          NS = WAIT_ACK_DEASSERT;
        end
      end
      WAIT_ACK_DEASSERT: begin
        if (!ack_synced) begin
          NS = IDLE;
        end
      end
      default: begin
        NS = IDLE;
      end
    endcase
  end

  // fazer assign para os sinais da FSM

  // Sample the data and the request signal to filter combinational glitches
  always_ff @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      req_src_q  <= 1'b0;
      data_src_q <= '0;
    end else begin
      req_src_q  <= req_src_d;
      data_src_q <= data_src_d;
    end
  end

  // Async output assignments.
  assign o_req = req_src_q;
  assign o_data = data_src_q;

endmodule: hds_4_phase_sen
