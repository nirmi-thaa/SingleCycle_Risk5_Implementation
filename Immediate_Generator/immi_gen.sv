`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2026 20:18:39
// Design Name: 
// Module Name: immi_gen
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



module imm_generator(
input logic [11:0] imm_input,
input logic [2:0] fn3,
input logic [6:0] opcode,
input logic [19:0] imm_input_uj,
output logic [31:0] imm_output
);

always_comb
begin
    case(opcode)

        // Branch
        7'b1100011:
        begin
            imm_output = {{20{imm_input[11]}}, imm_input} << 1;
        end

        // JAL
        7'b1101111:
        begin
            imm_output = {{12{imm_input_uj[19]}}, imm_input_uj} << 1;
        end

        // LUI and AUIPC
        7'b0110111,
        7'b0010111:
        begin
            imm_output = {imm_input_uj, 12'b0};
        end

        // JALR
        7'b1100111:
        begin
            imm_output = {{20{imm_input[11]}}, imm_input};
        end

        // I-type ALU
        7'b0010011:
        begin
            case(fn3)
                // Shift instructions
                3'b001,
                3'b101:
                begin
                    imm_output = {27'b0, imm_input[4:0]};
                end

                // Other I-type ALU instructions
                default:
                begin
                    imm_output = {{20{imm_input[11]}}, imm_input};
                end
            endcase
        end

        default:
        begin
            imm_output = {{20{imm_input[11]}}, imm_input};
        end
    endcase
end
endmodule
