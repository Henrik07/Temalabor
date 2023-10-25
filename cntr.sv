module cntr(
    input clk, nrst, ce,
    output [7:0] q
);

reg [7:0] d;

always@(posedge clk)
	if(~nrst)
            d <= 0;
	else if(ce)
            d <= d + 1;
        else
            d <= d;

assign q = d;

endmodule
