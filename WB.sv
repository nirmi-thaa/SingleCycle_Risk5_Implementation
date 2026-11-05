`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2026 14:49:24
// Design Name: 
// Module Name: WB
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



module WB(
input logic [31:0] alu_result,
input logic [31:0] mem_data,
input logic MemtoReg,
output logic [31:0] wb_data
);

always_comb
begin
    if(MemtoReg)
        wb_data=mem_data;
    else
        wb_data=alu_result;
end

endmodule
