module Instruction_Memory(
    input rst,
    input [18:0] A,
    output [18:0] RD
);

reg [18:0] mem [0:127];
assign RD = (!rst) ? 19'd0 : mem[A];

initial begin
        //ADD
        mem[0] = {5'b00000, 3'd1, 3'd2, 3'd3, 5'b00000};
        //LD
        mem[1] = {5'b00001, 3'd4, 3'd5, 8'd10};
        //ST
        mem[2] = {5'b00010, 3'd7, 3'd6, 8'd20};
        //BEQ
        mem[3] = {5'b00011, 3'd2, 3'd2, 8'd3};
        //SUB
        mem[4] = {5'b00000, 3'd1, 3'd2, 3'd3, 5'b00001};
        //BNE
        mem[5] = {5'b00100, 3'd2, 3'd3, 8'b11111110};
        //JMP
        mem[6] = {5'b00101, 14'd8};
        //CALL
        mem[7] = {5'b00110, 14'd10};
        //MUL
        mem[8] = {5'b00000, 3'd1, 3'd2, 3'd3, 5'b00010};
        //RET
        mem[9] = {5'b00111, 14'd0};

end

endmodule