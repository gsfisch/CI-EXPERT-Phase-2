`timescale 1ns / 1ps

//  Module: spill_register
//
module spill_register
  /*  package imports  */
  #(
    parameter int DATA_WIDTH = 4'd8,
    parameter bit BYPASS = 1'b0,
    parameter bit FLUSH = 1'b0
  )(
    input  logic clk_i,
    input  logic rst_ni,
    input  logic valid_i,
    input  logic ready_i,
    input  logic [DATA_WIDTH - 1 : 0] data_i,
    output logic ready_o,
    output logic valid_o,
    output logic [DATA_WIDTH - 1 : 0] data_o
  );

  if (BYPASS) begin : gen_bypass
    assign valid_o = valid_i;
    assign ready_o = ready_i;
    assign data_o  = data_i;
  end else begin : gen_spill_reg
    // The A register.
    logic [DATA_WIDTH - 1 : 0] a_data_q;
    logic a_full_q;
    logic a_fill, a_drain;

    always_ff @(posedge clk_i or negedge rst_ni) begin : ps_a_data
      if (!rst_ni) begin
        a_data_q <= '0;
      end else if (a_fill) begin
        a_data_q <= data_i;
      end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin : ps_a_full
      if (!rst_ni) begin
        a_full_q <= 0;
      end else if (a_fill || a_drain) begin
        a_full_q <= a_fill;
      end
    end

    // The B register.
    logic [DATA_WIDTH - 1 : 0] b_data_q;
    logic b_full_q;
    logic b_fill, b_drain;

    always_ff @(posedge clk_i or negedge rst_ni) begin : ps_b_data
      if (!rst_ni) begin
        b_data_q <= '0;
      end else if (b_fill) begin
        b_data_q <= a_data_q;
      end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin : ps_b_full
      if (!rst_ni) begin
        b_full_q <= 0;
      end else if (b_fill || b_drain) begin
        b_full_q <= b_fill;
      end
    end

    // Fill the A register when the A or B register is empty. Drain the A register
    // whenever it is full and being filled, or if a flush is requested.
    assign a_fill = valid_i && ready_o && (!FLUSH);
    assign a_drain = (a_full_q && !b_full_q) || FLUSH;

    // Fill the B register whenever the A register is drained, but the downstream
    // circuit is not ready. Drain the B register whenever it is full and the
    // downstream circuit is ready, or if a flush is requested.
    assign b_fill = a_drain && (!ready_i) && (!FLUSH);
    assign b_drain = (b_full_q && ready_i) || FLUSH;

    // We can accept input as long as register B is not full.
    // Note: FLUSH and valid_i must not be high at the same time,
    // otherwise an invalid handshake may occur
    assign ready_o = !a_full_q || !b_full_q;

    // The unit provides output as long as one of the registers is filled.
    assign valid_o = a_full_q | b_full_q;

    // We empty the spill register before the slice register.
    assign data_o = b_full_q ? b_data_q : a_data_q;
  end

endmodule: spill_register
