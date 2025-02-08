module Instruction_Memory(
    input rst,
    input [18:0] A,
    output [18:0] RD
);

reg [18:0] mem [0:127];
assign RD = (!rst) ? 19'd0 : mem[A];

endmodule