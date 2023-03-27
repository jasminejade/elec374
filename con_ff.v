module con_ff(input [1:0] C2, input signed [31:0] bus_out, input CONin, output reg Q);
	wire zero, positive, br_flag;
	reg [3:0] decoder_out;
	
	initial begin
		Q <= 0;
	end
	
	always@(*) begin
		case(C2)
			2'b00 : decoder_out = 4'b0001;
			2'b01 : decoder_out = 4'b0010;
			2'b10 : decoder_out = 4'b0100;
			2'b11 : decoder_out = 4'b1000;
		endcase
	end
	
	assign zero = (bus_out == 32'd0) ? 1'b1 : 1'b0;
	assign positive = (bus_out[31] == 0) ? 1'b1 : 1'b0;
	
	assign br_flag = ((decoder_out[0]&zero)|(decoder_out[1]&(!zero))|(decoder_out[2]&positive)|(decoder_out[3]&(!positive)));
		
	always @(*) begin
		if(CONin) Q <= br_flag;
		else Q <= 0;
	end
endmodule
