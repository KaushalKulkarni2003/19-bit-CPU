module Data_Memory(
    input clk,rst
    input WE,
    input [18:0] WD,A,
    output [18:0] RD
);

reg [18:0] mem [0:1023];
always @(posedge clk) begin
    if(WE)
        mem[A] <= WD;
end

assign RD = (!rst) ? 19'd0 : mem[A];

endmodule