module crc #(parameter WIDTH=8)(
    input clk, en, rst, i_bit, i_order,
    input [WIDTH-1:0] i_poly,
    output [WIDTH-1:0] o_crc
);
    reg [WIDTH-1:0] crc_internal;
    wire [WIDTH-1:0] crc_reversed;

    // Reverse output if input order is LSB-first
    assign o_crc = i_order ? crc_reversed : crc_internal;

    // Generate reversed output for LSB-first operation
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin
            assign crc_reversed[i] = crc_internal[WIDTH-1-i];
        end
    endgenerate

    always @(posedge clk) begin
        if (rst) begin
            // TODO: consider setting to `crc_internal <= {WIDTH{1'b1}}`;
            crc_internal <= {WIDTH{1'b0}};
        end else if (en) begin
            crc_internal <= (crc_internal[WIDTH-1] ^ i_bit) ?
                            {crc_internal[WIDTH-2:0], 1'b0} ^ i_poly :
                            {crc_internal[WIDTH-2:0], 1'b0};
        end else begin
            crc_internal <= crc_internal;
        end
    end

endmodule
