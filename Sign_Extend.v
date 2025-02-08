module Sign_Extend(
    input [7:0] imm_in,
    output [18:0] imm_out
);

assign imm_out = {{11{imm_in[7]}}, imm_in};

endmodule