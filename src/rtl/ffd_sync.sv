`timescale 1ns / 1ps

//  Module: ffd_sync
//
module ffd_sync
  (
    input logic   i_clk,
    input logic   i_rst_n,
    input logic   i_data,
    output logic  o_data
  );

  logic [1:0] sync;

  always_ff @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      sync <= '0;
    end else begin
      sync <= {sync[0], i_data};
    end
  end

  assign o_data = sync[1];

endmodule: ffd_sync
