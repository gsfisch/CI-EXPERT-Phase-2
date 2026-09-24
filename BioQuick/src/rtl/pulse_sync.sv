//  Module: pulse_sync
//
module pulse_sync
  (
    input logic   i_clk_s,
    input logic   i_rst_s,
    input logic   i_clk_f,
    input logic   i_rst_f,
    input logic   i_data,
    output logic  o_data
  );

  logic pulse_mux;
  logic pulse_mux_sync;
  logic ffd;

  ffd_sync ffd_sync_inst (
    .i_clk(i_clk_f),
    .i_rst_n(i_rst_f),
    .i_data(pulse_mux),
    .o_data(pulse_mux_sync)
  );

  always_ff @(posedge i_clk_s or negedge i_rst_s) begin
    if (i_rst_s  == 1'b0) begin
      pulse_mux <= 1'b0;
    end else begin
      if (i_data == 1'b1) begin
        pulse_mux <= ~pulse_mux;
      end else begin
        pulse_mux <= pulse_mux;
      end
    end
  end

  always_ff @(posedge i_clk_f or negedge i_rst_f) begin
    if (i_rst_f == 1'b0) begin
      ffd <= 1'b0;
    end else begin
      ffd <= pulse_mux_sync;
    end
  end

  assign o_data = pulse_mux_sync ^ ffd;

endmodule: pulse_sync
