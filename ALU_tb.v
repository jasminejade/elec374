`timescale 1ns/10ps
module ALU_tb;
	reg	[31:0]	A, B;
	reg 	[4:0]		opcode;
	wire	[63:0]	Z;
	
ALU uut(
	.A (A),
	.B (B),
	.opcode (opcode),
	.Zlow (Z[31:0]),
	.Zhi (Z[63:32])
);

initial begin
	A = 32'b10010;
	B = 32'b100;
	#10;
	opcode = 5'b01000;
end
endmodule
