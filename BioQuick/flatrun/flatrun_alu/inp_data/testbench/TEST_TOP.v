`timescale 1ns/1ps

module TEST_TOP;

reg clk, rst, add, sub, mult, en, sel ;
reg [7:0] load ;
reg [3:0] in1, in2 ;
wire [7:0] out;



TOP U_TOP ( .clk(clk), .rst(rst), .add(add), .sub(sub), .mult(mult), .en(en),
            .sel(sel), .load(load), .in1(in1), .in2(in2), .out(out) );


initial
 begin
 clk = 0;
 forever #5 clk = ~clk;
 end

initial
 begin
 rst = 0;
 add = 0;
 sub = 0;
 mult = 0;
 en = 0;
 sel = 0;
 load = 0;
 in1 = 0;
 in2 = 0;
 repeat (2) @(negedge clk) ;
 rst = 1;
 repeat (2) @(negedge clk) ;
 rst = 0;
 @(negedge clk) ; 
 rst = 1;
 //test counter
 sel = 1;
 load = 8'b00010001;
 repeat (100) @(negedge clk);
 en = 1;
 @(negedge clk);
 en = 0;
 repeat (10) @(negedge clk);
//test add
 add = 1;
 sel = 0;
 en  = 0;
 load = 8'bZZZZZZZZ;
 in1 = 4'b0001;
 in2 = 4'b0001;
 @(negedge clk);
 in1 = 4'b1001;
 in2 = 4'b0011;
 @(negedge clk);
 in1 = 4'b1111;
 in2 = 4'b1111;
 @(negedge clk);
 in1 = 4'b1111;
 in2 = 4'b0001;
 @(negedge clk);
 add = 0;
 sub = 1;
 in1 = 4'b0001;
 in2 = 4'b0001;
 @(negedge clk);
 in1 = 4'b1111;
 in2 = 4'b1001;
 @(negedge clk);
 in1 = 4'b1101;
 in2 = 4'b0111;
//test multiplier
 @(negedge clk);
 add = 0;
 sub = 0;
 mult = 1;
 in1 = 4'b0011;
 in2 = 4'b0001;
 @(negedge clk);
 in1 = 4'b1111;
 in2 = 4'b0111;
 @(negedge clk);
 in1 = 4'b1000;
 in2 = 4'b1011;
 @(negedge clk);
 in1 = 4'b1111;
 in2 = 4'b1111;
 @(negedge clk);

 end

initial
 begin
 $vcdpluson;
 #10000 $vcdplusoff;
        $finish;
 end

`ifdef sdf
initial $sdf_annotate ("../out_data/post_layout/TOP_final.sdf", TEST_TOP.U_TOP);
`endif

endmodule
  
