module mar_reg(input wire clk, clr, enable, D, output [8:0] Q);
	wire [31:0] MARdataout;
	register MAR(D, clk, clr, enable, MARdataout);
	assign Q = MARdataout[8:0];
endmodule
