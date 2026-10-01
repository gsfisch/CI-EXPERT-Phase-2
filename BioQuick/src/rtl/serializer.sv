module serializer #(parameter WIDTH=16, OP_LEN=0)(
    input clk, en, dir,
    input [WIDTH-1:0] i_data,
    output reg o_data,
    output done
);
    reg [$clog2(WIDTH):0] count;
    reg [WIDTH-1:0] shift_reg;
    assign done = (count == 0);

    always @(posedge clk) begin
        if (!en) begin
            shift_reg <= i_data;
            count <= WIDTH-OP_LEN;
            o_data <= 0;
        end else if (done) begin
            o_data <= (dir == 0) ? i_data[WIDTH-1] : i_data[0];
            shift_reg <= (dir == 0) ? {i_data[WIDTH-2:0], 1'b0} : {1'b0, i_data[WIDTH-1:1]};
            count <= WIDTH-1;
        end else begin
            shift_reg <= (dir == 0) ? {shift_reg[WIDTH-2:0], 1'b0} : {1'b0, shift_reg[WIDTH-1:1]};
            count <= count - 1;
            o_data <= (dir == 0) ? shift_reg[WIDTH-1] : shift_reg[0];
        end
    end
endmodule
