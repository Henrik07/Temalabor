`timescale 1ns / 1ps

module tb_8bcntr;

reg clk, nrst, ce;
wire [7:0] q;
wire [7:0] d;

cntr uut(
	.clk(clk),
	.nrst(nrst),
	.ce(ce),
	.q(q)
);

initial begin
	clk=1;
	nrst=0;
	ce=0;
	#20;
	nrst=1;
	#20;
	ce=1;
end

always #10 clk = ~clk;

endmodule
