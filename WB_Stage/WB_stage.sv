`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2026 20:30:36
// Design Name: 
// Module Name: WB_stage
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



module WB_stage (
input logic [31:0] mem_out,
input logic [31:0] alu_out,
input logic [31:0] return_addr,
input logic [31:0] imm_out,
input logic [31:0] pc_signed_offset,
input logic [1:0]  memtoreg,
input logic [6:0]  opcode_out_d,
output logic [31:0] wb_data
);

always_comb 
begin
    wb_data = alu_out;
    case (memtoreg)
        // ALU result
        2'b00: 
        begin
            wb_data = alu_out;
        end
        // Data memory output
        2'b01: 
        begin
            wb_data = mem_out;
        end
        // Select based on opcode
        2'b10: 
        begin
            case (opcode_out_d)
                // JAL
                7'b1101111:
                    wb_data = return_addr;
                // JALR
                7'b1100111:
                    wb_data = return_addr;
                // LUI
                7'b0110111:
                    wb_data = imm_out;
                // AUIPC
                7'b0010111:
                    wb_data = pc_signed_offset;
                // Other instructions
                default:
                    wb_data = alu_out;
            endcase
        end
        // Default ALU result
        2'b11: 
        begin
            wb_data = alu_out;
        end

        default: 
        begin
            wb_data = alu_out;
        end
    endcase
end
endmodule

