module Data_Memory(
    input clk,
    input rst,
    input WE,
    input [18:0] WD,
    input [18:0] A,
    output [18:0] RD
);

reg [18:0] mem [0:1023];
always @(posedge clk) begin
    if(WE)
        mem[A] <= WD;
end

assign RD = (!rst) ? 19'd0 : mem[A];

initial begin
    mem[30] = 19'd99;
end

endmodule