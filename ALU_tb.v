`timescale 1ns/10ps
module ALU_tb;
	reg	[31:0]	A, B;
	reg 	[4:0]		op;
	wire	[63:0]	Z;
	
ALU uut(
	.A (A),
	.B (B),
	.op (op),
	.Z (Z)
);

initial begin
	A = 16;
	B = 3;
	#10;
	op = 4;
end
endmodule
