module counter #(parameter UPTO = 3)(
    input clk, rst, incr,
    output done
);
    reg [$clog2(UPTO):0] counter;
    assign done = (counter == 0);

    always @(posedge clk) begin
        if (done && incr)
            counter <= UPTO-1;
        else if (rst || done)
            counter <= UPTO;
        else if (incr)
            counter <= counter - 1;
    end
endmodule
