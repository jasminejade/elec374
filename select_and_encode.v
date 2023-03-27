module select_and_encode(
	input [31:0] IR,
	input Gra, Grb, Grc, Rin, Rout, BAout,
	output [31:0] c_sign_extended,
	output [4:0] opcode,
	output reg [15:0] reg_in, reg_out
);
	wire [3:0] decode_input;
	reg [15:0] decode_output;
	
	assign decode_input = (IR[26:23] & {4{Gra}}) | (IR[22:19] & {4{Grb}}) | (IR[18:15] & {4{Grc}});
	
	always @(*) begin
		case(decode_input)
			4'b0000 : decode_output = 16'b0000000000000001;
			4'b0001 : decode_output = 16'b0000000000000010;
			4'b0010 : decode_output = 16'b0000000000000100;
			4'b0011 : decode_output = 16'b0000000000001000;
			4'b0100 : decode_output = 16'b0000000000010000;
			4'b0101 : decode_output = 16'b0000000000100000;
			4'b0110 : decode_output = 16'b0000000001000000;
			4'b0111 : decode_output = 16'b0000000010000000;
			4'b1000 : decode_output = 16'b0000000100000000;
			4'b1001 : decode_output = 16'b0000001000000000;
			4'b1010 : decode_output = 16'b0000010000000000;
			4'b1011 : decode_output = 16'b0000100000000000;
			4'b1100 : decode_output = 16'b0001000000000000;
			4'b1101 : decode_output = 16'b0010000000000000;
			4'b1110 : decode_output = 16'b0100000000000000;
			4'b1111 : decode_output = 16'b1000000000000000;
			default : decode_output = 16'bx;
		endcase
		if (IR[31:27] == 5'b10101) reg_in <= 16'b1000000000000000 & {16{Rin}};
		else reg_in <= decode_output & {16{Rin}};
		reg_out <= decode_output & {16{Rout|BAout}};
	end
	
	assign opcode = IR[31:27];
	assign c_sign_extended = {{13{IR[18]}},IR[18:0]};
endmodule
