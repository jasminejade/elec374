module boothmul(A, B, Z);
	input signed [31:0] A, B;
	output wire  [63:0] Z;
	
	reg [2:0] temp [15:0]; 				
   reg signed [32:0] product [15:0];  		
   reg signed [63:0] temp_result [15:0];
	reg signed [63:0] result;
	 
	wire signed[32:0] negA;
	
	integer i;

	assign negA = -A;
	
	always @ (A or B or negA) begin
      temp[0] = {B[1], B[0], 1'b0};
		
      for(i=1; i<16; i=i+1) begin
			temp[i] = {B[2*i+1],B[2*i],B[2*i-1]};
      end

		for(i=0;i<16;i=i+1) begin //case check for which bit
			case(temp[i])
				3'b001, 3'b010 : product[i] = {A[31], A};
				3'b011 : product[i] = {A, 1'b0};
				3'b100 : product[i] = {negA[31:0], 1'b0};
				3'b101, 3'b110 : product[i] = negA;
				default : product[i] = 0;
			endcase
			
			temp_result[i] = product[i] << (2*i);  //sign extension 
		end
		
		result = temp_result[0];
		
		for(i=1; i<16; i=i+1) begin //add product to tot.
			result = result + temp_result[i];
		end
    end

    assign Z = result; //after all shifts adne verythig is done, send it out
endmodule

//	reg signed [63:0] result;
//	reg [2:0] temp;
//	integer i;
//	reg E1;
//	reg [31:0] A1;
//	
//	always @(A, B) begin
//		result = 64'd0;
//		E1	= 1'd0;
//		A1 = -A;
//		for(i = 0; i<16; i = i+1) begin
//			temp = {B[2*i+1], B[2*i], E1};
//			case(temp)
//				3'b001 : result = result + (A <<< 2*i);
//				3'b010 : result = result + (A <<< 2*i);
//				3'b011 : result = result + (2*A <<< 2*i);
//				3'b100 : result = result + (2*A1 <<< 2*i);
//				3'b101 : result = result + (A1 <<< 2*i);
//				3'b110 : result = result + (A1 <<< 2*i);
//				default : result = result;
//			endcase
//			E1 = B[2*i+1];
//		end
//	end
//	assign Z = result;
//endmodule