module bus_mux #(parameter word_size = 32)(
	output	[word_size-1:0]	bus_mux_out,
	input		[word_size-1:0]	r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15,
										HI, LO, z_high, z_low, PC, MDR, in_port, c_sign_extended,
	input		[4:0]					select
);
	reg		[word_size-1:0]	mux_int;
	assign bus_mux_out = select ? mux_int : 32'bz;
	always @(r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, HI, LO, z_high, z_low, PC, MDR, in_port, c_sign_extended, select)
		case(select)
			0:		mux_int = r0;
			1:		mux_int = r1;
			2:		mux_int = r2;
			3:		mux_int = r3;
			4:		mux_int = r4;
			5:		mux_int = r5;
			6:		mux_int = r6;
			7:		mux_int = r7;
			8:		mux_int = r8;
			9:		mux_int = r9;
			10:	mux_int = r10;
			11:	mux_int = r11;
			12:	mux_int = r12;
			13:	mux_int = r13;
			14:	mux_int = r14;
			15:	mux_int = r15;
			16:	mux_int = HI;
			17:	mux_int = LO;
			18:	mux_int = z_high;
			19:	mux_int = z_low;
			20:	mux_int = PC;
			21:	mux_int = MDR;
			22:	mux_int = in_port;
			23:	mux_int = c_sign_extended;
			default	mux_int = 32'bx;
		endcase
endmodule
