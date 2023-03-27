module ALU(
	input						IncPC, br_flag,
	input wire	[31:0]	A, B,
	input wire 	[4:0]		opcode,
	output reg [31:0] 	Zlow, Zhi, PC
);
	parameter LD = 5'b00000, LDi = 5'b00001, ST = 5'b00010, ADD = 5'b00011, SUB = 5'b00100, AND = 5'b00101, OR = 5'b00110, SHR = 5'b00111, 
					SHRA = 5'b01000, SHL = 5'b01001, ROR = 5'b01010, ROL = 5'b01011, ADDi = 5'b01100, ANDi = 5'b01101, ORi = 5'b01110, 
					MUL = 5'b01111, DIV = 5'b10000, NEG = 5'b10001, NOT = 5'b10010, BRANCH = 5'b10011, JR = 5'b10100, JAL = 5'b10101,
					IN = 5'b10110, OUT = 5'b10111, MFHI = 5'b11000, MFLO = 5'b11001, NOP = 5'b11010, HALT = 5'b11011;
	
	wire [63:0] and_result, or_result, mul_result, div_result, shra_result, add_result, sub_result, 
					neg_result, not_result, ror_result, rol_result, shl_result, shr_result;
	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	add_sub add_instance(A, B, 1, add_result);
	add_sub sub_instance(A, B, 0, sub_result);
	boothmul mul_instance(A, B, mul_result);
	div div_instance(A, B, div_result);
	shr_shl shr_instance(A, B, 1, shr_result);
	shr_shl shl_instance(A, B, 0, shl_result);
	shra shra_instance(A, B, shra_result);
	neg_not neg_instance(B, 1, neg_result);
	neg_not not_instance(B, 0, not_result);
	rotate rol_instance(A, B, 0, rol_result);
	rotate ror_instance(A, B, 1, ror_result);
		
	always @(*) begin
		if (IncPC) PC <= B + 1;
		case(opcode)
			LD, LDi	: {Zhi, Zlow} <= add_result;
			ST			: {Zhi, Zlow} <= add_result;
			OR, ORi	: {Zhi, Zlow} <= or_result;
			AND, ANDi: {Zhi, Zlow} <= and_result;
			ADD, ADDi: {Zhi, Zlow} <= add_result;
			SUB		: {Zhi, Zlow} <= sub_result;
			MUL		: {Zhi, Zlow} <= mul_result;
			DIV		: {Zhi, Zlow} <= div_result;
			SHR		: {Zhi, Zlow} <= shr_result;
			SHL		: {Zhi, Zlow} <= shl_result;
			SHRA		: {Zhi, Zlow} <= shra_result;
			NEG		: {Zhi, Zlow} <= neg_result;
			NOT		: {Zhi, Zlow} <= not_result;
			ROL		: {Zhi, Zlow} <= rol_result;
			ROR		: {Zhi, Zlow} <= ror_result;
			BRANCH	: begin
							{Zhi, Zlow} <= 64'b0;
							if(br_flag==1) PC <= add_result;
						end
			JR, JAL	: PC <= B;
			IN			: {Zhi, Zlow} <= 64'b0;
			OUT 		: {Zhi, Zlow} <= 64'b0;
			MFHI		: {Zhi, Zlow} <= 64'b0;
			MFLO		: {Zhi, Zlow} <= 64'b0;
			NOP		: {Zhi, Zlow} <= 64'b0;
			HALT		: {Zhi, Zlow} <= 64'b0;
			default 	: begin
							{Zhi, Zlow} <= 64'b0;
						end
		endcase
	end
endmodule
