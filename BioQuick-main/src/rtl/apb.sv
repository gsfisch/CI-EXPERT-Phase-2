`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 08/04/2025 01:34:32 PM
// Design Name:
// Module Name: apb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module apb#(
    parameter ADDR_WIDTH = 12,    // Largura do endereço
    parameter DATA_WIDTH = 16     // Largura dos dados
)(
    input  logic                  PCLK,          // Clock
    input  logic                  PRESETN,       // Active-low reset
    input  logic                  i_PWRITE,        // Write control (1=write, 0=read)
    input  logic [ADDR_WIDTH-1:0] i_PADDR,         // 12-bit address
    input  logic [DATA_WIDTH-1:0] i_PWDATA,        // 16-bit write data
    input  logic [1:0]            i_PSSTRB,        // 2-bit strobe (not used in this implementation)
    input  logic                  i_transfer,      // Transfer initiation signal
    output logic [DATA_WIDTH-1:0] o_PRDATA,
    output logic                  o_PSLVERR,
    output logic                  o_PREADY
    );

    logic [DATA_WIDTH-1:0] PRDATA,PWDATA;
    logic [ADDR_WIDTH-1:0] PADDR;

    //internal wires
    logic PSEL, PENABLE, PWRITE, PSLVERR, PREADY;

    assign o_PSLVERR = PSLVERR; // Transmite o erro do slave para fora
    assign o_PREADY = PREADY; // Trasmite o pready para fora também

    apb_slave_memory #(.ADDR_WIDTH(12), .DATA_WIDTH(16)) slave (
        .PCLK(PCLK),
        .PRESETN(PRESETN),
        .i_PSEL(PSEL),
        .i_PENABLE(PENABLE),
        .i_PWRITE(PWRITE),
        .i_PADDR(PADDR),
        .i_PWDATA(PWDATA),
        .o_PRDATA(PRDATA),
        .o_PREADY(PREADY),
        .o_PSLVERR(PSLVERR)
    );

    apbmaster #(.ADDR_WIDTH(12), .DATA_WIDTH(16)) master (
        .PCLK(PCLK),
        .PRESETN(PRESETN),
        .PWRITE(i_PWRITE),
        .PADDR(i_PADDR),
        .PWDATA(i_PWDATA),
        .PSSTRB(i_PSSTRB),
        .transfer(i_transfer),
        .i_PRDATA(PRDATA),
        .i_PREADY(PREADY),
        .i_PSLVERR(PSLVERR),
        .o_PADDR(PADDR),
        .o_PWDATA(PWDATA),
        .o_PWRITE(PWRITE),
        .o_PENABLE(PENABLE),
        .o_PSEL(PSEL),
        .o_PRDATA(o_PRDATA)
    );

endmodule



