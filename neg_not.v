module neg_not(
	input wire [31:0]		A,
	input wire				op,
	output wire [63:0]	Z
);
	assign Z = (op == 1) ? ~A+1 : ~A;
endmodule
