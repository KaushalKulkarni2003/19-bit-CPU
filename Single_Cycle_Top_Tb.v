module Single_Cycle_Top_tb();

reg clk=1'b1,rst;

Single_Cycle_Top Single_Cycle_Top(
    .clk(clk),
    .rst(rst)
);

initial begin
    $dumpfile("Single Cycle.vcd");
    $dumpvars(0);
end

always begin
    clk = ~clk;
    #50;
end

initial begin 
    rst <= 1'b0;
    #50;

    rst<= 1'b1;
    #800;
    $finish;
end

endmodule