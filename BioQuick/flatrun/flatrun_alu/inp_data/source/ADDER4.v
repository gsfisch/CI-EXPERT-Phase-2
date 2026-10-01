module ADDER4 (clk, rst, add, sub, mult, in1, in2, out );

input clk, rst, add, sub, mult;
input [3:0] in1, in2 ;
output [7:0] out;
reg [7:0] out;

always @(posedge clk or negedge rst)
begin
 if (!rst) 
 out = 0;
 else
   if (mult)
    out = in1 * in2;
   else if (add) 
    out = in1 + in2;
   else if (sub)
    out = in1 - in2;
 end

endmodule
