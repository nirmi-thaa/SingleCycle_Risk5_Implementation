`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2026 20:06:42
// Design Name: 
// Module Name: Decoder
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



module decoder(
input logic [31:0] instruction,
output logic [4:0] rs1,
output logic [4:0] rs2,
output logic [4:0] rd,
output logic [6:0] opcode,
output logic [6:0] imm11_5,
output logic [2:0] fn3,
output logic [11:0] imm,
output logic [19:0] imm_uj,
output logic fn7_5
);
assign opcode= instruction[6:0];
assign rd = instruction[11:7];
assign rs1 = instruction[19:15];
assign rs2 =instruction[24:20];
assign fn3= instruction[14:12];

always_comb 
begin
    imm = 12'b0;
    case(opcode)
        // I-type: Load
        7'b0000011: 
        begin
            imm = instruction[31:20];
        end

        // I-type: ALU
        7'b0010011:
         begin
            imm = instruction[31:20];
        end

        // JALR
        7'b1100111:
         begin
            imm = instruction[31:20];
        end

        // S-type: Store
        7'b0100011:
         begin
            imm = {instruction[31:25],
                   instruction[11:7]};
        end

        // B-type: Branch
        7'b1100011: 
        begin
            imm = {instruction[31],
                   instruction[7],
                   instruction[30:25],
                   instruction[11:8]};
        end
        default: begin
            imm = 12'b0;
        end
    endcase
end

always_comb
begin
    imm_uj = 20'b0;
    case(opcode)

        // U-type: LUI and AUIPC
        7'b0110111,
        7'b0010111:
         begin
            imm_uj = instruction[31:12];
        end

        // J-type: JAL
        7'b1101111: 
        begin
            imm_uj = {instruction[31],
                      instruction[19:12],
                      instruction[20],
                      instruction[30:21]};
        end

        default: 
        begin
            imm_uj = 20'b0;
        end
    endcase
end



always_comb begin

    imm11_5 = 7'b0;
    //I type ALU instruction
    if (opcode == 7'b0010011) 
    begin
        imm11_5 = instruction[31:25];
    end
end



always_comb begin

    fn7_5 = 1'b0;
    //R type
    if (opcode == 7'b0110011) 
    begin
        fn7_5 = instruction[30];
    end
end
endmodule
