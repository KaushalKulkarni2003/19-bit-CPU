`include "PC_Module.v"
`include "PC_Adder.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "ALU_Decoder.v"
`include "Main_Decoder.v"
`include "Data_Memory.v"
`include "Mux.v"

module Single_Cycle_Top(
    input rst,
    input clk
)

wire [18:0] Instr;
Instruction_Memory IM(.rst(rst), .A(PC), .RD(Instr))

wire [2:0] reg_rd, reg_rs1, reg_rs2;
wire [4:0] funct5;
wire [7:0] imm_field;
wire [13:0] jump_imm;


wire [4:0] opcode;
assign opcode = Instr[18:14];
// Instruction Flags
wire isR = (opcode = 5'b00000)
wire isI = (opcode = 5'b00001)
wire isS = (opcode = 5'b00010)
wire isBEQ = (opcode = 5'b00011)
wire isBNE = (opcode = 5'b00100)
wire isJMP = (opcode = 5'b00101)
wire isCALL = (opcode = 5'b00110)
wire isRET = (opcode = 5'b00111)

assign imm_field = (!isR && !isJMP && !isCALL && !isRET) ? Instr[7:0] : 8'd0;
assign reg_rd = isR? Instr[13:11] : (isI ? Instr[13:11]: 3'd0);
assign reg_rs1 = (isR || isI) ? Instr[10:8] : ((isS || isBEQ || isBNE) ? Instr[13:11]: 3'd0);
assign reg_rs2 = isR ? Instr[7:5] : ((isS || isBEQ || isBNE) ? Instr[10:8]: 3'd0);
assign funct5 = isR ? Instr[4:0];

Register_File RF(
    .clk(clk),
    .rst(rst),
    .WE3(),
    .WD3(),
    .A1(),
    .A2(),
    .A3(),
    .RD1(),
    .RD2()
)

endmodule