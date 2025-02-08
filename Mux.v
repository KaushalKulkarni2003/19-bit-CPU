module mux(
    input [18:0] a,
    input [18:0] b,
    input s,
    output [18:0] c;
);

assign c = s? b : a

endmodule