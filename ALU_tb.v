`timescale 1ns/10ps
module ALU_tb;
	reg	[31:0]	A, B;
	reg 	[4:0]		op;
	wire	[63:0]	Z;
	
ALU uut(
	.A (A),
	.B (B),
	.op (op),
	.Zlow (Z[31:0]),
	.Zhi (Z[63:32])
);

initial begin
	A = 3489660929;
	B = 3;
	#10;
	op = 11;
end
endmodule
