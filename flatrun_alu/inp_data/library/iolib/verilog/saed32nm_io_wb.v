module A1825(PADIO,VDDIO,VDD,VSSIO,VSS,CORE);

inout PADIO;
inout CORE;
inout VDDIO;
inout VDD;
inout VSSIO;
inout VSS;

endmodule


module AR1825(PADIO,VDDIO,VDD,VSSIO,VSS,CORE);

inout CORE;
inout PADIO;
inout VDDIO;
inout VDD;
inout VSSIO;
inout VSS;

endmodule




module AVDD_NS(VDD,VSSIO,AVDD,AVDDPAD,VSS);

inout VDD;
inout AVDD;
inout AVDDPAD;
inout VSSIO;
inout VSS;

endmodule

module AVDD_EW(VDD,VSSIO,AVDD,AVDDPAD,VSS);

inout VDD;
inout AVDD;
inout AVDDPAD;
inout VSSIO;
inout VSS;

endmodule

module AVSS_NS(VDDIO,VDD,AVSS,AVSSPAD,VSSIO,VSS);

inout VDDIO;
inout VDD;
inout AVSS;
inout AVSSPAD;
inout VSSIO;
inout VSS;

endmodule

module AVSS_EW(VDDIO,VDD,AVSS,AVSSPAD,VSSIO,VSS);

inout VDDIO;
inout VDD;
inout AVSS;
inout AVSSPAD;
inout VSSIO;
inout VSS;

endmodule


module B12I1025_NS(PADIO,VSS,EN,VDDIO,PULL_UP,VDD,VSSIO,DOUT,PULL_DOWN,DIN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input EN;
inout VDDIO;
input PULL_UP;
inout VDD;
inout VSSIO;
output DOUT;
input PULL_DOWN;
input DIN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B12I1025_EW(PADIO,VSS,EN,VDDIO,PULL_UP,VDD,VSSIO,DOUT,PULL_DOWN,DIN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input EN;
inout VDDIO;
input PULL_UP;
inout VDD;
inout VSSIO;
output DOUT;
input PULL_DOWN;
input DIN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B12ISH1025_NS(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B12ISH1025_EW(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B16I1025_NS(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B16I1025_EW(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B16ISH1025_NS(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B16ISH1025_EW(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule



module B4I1025_NS (PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule



module B4I1025_EW(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B4ISH1025_NS(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B4ISH1025_EW(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B8I1025_NS(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B8I1025_EW(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule

module B8ISH1025_NS(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module B8ISH1025_EW(PADIO,VSS,PULL_UP,VDDIO,EN,VDD,VSSIO,DOUT,DIN,PULL_DOWN,R_EN);

input R_EN;
inout PADIO;
inout VSS;
input PULL_UP;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
output DOUT;
input DIN;
input PULL_DOWN; 

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module BONDPAD(PADIO,VSS,VDDIO,VDD,VSSIO);

inout PADIO;
inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule

module BREAKCORE(VSS,VDDIO,VDD1,VSS1,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD1;
inout VSS1;
inout VDD;
inout VSSIO;

endmodule


module BREAKIO(VSS,VDDIO,VDDIO1,VDD,VSSIO,VSSIO1);

inout VDDIO1;
inout VSSIO1;
inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module CAPCORNER(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module CIOVDDIOVSS_NS(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module CIOVDDIOVSS_EW(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module CORNER(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module CVDDVSS_NS(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module CVDDVSS_EW(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module D12I1025_NS(PADIO,VSS,EN,VDDIO,VDD,VSSIO,DIN);

inout PADIO;
inout VSS;
input EN;
inout VDDIO;
inout VDD;
inout VSSIO;
input DIN; 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module D12I1025_EW(PADIO,VSS,EN,VDDIO,VDD,VSSIO,DIN);

inout PADIO;
inout VSS;
input EN;
inout VDDIO;
inout VDD;
inout VSSIO;
input DIN; 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module D16I1025_NS(PADIO,VSS,VDDIO,EN,VDD,VSSIO,DIN);

inout PADIO;
inout VSS;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
input DIN;

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .pde     ( PULL_DOWN ),
		   .pue     ( PULL_UP ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module D16I1025_EW(PADIO,VSS,VDDIO,EN,VDD,VSSIO,DIN);

inout PADIO;
inout VSS;
inout VDDIO;
input EN;
inout VDD;
inout VSSIO;
input DIN;

PU_PD PU_PD  (
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   ); 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule



module D4I1025_NS(PADIO,VSS,EN,VDDIO,VDD,VSSIO,DIN);

inout PADIO;
inout VSS;
input EN;
inout VDDIO;
inout VDD;
inout VSSIO;
input DIN; 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module D4I1025_EW(PADIO,VSS,EN,VDDIO,VDD,VSSIO,DIN);

inout PADIO;
inout VSS;
input EN;
inout VDDIO;
inout VDD;
inout VSSIO;
input DIN; 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule

module D8I1025_NS(PADIO,VSS,EN,VDDIO,VDD,VSSIO,DIN);

inout PADIO;
inout VSS;
input EN;
inout VDDIO;
inout VDD;
inout VSSIO;
input DIN; 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module D8I1025_EW(PADIO,VSS,EN,VDDIO,VDD,VSSIO,DIN);

inout PADIO;
inout VSS;
input EN;
inout VDDIO;
inout VDD;
inout VSSIO;
input DIN; 

DRIVER DRIVER  (
		   .DIN     ( DIN ),
		   .EN      ( EN ),
		   .pad     ( PADIO ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module DIOVSSVSS(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER01(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER1(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER10(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER15(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER20(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER35(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER40(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER5(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module FILLER50(VSS,VDDIO,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module I1025_NS(PADIO,VSS,VDDIO,VDD,R_EN,VSSIO,DOUT);

input PADIO;
inout VSS;
inout VDDIO;
inout VDD;
input R_EN;
inout VSSIO;
output DOUT; 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module I1025_EW(PADIO,VSS,VDDIO,VDD,R_EN,VSSIO,DOUT);

input PADIO;
inout VSS;
inout VDDIO;
inout VDD;
input R_EN;
inout VSSIO;
output DOUT; 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module IOVDD_NS(VSS,VDDIO,VDD,VSSIO,VDDIOPAD);

inout VSS;
inout VDDIO;
inout VDDIOPAD;
inout VDD;
inout VSSIO;

endmodule


module IOVDD_EW(VSS,VDDIO,VDD,VSSIO,VDDIOPAD);

inout VSS;
inout VDDIO;
inout VDDIOPAD;
inout VDD;
inout VSSIO;

endmodule



module IOVSS_NS(VSS,VDDIO,VSSIOPAD,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VSSIOPAD;
inout VDD;
inout VSSIO;

endmodule


module IOVSS_EW(VSS,VDDIO,VSSIOPAD,VDD,VSSIO);

inout VSS;
inout VDDIO;
inout VSSIOPAD;
inout VDD;
inout VSSIO;

endmodule

module ISH1025_NS(PADIO,VSS,VDDIO,VDD,R_EN,VSSIO,DOUT);

input PADIO;
inout VSS;
inout VDDIO;
inout VDD;
input R_EN;
inout VSSIO;
output DOUT; 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module ISH1025_EW(PADIO,VSS,VDDIO,VDD,R_EN,VSSIO,DOUT);

input PADIO;
inout VSS;
inout VDDIO;
inout VDD;
input R_EN;
inout VSSIO;
output DOUT; 

RECEIVER RECEIVER (
		   .pad     ( PADIO ),
		   .EN      ( R_EN ),
		   .DOUT    ( DOUT ),
		   .VDD     ( VDD ),
		   .VSS     ( VSS ),
		   .VDDIO   ( VDDIO ),
		   .VSSIO   ( VSSIO )
		   );

endmodule


module VDD_NS(VSS,VDDIO,VDD,VSSIO,VDDPAD);

inout VDDPAD;
inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule


module VDD_EW(VSS,VDDIO,VDD,VSSIO,VDDPAD);

inout VDDPAD;
inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;

endmodule

module VSS_NS(VSS,VDDIO,VDD,VSSIO,VSSPAD);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;
inout VSSPAD;

endmodule


module VSS_EW(VSS,VDDIO,VDD,VSSIO,VSSPAD);

inout VSS;
inout VDDIO;
inout VDD;
inout VSSIO;
inout VSSPAD;

endmodule

//----------Subcircuits----------//


module INPUT_BUFFER (
	pad,
	EN,
	DOUT,
	VDD,
	VSS,
	VDDIO,
	VSSIO
);

input  pad;
output DOUT;
input  EN;
inout  VDD;
inout  VSS;
inout  VDDIO;
inout  VSSIO;
			
reg    DOUT;

wire power_valid = ( VDD == 1'b1 ) && ( VSS == 1'b0 ) && ( VDDIO == 1'b1 ) && ( VSSIO == 1'b0 );

always @( power_valid or pad or EN )
begin
	if ( !power_valid || ( pad === 1'bx ) || ( EN === 1'bx ) || ( EN === 1'bz ))
		DOUT = 1'bx;
	else
		if (EN && pad === 1'bz)
			DOUT = 1'bx;
		else
			DOUT = pad;
		if (!EN)
		DOUT = 1'b0;
end
			
endmodule

module RECEIVER (
	pad,
	EN,
	DOUT,
	VDD,
	VSS,
	VDDIO,
	VSSIO
);

inout  pad;
output DOUT;
input  EN;
inout  VDD;
inout  VSS;
inout  VDDIO;
inout  VSSIO;
			
reg    DOUT;

wire power_valid = ( VDD == 1'b1 ) && ( VSS == 1'b0 ) && ( VDDIO == 1'b1 ) && ( VSSIO == 1'b0 );

always @( power_valid or pad or EN )
begin
	if ( !power_valid || ( pad === 1'bx ) || ( EN === 1'bx ) || ( EN === 1'bz ))
		DOUT = 1'bx;
	else
		if (EN && pad === 1'bz)
			DOUT = 1'bx;
		else
			DOUT = pad;
		if (!EN)
		DOUT = 1'b0;
end
			
endmodule

module DRIVER (
	DIN,
	EN,
	pad,
	VDD,
	VSS,
	VDDIO,
	VSSIO
);

input  DIN;
input  EN;
inout  pad;
inout  VDD;
inout  VSS;
inout  VDDIO;
inout  VSSIO;
	
reg    pad_driver;
wire power_valid = ( VDD == 1'b1 ) && ( VSS == 1'b0 ) && ( VDDIO == 1'b1 ) && ( VSSIO == 1'b0 );

nmos i1 (pad, pad_driver, 1'b1);

always @( power_valid or DIN or EN )
begin
	if ( !power_valid)
		pad_driver = 1'bx;
	else
		if ( DIN === 1'bx || !EN)
			pad_driver = 1'bz;
		else
			pad_driver = DIN;
end

endmodule

module PU_PD (
	pad,
	pue,
	pde,
	VDD,
	VSS,
	VDDIO,
	VSSIO
	);

inout  pad;
inout  VDD;
inout  VSS;
inout  VDDIO;
inout  VSSIO;
input  pde;
input  pue;
	
not i1 (not_pde, pde);
not i2 (not_pue, pue);
and i3 (pu_EN, not_pde, pue);
and i4 (pd_EN, pde, not_pue);

bufif1 (weak1, highz0) weakpu (pad, 1'b1, pu_EN);
bufif1 (highz1, weak0) weakpd (pad, 1'b0, pd_EN);

endmodule	
