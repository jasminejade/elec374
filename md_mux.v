module md_mux #(parameter word_size = 32)(
	output	[word_size-1:0]	md_mux_out,
	input		[word_size-1:0]	bus_mux_out, m_data_in,
	input								read
);
	reg		[word_size-1:0]	mux_int;
	assign md_mux_out = read ? mux_int : 32'bz;
	always @(bus_mux_out, m_data_in, read)
		case(read)
			0:		mux_int = bus_mux_out;
			1:		mux_int = m_data_in;
			default	mux_int = 32'bx;
		endcase
endmodule
