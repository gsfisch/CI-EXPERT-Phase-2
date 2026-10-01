`timescale 1ns / 1ps

//  Module: hds_4_phase_rcv
//
module hds_4_phase_rcv
  /*  package imports  */
  #(
    parameter int DATA_WIDTH = 5'd16
  )(
    input  logic                      i_clk,
    input  logic                      i_rst_n,
    input  logic                      i_ready,
    input  logic                      i_req,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic                      o_valid,
    output logic                      o_ack,
    output logic [DATA_WIDTH - 1 : 0] o_data
  );

  // (* dont_touch = "true" *)
  // logic  ack_dst_d, ack_dst_q;
  // (* dont_touch = "true" *)
  // logic  req_synced;

  // logic  data_valid;

  logic  ack_dst_d, ack_dst_q;
  logic  req_synced;
  //logic  output_ready;

  typedef enum logic {IDLE, WAIT_REQ_DEASSERT} STATE;
  STATE CS, NS;

  //Synchronize the request
  ffd_sync ffd_sync_ack (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_data(i_req),
    .o_data(req_synced)
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
    o_valid = 1'b0;
    ack_dst_d  = 1'b0;
    //data_d = i_data;

    case (CS)
      IDLE: begin
        // Sample the data upon a new request and transition to the next state
        if (req_synced) begin
          o_valid = 1'b1;

          if (i_ready) begin
            NS = WAIT_REQ_DEASSERT;
          end
        end
      end
      WAIT_REQ_DEASSERT: begin
        ack_dst_d = 1'b1;

        if (!req_synced) begin
          ack_dst_d = 1'b0;
          NS = IDLE;
        end
      end
    endcase
  end

  // Filter glitches on ack signal before sending it
  // through the asynchronous channel
  always_ff @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      ack_dst_q <= 1'b0;
    end else begin
      ack_dst_q <= ack_dst_d;
    end
  end

  //assign output_ready = i_ready;
  assign o_data  = i_data;

  // if (BYPASS) begin : gen_bypass
  //   //assign o_valid = data_valid;
  //   assign output_ready = i_ready;
  //   assign o_data  = i_data;
  // end else begin : gen_spill_reg
  //   spill_register #(
  //     .DATA_WIDTH(DATA_WIDTH),
  //     .BYPASS(1'b1),
  //     .FLUSH(1'b0)
  //   ) i_spill_register (
  //     .clk_i(i_clk),
  //     .rst_ni(i_rst_n),
  //     .valid_i(data_valid),
  //     .ready_o(output_ready),
  //     .data_i(i_data),
  //     .valid_o(o_valid),
  //     .ready_i(i_ready),
  //     .data_o(o_data)
  //   );
  // end

  // Output assignments.
  assign o_ack = ack_dst_q;

endmodule: hds_4_phase_rcv
