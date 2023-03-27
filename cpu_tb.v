`timescale 1ns/10ps

module cpu_tb;
	reg  clk, clr, Stop, Run, Reset;
	wire [31:0] Outport_output, Inport_input;
	
	
datapath DUT(Outport_output, Inport_input, clk, clr, Stop, Run, Reset); 


initial
	begin
		clk = 0;
		clr = 0;
		Stop = 0;
		Run = 0;
		Reset = 1;
		Reset = 0;
		forever #5 clk = ~ clk;
end
endmodule
