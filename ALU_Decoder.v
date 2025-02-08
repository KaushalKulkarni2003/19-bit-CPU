module ALU_Decoder(
    input [1:0] ALUOp,
    input [4:0] funct5,
    output [4:0] ALUControl
);

assign ALUControl = (ALUOp == 2'b00) ? funct5 : 5'b00000;

endmodule