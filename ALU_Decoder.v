module ALU_Decoder(
    input [1:0] ALUOp,
    input [4:0] funct,
    output [4:0] ALUControl
);

assign ALUControl = (ALUOp == 2'b00) ? funct : 5'b00000;

endmodule