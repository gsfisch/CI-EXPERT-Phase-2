module COUNTER (clk, rst, en, load, cout) ;

input clk, rst, en;
input [7:0] load;
output [7:0] cout;
reg [7:0] cout;

always @(posedge clk or negedge rst)
if (!rst)
cout = 0;
else if (en)
cout = load;
else
cout = cout + 1;

endmodule
