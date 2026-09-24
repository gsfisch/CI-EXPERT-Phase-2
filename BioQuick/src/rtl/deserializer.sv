module deserializer #(parameter WIDTH=16, OP_LEN=0)(
    input clk, en, dir, i_data,
    output done,
    output reg [WIDTH-1:0] o_data
);
    reg [$clog2(WIDTH):0] count;
    wire [WIDTH-1:0] next_val, rst_val;
    assign next_val = (dir == 0)?   {o_data[WIDTH-2:0], i_data}:
                                    {i_data, o_data[WIDTH-1:1]};
    assign rst_val = (dir == 0)?   {{7{1'b0}}, i_data}:
                                    {i_data, {7{1'b0}}};;
    assign done = (count == 0);

    always @(posedge clk) begin
        if (!en) begin
            o_data <= 0;
            count <= WIDTH-OP_LEN;
        end else if (done) begin
            o_data <= rst_val;
            count <= WIDTH-1;
        end else begin
            o_data <= next_val;
            count <= count - 1;
        end
    end
endmodule
