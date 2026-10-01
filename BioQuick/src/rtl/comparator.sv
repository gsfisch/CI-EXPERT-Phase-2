module comparator #(parameter WIDTH=8)(
    input clk,
    input [WIDTH-1:0] i_recv, i_expc,
    output reg o_eq
);

    always @(posedge clk) begin
        o_eq <= (i_recv == i_expc);
    end

endmodule
