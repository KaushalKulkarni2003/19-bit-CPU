module ALU(
    input [18:0] A,
    input [18:0] B,
    output [18:0] Result,
    input [4:0] ALUControl,
    output Negative
);

wire [18:0] Sum, Diff, Prod, Quot;
wire [37:0] mult_full;
wire [18:0] AndOp, OrOp, XorOp, NotOp, Inc, Dec;

assign Sum = A + B;
assign Diff = A - B;
assign mult_full = A*B;
assign Prod = mult_full[18:0];
assign Quot = (B!=0)? (A/B): 19'b0;
assign AndOp = A & B;
assign OrOp = A | B;
assign XorOp = A ^ B;
assign NotOp = ~A;
assign Inc = A + 1;
assign Dec = A -1;


assign Result = (ALUControl == 5'b00000)? Sum:
                (ALUControl == 5'b00001)? Diff:
                (ALUControl == 5'b00010)? Prod:
                (ALUControl == 5'b00011)? Quot:
                (ALUControl == 5'b00100)? Inc:
                (ALUControl == 5'b00101)? Dec:
                (ALUControl == 5'b00110)? AndOp:
                (ALUControl == 5'b00111)? OrOp:
                (ALUControl == 5'b01000)? XorOp:
                (ALUControl == 5'b01001)? NotOp:
                (ALUControl == 5'b01010)? 19'd0: // FFt
                (ALUControl == 5'b01011)? 19'd0: //Encrypt
                (ALUControl == 5'b01100)? 19'd0: //Decrypt
                19'd0;
assign Negative = Result[18];

endmodule

