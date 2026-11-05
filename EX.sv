`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 15:13:08
// Design Name: 
// Module Name: EX
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


module ex_stage(
input logic [31:0] rs1_data,
input logic [31:0] rs2_data,
input logic [31:0] imm_out,
input logic [31:0] address,
input logic branch,
input logic Alusrc,
input logic funct7_5,
input logic mux_inp,
input logic [2:0] funct3,
input logic [6:0] imm11_5,
input logic [2:0] alu_op,
input logic [6:0] opcode,
output logic and_out_ex,
output logic [31:0] alu_out,
output logic [31:0] pc_ex_out
);

logic [31:0] op2;
logic [4:0] control_out;
logic zero;
logic [31:0] pc_signed_offset;

// ALU operand selection
assign op2=Alusrc?imm_out:rs2_data;

// ALU Control
ALU_Control AC(
.alu_op(alu_op),
.funct3(funct3),
.funct7_5(funct7_5),
.imm11_5(imm11_5),
.control_out(control_out)
);

// ALU
ALU A(
.op1(rs1_data),
.op2(op2),
.control_out(control_out),
.result(alu_out),
.zero(zero)
);

// Branch / Jump target
assign pc_signed_offset=address+imm_out;
assign pc_ex_out=mux_inp?{alu_out[31:1],1'b0}:pc_signed_offset;

// Branch taken logic
assign and_out_ex=(branch&&zero)
                 ||(opcode==7'h6F)
                 ||(opcode==7'h67);

endmodule
