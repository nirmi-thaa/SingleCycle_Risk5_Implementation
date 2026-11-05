`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2026 14:45:23
// Design Name: 
// Module Name: ALU
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


module ALU(
input logic [31:0] op1,
input logic [31:0] op2,
input logic [4:0] control_out,
output logic [31:0] result,
output logic zero
);

always_comb
begin
result=32'b0;

case(control_out)

5'b00000: result=op1+op2; 
5'b00001: result=op1-op2; 
5'b00010: result=op1^op2; 
5'b00011: result=op1|op2; 
5'b00100: result=op1&op2; 
5'b00101: result=op1<<op2[4:0]; 
5'b00110: result=op1>>op2[4:0]; 
5'b00111: result=$signed(op1)>>>op2[4:0]; 
5'b01000: result=($signed(op1)<$signed(op2))?32'd1:32'd0; 
5'b01001: result=(op1<op2)?32'd1:32'd0; 
5'b01010: result=(op1==op2)?32'd1:32'd0; 
5'b01011: result=(op1!=op2)?32'd1:32'd0; 
5'b01100: result=($signed(op1)<$signed(op2))?32'd1:32'd0; 
5'b01101: result=($signed(op1)>=$signed(op2))?32'd1:32'd0; 
5'b01110: result=(op1<op2)?32'd1:32'd0; 
5'b01111: result=(op1>=op2)?32'd1:32'd0; 

default: result=32'b0;

endcase
end

assign zero=(result==32'b0);

endmodule

