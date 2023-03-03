module md_mux(
	input	[31:0]		bus_mux_out, m_data_in,
	input					read,
	output reg [31:0]	md_mux_out
);
//	reg		[31:0]	mdmux_int;

	always @(*) begin
		case(read)
			0 : md_mux_out <= bus_mux_out;
			1 : md_mux_out <= m_data_in;
			default : md_mux_out <= 32'bx;
		endcase
	end
endmodule
