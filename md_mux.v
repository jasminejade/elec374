module md_mux #(parameter word_size = 32)(
	input		[word_size-1:0]	bus_mux_out, m_data_in,
	input								read,
	output	[word_size-1:0]	md_mux_out
);
	reg		[word_size-1:0]	mux_int;
	always @(bus_mux_out, m_data_in, read)
		case(read)
			0 : mux_int = bus_mux_out;
			1 : mux_int = m_data_in;
			default	mux_int = 32'bx;
		endcase
	assign md_mux_out = mux_int;
endmodule
