module spi_top #(parameter CRC_WID=8, DATA_WID=16)(
    // external interface
    input clk, i_sck, i_cpol, i_cpha, i_order, i_ss, i_mosi,
    output o_miso, spi_busy,

    // internal interface
    input [DATA_WID-1:0] i_data,
    output [DATA_WID-1:0] o_data
);

    // Internal wires
    wire [DATA_WID-1:0] buff_pkt_in_o_data, buff_pkt_out_o_data;
    wire [CRC_WID-1:0] buff_crc_detect_o_data, crc_o_crc;
    wire frontend_o_data, frontend_o_order, frontend_o_ss;
    wire buff_crc_detect_done, buff_pkt_in_done, buff_pkt_out_done;
    wire counter_done;
    wire [1:0] counter_o_value;
    wire comparator_o_eq;
    wire serializer_o_data;

    // Instantiate the spi_frontend
    spi_frontend frontend (
        .clk(clk),
        .i_sck(i_sck),
        .i_cpol(i_cpol),
        .i_cpha(i_cpha),
        .i_order(i_order),
        .i_ss(i_ss),
        .i_mosi(i_mosi),
        .o_miso(o_miso),
        .o_data(frontend_o_data),
        .o_order(frontend_o_order),
        .o_ss(frontend_o_ss),
        .i_data(serializer_o_data),
        .i_busy(1'b0), // Temporarily tied off; should connect to actual busy signal if available
        .spi_busy(spi_busy)
    );

    // Instantiate three deserializers
    // buff_crc_detect
    deserializer #(.WIDTH(CRC_WID), .OP_LEN(0)) buff_crc_detect (
        .clk(clk),
        .en(~frontend_o_ss),
        .dir(frontend_o_order),
        .i_data(frontend_o_data),
        .o_data(buff_crc_detect_o_data),
        .done(buff_crc_detect_done)
    );

    // buff_pkt_in
    deserializer #(.WIDTH(DATA_WID), .OP_LEN(0)) buff_pkt_in (
        .clk(clk),
        .en(~frontend_o_ss & (counter_o_value == 2'b01)),
        .dir(frontend_o_order),
        .i_data(frontend_o_data),
        .o_data(buff_pkt_in_o_data),
        .done(buff_pkt_in_done)
    );

    // buff_pkt_out
    deserializer #(.WIDTH(DATA_WID), .OP_LEN(0)) buff_pkt_out (
        .clk(clk),
        .en(~frontend_o_ss & (counter_o_value == 2'b10)),
        .dir(frontend_o_order),
        .i_data(frontend_o_data),
        .o_data(buff_pkt_out_o_data),
        .done(buff_pkt_out_done)
    );

    // Instantiate a counter (UPTO 3)
    counter #(.UPTO(3)) state_counter (
        .clk(clk),
        .rst(frontend_o_ss),
        .incr(buff_crc_detect_done),
        .done(counter_done),
        .value(counter_o_value)
    );

    // Instantiate a crc
    crc #(.WIDTH(CRC_WID)) crc_inst (
        .clk(clk),
        .en(~frontend_o_ss),
        .rst(buff_crc_detect_done),
        .i_bit(frontend_o_data),
        .i_order(frontend_o_order),
        .i_poly(8'h07),
        .o_crc(crc_o_crc)
    );

    // Instantiate a comparator
    comparator #(.WIDTH(CRC_WID)) crc_comparator (
        .clk(clk),
        .i_recv(buff_crc_detect_o_data),
        .i_expc(crc_o_crc),
        .o_eq(comparator_o_eq)
    );

    // Data multiplexing for serializer input
    wire [CRC_WID-1:0] muxed_serializer_input;
    assign muxed_serializer_input = (counter_o_value == 2'b10) ? crc_o_crc : {CRC_WID{1'b0}};

    // Instantiate a serializer module
    serializer #(.WIDTH(CRC_WID), .OP_LEN(0)) serializer_inst (
        .clk(clk),
        .en(~frontend_o_ss & (counter_o_value == 2'b10)),
        .dir(frontend_o_order),
        .i_data(muxed_serializer_input),
        .o_data(serializer_o_data),
        /* verilator lint_off PINCONNECTEMPTY */
        .done()
        /* verilator lint_on PINCONNECTEMPTY */
    );

    // Output data assignment
    assign o_data = buff_pkt_in_o_data;

endmodule //spi_top
