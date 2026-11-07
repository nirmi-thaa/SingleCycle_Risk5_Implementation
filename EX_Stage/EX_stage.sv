`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2026 20:25:20
// Design Name: 
// Module Name: EX_stage
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



module EX_stage (
input logic [31:0] rs1_data,
input logic [31:0] rs2_data,
input logic [31:0] imm_out,
input logic [31:0] address,
input logic branch,
input logic alu_src,
input logic fn7_5,
input logic mux_inp,
input logic [2:0] fn3,
input logic [6:0] imm11_5,
input logic [2:0] aluop,
input logic [6:0] opcode,
output logic and_out_ex,
output logic [31:0] alu_out,
output logic [31:0] pc_ex_out
);
//Internal signals
logic [31:0] alu_inp_a;
logic [31:0] alu_inp_b;
logic [4:0]  alu_control_out;
logic zero;
logic [31:0] pc_signed_offset;
assign alu_inp_a = rs1_data;
assign alu_inp_b = (alu_src) ? imm_out : rs2_data;
//Control Unit
ALU_control ALU_CTRL (
.alu_op (aluop),
.fn3 (fn3),
.imm11_5 (imm11_5),
.fn7_5(fn7_5),
.control_out (alu_control_out)
);
// ALU
ALU alu (
.alu_control (alu_control_out),
.rs1_data(alu_inp_a),
.rs2_data(alu_inp_b),
.alu_out(alu_out),
.zero(zero)
);
// PC + immediate offset
assign pc_signed_offset = address + imm_out;

//PC target selection
always_comb
begin
        if (mux_inp)
            pc_ex_out = {alu_out[31:1], 1'b0};  // JALR
        else
            pc_ex_out = pc_signed_offset;
    end

    // Branch / Jump decision
    assign and_out_ex = (branch && zero) ||
                        (opcode == 7'h6F) ||
                        (opcode == 7'h67);

endmodule

