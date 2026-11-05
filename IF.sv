`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2026 14:39:12
// Design Name: 
// Module Name: IF
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

module IF(input logic clk,
input logic reset,
input logic stall,
input logic and_out,
input logic [31:0] pc_signed_offset,
output logic [31:0] address,
output logic [31:0]pc_new);
logic [31:0] pc_next;
assign pc_new=address+4;
always_comb 
begin 
    if (and_out)
        pc_next = pc_signed_offset;
    else
        pc_next= pc_new;
end
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        address <=32'h0000_0000;
    else if (!stall)
        address <= pc_next;
end
endmodule
