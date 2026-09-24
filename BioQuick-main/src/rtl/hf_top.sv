 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 08/13/2025 02:39:53 PM
// Design Name:
// Module Name: hf_top
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


module hf_top#(
    parameter ADDR_WIDTH = 12,    // Largura do endereço
    parameter DATA_WIDTH = 16     // Largura dos dados
)(
    input logic                   clk,
    input logic                   reset,
    input logic                   i_ss,
    input logic                   i_ready,
    input logic [DATA_WIDTH-1:0]  i_data,
    input logic                   i_hds_ack,
    output logic                  o_hds_ready,
    output logic                  o_ack,
    output logic                  o_error,
    output logic [DATA_WIDTH-1:0] o_read_data
    );


    logic pready,read_write,transfer,hds_ready;
    logic [DATA_WIDTH-1:0] data;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] read_data_reg;
    logic [DATA_WIDTH-1:0] read_data_buffer;


    always_comb begin
        if(!reset)begin
            read_data_reg = 0;
            o_hds_ready = 0;
        end
        else begin
            if(pready && !read_write) begin
                read_data_reg = read_data_buffer;
                o_hds_ready = 1;
            end else begin
                if(!i_hds_ack && o_hds_ready)begin
                    o_hds_ready = 1;
                end else begin
                    o_hds_ready = 0;
                end
                read_data_reg = read_data_reg;
            end
        end
        o_read_data = read_data_reg;
    end


    Addresser #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) addresser (
            .clk(clk),
            .reset(reset),
            .i_ss(i_ss),
            .i_ready(i_ready),
            .i_data(i_data),
            .i_PREADY(pready),
            .i_hds_ready(o_hds_ready),
            .o_ack(o_ack),
            .o_rw(read_write),
            .o_addr(addr),
            .o_data(data),
            .o_Transfer(transfer)
    );


    apb #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) apbmaster (
            .PCLK(clk),
            .PRESETN(reset),
            .i_PWRITE(read_write),
            .i_PADDR(addr),
            .i_PWDATA(data),
            .i_PSSTRB(0),
            .i_transfer(transfer),
            .o_PRDATA(read_data_buffer),
            .o_PSLVERR(o_error),
            .o_PREADY(pready)
    );



endmodule
