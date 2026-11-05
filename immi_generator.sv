`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 14:29:09
// Design Name: 
// Module Name: immi_generator
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



module immi_generator(input logic [11:0] immi_input,
input logic [11:0] immi_input_s,
input logic [2:0] fuct3,
input logic [6:0] opcode,
input logic [31:0] immi_input_uj,
output logic [31:0] immi_output);

always_comb begin
immi_output=32'b0;
case(opcode)
7'b0010011,
7'b0000011,
7'b1100111: begin
immi_output={{20{immi_input[11]}},immi_input};
end

7'b0100011: begin
immi_output={{20{immi_input_s[11]}},immi_input_s};
end

7'b1100011: begin
immi_output={{19{immi_input_uj[12]}},immi_input_uj[12:1],1'b0};
end

7'b0110111,
7'b0010111: begin
immi_output={immi_input_uj[31:12],12'b0};
end

7'b1101111: begin
immi_output={{11{immi_input_uj[20]}},immi_input_uj[20:1],1'b0};
end

default: begin
immi_output=32'b0;
end
endcase
end
endmodule

