module spi_frontend (
    // External interface
    input clk, i_sck, i_cpol, i_cpha, i_order, i_ss, i_mosi,
    output reg o_miso, spi_busy,

    // internal interface
    output o_ss, o_data, o_order,
    input i_busy, i_data
);
    // Synchronize external signals

    reg ss_r, sck_r, mosi_r;

    always @(posedge clk) begin
        ss_r <= i_ss;
        sck_r <= i_sck;
        mosi_r <= i_mosi;
    end

    // Detect rise and fall transient conditions to clk signal
    reg last_sck;
    wire sck_rise, sck_fall;
    assign sck_rise = sck_r & ~last_sck;
    assign sck_fall = ~sck_r & last_sck;

    // Determine sample and change strobes based on i_cpol and i_cpha
    wire leading, trailing, sample_strobe, change_strobe;

    assign leading = ~i_cpol ? sck_rise : sck_fall;
    assign trailing = ~i_cpol ? sck_fall : sck_rise;
    assign sample_strobe = (~i_cpha) ? leading : trailing;
    assign change_strobe = (~i_cpha) ? trailing : leading;

    always @(posedge clk) begin
        last_sck <= sck_r;
        o_data <= (sample_strobe)? i_mosi : o_data;
        o_miso <= (change_strobe & i_busy & ~ss_r)? i_data : o_miso;
        spi_busy <= (change_strobe & i_busy & ~ss_r)? i_busy : spi_busy;
    end

    // o_ss and o_order
    assign o_ss = ~ss_r;
    assign o_order = i_order;

endmodule
