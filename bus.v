module bus_mux #(parameter word_size =32)(
	output	[word_size-1:0]	bus_mux_out,
	input		[word_size-1:0]	r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15,
										HI, LO, z_high, z_low, PC, MDR, in_port, c_sign_extended
	input								select
);
	assign bus_mux_out = select ? r0:r1:r2:r3:r4:r5:r6:r7:r8:r9:r10:r11:r12:r13:r14:r15:HI:LO:z_high:z_low:PC:MDR:in_port:c_sign_extended;
endmodule
