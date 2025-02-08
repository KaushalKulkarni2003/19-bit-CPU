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
);
wire [18:0] PC;
wire [18:0] PC_Next;
wire [18:0] PC_Plus1;

PC_Module PC_Mod(.clk(clk), .rst(rst), .PC(PC), .PC_Next(PC_Next));
PC_Adder PC_Add(.a(PC), .b(19'd1), .c(PC_Plus1));

wire [18:0] Instr;
Instruction_Memory IM(.rst(rst), .A(PC), .RD(Instr));

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

// Register File
wire [18:0] RD1, RD2;
Register_File RF(
    .clk(clk),
    .rst(rst),
    .WE3(RegWrite),
    .WD3(Result),
    .A1(reg_rs1),
    .A2(reg_rs2),
    .A3(reg_rd),
    .RD1(RD1),
    .RD2(RD2)
);

// Main Decoder
wire RegWrite, ALUSrc, MemWrite, ResultSrc, Branch, Jump, Call, Ret;
wire [1:0] ImmSrc, ALUOp;
Main_Decoder MD(
    .Op(opcode),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .Jump(Jump),
    .Call(Call),
    .Ret(Ret),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp)
);

// ALU Decoder
wire [4:0] effective_funct;
assign effective_funct = isR ? funct5 : 5'b00000;
wire [4:0] ALUControl;
ALU_Decoder AD(
    .ALUOp(ALUOp),
    .funct5(),
    .ALUControl(ALUControl)
);

// Sign Extension - I/S/Branch immediate
wire [18:0] imm_extended;
Sign_Extend SE(
    .imm_in(imm_field),
    .imm_out(imm_extended)
);

wire [18:0] alu_in2
Mux Mux_ALU(
    .a(RD2),
    .b(imm_extended),
    .s(ALUSrc),
    .c(alu_in2)
);

// ALU
wire [18:0] ALU_Result;
ALU ALU_inst(
    .A(RD1),
    .B(alu_in2),
    .Result(ALU_Result),
    .ALUControl(ALUControl)
    .Negative()
);

// Data memory
wire [18:0] Mem_Read;
Data_Memory DM(
    .clk(clk),
    .rst(rst),
    .WE(MemWrite),
    .WD(RD2),
    .A(ALU_Result),
    .RD(Mem_Read)
);

// Write Back Multiplexer
wire [18:0] Result;
Mux Mux_Result(
    .a(ALU_Result),
    .b(Mem_Read),
    .s(ResultSrc),
    .c(Result)
);

// PC Modules
wire [18:0] branch_target
PC_Adder PC_Branch(.a(PC), .b(imm_extended), .c(branch_target));

// Jump Target result for JMP/CALL
wire [18:0] jump_target;
assign jump_target = {5'd0, jump_imm};

// Branch conditions
wire branch_taken;
assign branch_taken = (isBEQ && (RD1 == RD2) || (isBNE && (RD1 != RD2)));

endmodule