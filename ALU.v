module ALU(
	input wire	[31:0]	A, B,
	input wire 	[4:0]		op,
	output reg [31:0] 	Zlow, Zhi
	//output reg	[63:0]	Z
);
	wire [63:0] and_result, or_result, mul_result, div_result, shra_result, add_result, sub_result, neg_result, not_result, ror_result, rol_result, shl_result, shr_result;
	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	add_sub add_instance(A, B, 1, add_result);
	add_sub sub_instance(A, B, 0, sub_result);
	boothmul mul_instance(A, B, mul_result);
	div div_instance(A, B, div_result);
	shr_shl shr_instance(A, B, 1, shr_result);
	shr_shl shl_instance(A, B, 0, shl_result);
	shra shra_instance(A, B, shra_result);
	neg_not neg_instance(A, 1, neg_result);
	neg_not not_instance(A, 0, not_result);
	rotate rol_instance(A, B, 0, rol_result);
	rotate ror_instance(A, B, 1, ror_result);
		
	always @(*) begin
		case(op) //change op code for phase 2, inidividual control signals
			1 : {Zhi, Zlow} = or_result;
			2 : {Zhi, Zlow} = and_result;
			3 : {Zhi, Zlow} = add_result;
			4 : {Zhi, Zlow} = sub_result;
			5 : {Zhi, Zlow} = mul_result;
			6 : {Zhi, Zlow} = div_result;
			7 : {Zhi, Zlow} = shr_result;
			8 : {Zhi, Zlow} = shl_result;
			9 : {Zhi, Zlow} = shra_result;
			10 : {Zhi, Zlow} = neg_result;
			11 : {Zhi, Zlow} = not_result;
			12 : {Zhi, Zlow} = rol_result;
			13 : {Zhi, Zlow} = ror_result;
			default : {Zhi, Zlow} = 64'bZ;
		endcase
	end
endmodule
