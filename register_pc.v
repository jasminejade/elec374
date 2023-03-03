module register_pc(D, clk, clr, enable, IncPC, Q);
	input [31:0] D;
	input clk, clr, enable, IncPC;
	output [31:0] Q;
	reg [31:0] Q;
	
	always @(posedge clk)
	begin
		if(clr)
			Q <= 0;
		else if(enable)
			if(IncPC)
				Q <= D + 1;
			else
				Q <= D;
	end
endmodule
