module TOP (clk, rst, add, sub, mult, en, sel, load, in1, in2, out) ;

input clk, rst;
input add, sub, mult, en, sel ;
input [7:0] load;
input [3:0] in1, in2;
output [7:0] out;

wire [7:0] counter_out, adder_out;


COUNTER U_counter ( .clk(clk), .rst(rst), .en(en), .load(load), .cout(counter_out) );

ADDER4 U_adder4 (.clk(clk), .rst(rst), .add(add), .sub(sub), .mult(mult),
                  .in1(in1), .in2(in2), .out(adder_out) );

assign out = sel ? counter_out : adder_out;

endmodule
