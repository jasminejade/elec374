module RAM(We_b, Re_b, Address, IO_data_in, IO_data_out);
	input We_b, Re_b;
	input [8:0] Address;
	input [31:0] IO_data_in;
	output [31:0] IO_data_out;
	
	reg [31:0] RAM1[511:0];
	
	initial begin
		$readmemb("C:/altera/13.0sp1/elec374/project/initRAM.txt", RAM1);
	end
	
	assign IO_data_out = (We_b == 1'b0 & Re_b == 1'b1) ? RAM1[Address]: 32'bX;
	
	always@(We_b, Re_b) begin
		@(negedge We_b) if(Re_b == 1'b0) RAM1[Address] <= IO_data_in;
	end
	
endmodule
