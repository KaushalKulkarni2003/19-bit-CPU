module PC_Module(
    input clk,
    input rst,
    output [18:0] PC,
    input [18:0] PC_Next
);

reg [18:0] PC_reg;
assign PC = PC_reg;
always @(posedge clk) begin
    if(!rst)
        PC_reg <= 19'd0;
    else
        PC_reg <= PC_Next;
end

endmodule