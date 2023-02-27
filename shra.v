module shra(
	input wire [31:0]		A, B,
	output wire [63:0]	Z
);
	reg [31:0] shifted;
	integer i;
	reg A_MSB;
	wire [4:0] B_num;
	
	assign B_num = B%(B+1);

	always @(*) begin
		A_MSB = A[31];
		shifted = A >> B;
		
		for(i = 0; i<B_num; i = i+1) begin
			shifted[31-i] = A_MSB;
		end
	end
	assign Z = {32'b0, shifted};
endmodule
