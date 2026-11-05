`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 13:44:08
// Design Name: 
// Module Name: Control_unit
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


module Control_unit(input logic [6:0] opcode,
output logic Regwrite,
output logic Alusrc,
output logic Memread,
output logic Memwrite,
output logic MemtoReg,
output logic branch,
output logic jump);

always_comb
begin
Regwrite=1'b0;
Alusrc=1'b0;
Memread=1'b0;
Memwrite=1'b0;
MemtoReg=1'b0;
branch=1'b0;
jump=1'b0;

case(opcode)
7'b0110011: //R 
    begin
    Regwrite=1'b1;
    end
7'b0010011: //I 
    begin
    Regwrite=1'b1;
    Alusrc=1'b1;
    end
7'b0000011: //Load
    begin
    Regwrite=1'b1;
    Alusrc=1'b1;
    Memread=1'b1;
    MemtoReg=1'b1;
    end
7'b0100011: //S 
    begin
    Alusrc=1'b1;
    Memwrite=1'b1;
    end
7'b1100011: //Branch
    begin
    branch=1'b1;
    end
7'b1101111: //JAL
    begin
    Regwrite=1'b1;
    jump=1'b1;
    end
7'b0110111: //LUI
    begin
    Regwrite=1'b1;
    end
7'b0010111: //AUIPC
    begin
    Regwrite=1'b1;
    end

endcase
end
endmodule
