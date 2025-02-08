module Main_Decoder(
    input [4:0] Op,
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

reg regwrite, alusrc, memwrite,resultsrc,branch,jump,call,ret;
reg [1:0] immsrc;
reg [1:0] alu_op;


always @(*) begin
    case(op)
        5'b00000: begin // R type instructions
            regwrite=1; 
            alusrc=0;
            memwrite=0;
            resultsrc=0;
            branch=0;
            jump=0;
            call=0;
            ret=0;
            immsrc = 2'b00;
            alu_op=2'b00;
        end

        5'b00001: begin // I type instructions
            regwrite=1; 
            alusrc=1;
            memwrite=0;
            resultsrc=1;
            branch=0;
            jump=0;
            call=0;
            ret=0;
            immsrc = 2'b01;
            alu_op=2'b00;
        end

        5'b00010: begin // S type instructions
            regwrite=0; 
            alusrc=1;
            memwrite=1;
            resultsrc=0;
            branch=0;
            jump=0;
            call=0;
            ret=0;
            immsrc = 2'b01;
            alu_op=2'b00;
        end

        5'b00011: begin // BEQ type instructions
            regwrite=0; 
            alusrc=0;
            memwrite=0;
            resultsrc=0;
            branch=1;
            jump=0;
            call=0;
            ret=0;
            immsrc = 2'b01;
            alu_op=2'b00;
        end

        5'b00100: begin // BNE type instructions
            regwrite=1; 
            alusrc=0;
            memwrite=0;
            resultsrc=0;
            branch=1;
            jump=0;
            call=0;
            ret=0;
            immsrc = 2'b01;
            alu_op=2'b00;
        end

        5'b00101: begin // JMP type instructions
            regwrite=0; 
            alusrc=0;
            memwrite=0;
            resultsrc=0;
            branch=0;
            jump=1;
            call=0;
            ret=0;
            immsrc = 2'b10;
            alu_op=2'b00;
        end

        5'b00110: begin // CALL type instructions
            regwrite=0; 
            alusrc=0;
            memwrite=0;
            resultsrc=0;
            branch=0;
            jump=1;
            call=1;
            ret=0;
            immsrc = 2'b10;
            alu_op=2'b00;
        end

        5'b00111: begin // Ret type instructions
            regwrite=1; 
            alusrc=0;
            memwrite=0;
            resultsrc=0;
            branch=0;
            jump=1;
            call=0;
            ret=1;
            immsrc = 2'b00;
            alu_op=2'b00;
        end

        default: begin
            regwrite=0; 
            alusrc=0;
            memwrite=0;
            resultsrc=0;
            branch=0;
            jump=0;
            call=0;
            ret=0;
            immsrc = 2'b00;
            alu_op=2'b00;
        end
    endcase
end

assign RegWrite = regwrite;
assign ALUSrc = alusrc;
assign MemWrite= memwrite;
assign ResultSrc = resultsrc;
assign Branch = branch;
assign Jump = jump;
assign Call = call;
assign Ret = ret;
assign ImmSrc = immsrc;
assign ALUOp = alu_op;


endmodule