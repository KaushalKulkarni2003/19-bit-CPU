module Register_File(
    input clk,
    input rst,
    input WE3,
    input [18:0] WD3,
    input [2:0] A1,
    input [2:0] A2,
    input [2:0] A3,
    output [18:0] RD1,
    output [18:0] RD2
);

reg [18:0] Register [0:7];
always @(posedge clk) begin
    if(WE3)
        Register[A3] <= WD3;
end

assign RD1 = (!rst) ? 19'd0 : Register[A1];
assign RD2 = (!rst) ? 19'd0 : Register[A2];

initial begin
    Register[2] = 19'd5;
    Register[3] = 19'd3;
    Register[5] = 19'd20;
    Register[7] = 19'd40;
    Register[6] = 19'd77;
end

endmodule