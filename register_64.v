module register_64(D, Q, clk, clr, enable);
	input [63:0] D;
	input clk, clr, enable;
	output [63:0] Q;
	reg [63:0] Q;
	
	always @(posedge clk)
	begin
		if(clr)
			Q <= 0;
		else if(enable)
			Q <= D;
	end
endmodule