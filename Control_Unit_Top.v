`include "ALU_Decoder.v"
`include "Main_Decoder.v"

module Control_Unit_Top(
    input [4:0] Op,
    input [4:0] funct5,
    output RegWrite,
    output ALUSrc,
    output MemWrite,
    output ResultSrc,
    output Branch,
    output Jump,
    output Call,
    output Ret,
    output [1:0] ImmSrc,
    output [1:0] ALUOp
);

    wire [1:0] ALUOp;
    Main_Decoder MD(
        .Op(Op),
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
    )

    ALU_Decoder AD(
    ALUOp(ALUOp),
    funct5(funct5),
    ALUControl(ALUControl)
    )

endmodule