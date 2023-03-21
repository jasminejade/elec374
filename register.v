module register#(parameter value = 0)(D, clk, clr, enable, Q);
	input [31:0] D;
	input clk, clr, enable;
	output [31:0] Q;
	reg [31:0] Q;
	
	initial begin
		Q <= value;
	end
	
	always @(posedge clk)
	begin
		if(clr)
			Q <= 0;
		else if(enable)
			Q <= D;
	end
endmodule
