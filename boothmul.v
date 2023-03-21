module boothmul(A, B, Z);
	input signed [31:0] A, B;
	output wire  [63:0] Z;
	
	reg signed [63:0] result;
	reg [2:0] temp;
	integer i;
	reg E1;
	reg [31:0] A1;
	
	always @(A, B) begin
		result = 64'd0;
		E1	= 1'd0;
		A1 = -A;
		for(i = 0; i<16; i = i+1) begin
			temp = {B[2*i+1], B[2*i], E1};
			case(temp)
				3'b001 : result = result + (A <<< 2*i);
				3'b010 : result = result + (A <<< 2*i);
				3'b011 : result = result + (2*A <<< 2*i);
				3'b100 : result = result + (2*A1 <<< 2*i);
				3'b101 : result = result + (A1 <<< 2*i);
				3'b110 : result = result + (A1 <<< 2*i);
				default : result = result;
			endcase
			E1 = B[2*i+1];
		end
	end
	assign Z = result;
endmodule
