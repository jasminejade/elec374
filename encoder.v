module encoder (output reg[4:0] Code, input[31:0] Data);
	always @(Data)
	begin
		if(Data == 32'h1) Code = 0; else
		if(Data == 32'h2) Code = 1; else
		if(Data == 32'h4) Code = 2; else
		if(Data == 32'h8) Code = 3; else
		if(Data == 32'h10) Code = 4; else
		if(Data == 32'h20) Code = 5; else
		if(Data == 32'h40) Code = 6; else
		if(Data == 32'h80) Code = 7; else
		if(Data == 32'h100) Code = 8; else
		if(Data == 32'h200) Code = 9; else
		if(Data == 32'h400) Code = 10; else
		if(Data == 32'h800) Code = 11; else
		if(Data == 32'h1000) Code = 12; else
		if(Data == 32'h2000) Code = 13; else
		if(Data == 32'h4000) Code = 14; else
		if(Data == 32'h8000) Code = 15; else
		if(Data == 32'h10000) Code = 16; else
		if(Data == 32'h20000) Code = 17; else
		if(Data == 32'h40000) Code = 18; else
		if(Data == 32'h80000) Code = 19; else
		if(Data == 32'h100000) Code = 20; else
		if(Data == 32'h200000) Code = 21; else
		if(Data == 32'h400000) Code = 22; else
		if(Data == 32'h800000) Code = 23;
	end
endmodule
