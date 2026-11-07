`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2026 19:18:22
// Design Name: 
// Module Name: IF_stage
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


module IF_stage(
input logic clock,
input logic reset,
input logic stall,
input logic and_out,
input logic [31:0] pc_signed_offset,
output logic [31:0] address,
output logic [31:0] pc_new
);
assign pc_new=address+4;
always_ff @(posedge clock or posedge reset)
begin
    if(reset)
        address<=32'h8000_000;
    else if(!stall)
    begin
        if(and_out)
            address<=pc_signed_offset;
        else
            address<=pc_new;
    end
end
endmodule
