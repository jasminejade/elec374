module add_sub(
	input wire [31:0]		A, B,
	input wire				op,
	output wire [63:0]	Z
);
	assign Z = (op == 1) ? A+B : A-B;
endmodule
