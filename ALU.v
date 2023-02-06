module ALU(
	input wire	[31:0]	A, B,
	input wire 	[4:0]		op,
	output reg	[63:0]	Z
);
	reg [31:0] ZHi, ZLow;
	wire [31:0] and_result, or_result, add_result, sub_result, mul_result;
	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	add_sub add_instance(A, B, 1, add_result);
	add_sub sub_instance(A, B, 0, sub_result);
	boothmul mul_instance(A, B, mul_result);
	
	//Z = {ZHi, ZLow};
	
	always @(*) begin
		case(op)
			0 : Z = or_result;
			1 : Z = and_result;
			2 : Z = add_result;
			3 : Z = sub_result;
			4 : Z = mul_result;
			//	...
			default : Z = 64'bZ;
		endcase
	end
endmodule
