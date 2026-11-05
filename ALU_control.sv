`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 15:20:16
// Design Name: 
// Module Name: ALU_control
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



module ALU_Control (input  logic [2:0] alu_op,
input  logic [2:0] funct3,
input  logic funct7_5,
input  logic [6:0] imm11_5,
output logic [4:0] control_out
);
always_comb begin
control_out = 5'b00000;
case (alu_op)
3'b000: begin
case (funct3)
3'b000: begin
if (funct7_5)
control_out = 5'b00001; 
else
control_out = 5'b00000; 
end
3'b001: control_out = 5'b00101; 
3'b010: control_out = 5'b01000; 
3'b011: control_out = 5'b01001; 
3'b100: control_out = 5'b00010; 
3'b101: begin
if (funct7_5)
control_out = 5'b00111; 
else
control_out = 5'b00110; 
end

3'b110: control_out = 5'b00011; 
3'b111: control_out = 5'b00100; 

default: control_out = 5'b00000;
endcase
end

3'b001: begin
case (funct3)
3'b000: control_out = 5'b00000; 
3'b010: control_out = 5'b01000; 
3'b011: control_out = 5'b01001; 
3'b100: control_out = 5'b00010; 
3'b110: control_out = 5'b00011; 
3'b111: control_out = 5'b00100; 
3'b001: control_out = 5'b00101; 
3'b101: begin
if (imm11_5 == 7'b0100000)
control_out = 5'b00111; 
else
control_out = 5'b00110; 
end

default: control_out = 5'b00000;
endcase
end

3'b010,
3'b011: begin
control_out = 5'b00000; 
end

3'b100: begin
case (funct3)
3'b000: control_out = 5'b01010; 
3'b001: control_out = 5'b01011; 
3'b100: control_out = 5'b01100; 
3'b101: control_out = 5'b01101; 
3'b110: control_out = 5'b01110; 
3'b111: control_out = 5'b01111; 
default: control_out = 5'b00000;
endcase
end
3'b110: begin
control_out = 5'b00000;
end
default: begin
control_out = 5'b00000;
end
endcase
end

endmodule

