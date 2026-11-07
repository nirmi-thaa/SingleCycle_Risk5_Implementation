`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.11.2026 13:59:48
// Design Name: 
// Module Name: register_file
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


module register_file(
input logic [4:0] rs1_sel, rs2_sel,   
input logic reg_write,          
input logic clk,
input logic reset,             
input logic [31:0] wb_data,            
input logic [4:0] rd_sel,            
output logic [31:0] rs1_data, rs2_data  
);
logic [31:0] register [31:0];
assign rs1_data =(rs1_sel == 0) ? 32'b0 : register[rs1_sel];
assign rs2_data = (rs2_sel == 0) ? 32'b0 : register[rs2_sel];

always_ff @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        for(int i=0;i<32;i++)
        begin
        register[i]<=32'b0;
        end
    end
    else if(reg_write && rd_sel!=0)
    begin
        register[rd_sel]<=wb_data;
    end  
end  
endmodule