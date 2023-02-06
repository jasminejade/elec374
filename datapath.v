module datapath(
	input		clk, clr, enable, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in,
				R9in, R10in, R11in, R12in, R13in, R14in, R15in, HIin, LOin, PCin, IRin,
				MDRin, MARin, INPORTin, Cin, Yin, Zin, read, memorychip,
	input		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out,
				R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, PCout, 
				IRout, MDRout, INPORTout, Cout, Yout, Zlowout, Zhighout,
	output	out
);
	wire BUSMUXOUTtoREG;
	wire R0toBUSMUX, R1toBUSMUX, R2toBUSMUX, R3toBUSMUX, R4toBUSMUX, R5toBUSMUX, R6toBUSMUX, R7toBUSMUX, R8toBUSMUX, R9toBUSMUX, 
		  R10toBUSMUX, R11toBUSMUX, R12toBUSMUX, R13toBUSMUX, R14toBUSMUX, R15toBUSMUX, HItoBUSMUX, LOtoBUSMUX, PCtoBUSMUX, MDRtoBUSMUX,
		  INPORTtoBUSMUX, CSIGNtoBUSMUX, ZHIGHtoBUSMUX, ZLOWtoBUSMUX;
	wire CODEtoBUSMUX;
	
	register R0(
		.D (BUSMUXOUTtoREG),
		.Q (R0toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R0in)
	);
	
	register R1(
		.D (BUSMUXOUTtoREG),
		.Q (R1toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R1in)
	);
	
	register R2(
		.D (BUSMUXOUTtoREG),
		.Q (R2toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R2in)
	);

	register R3(
		.D (BUSMUXOUTtoREG),
		.Q (R3toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R3in)
	);
	
	register R4(
		.D (BUSMUXOUTtoREG),
		.Q (R4toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R4in)
	);
	
	register R5(
		.D (BUSMUXOUTtoREG),
		.Q (R5toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R5in)
	);
	
	register R6(
		.D (BUSMUXOUTtoREG),
		.Q (R6toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R6in)
	);
	
	register R7(
		.D (BUSMUXOUTtoREG),
		.Q (R7toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R7in)
	);
	
	register R8(
		.D (BUSMUXOUTtoREG),
		.Q (R8toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R8in)
	);
	
	register R9(
		.D (BUSMUXOUTtoREG),
		.Q (R9toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R9in)
	);
	
	register R10(
		.D (BUSMUXOUTtoREG),
		.Q (R10toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R10in)
	);
	
	register R11(
		.D (BUSMUXOUTtoREG),
		.Q (R11toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R11in)
	);
	
	register R12(
		.D (BUSMUXOUTtoREG),
		.Q (R12toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R12in)
	);
	
	register R13(
		.D (BUSMUXOUTtoREG),
		.Q (R13toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R13in)
	);
	
	register R14(
		.D (BUSMUXOUTtoREG),
		.Q (R14toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R14in)
	);

	register R15(
		.D (BUSMUXOUTtoREG),
		.Q (R15toBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (R15in)
	);

	register HI(
		.D (BUSMUXOUTtoREG),
		.Q (HItoBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (HIin)
	);
	
	register LO(
		.D (BUSMUXOUTtoREG),
		.Q (LOtoBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (LOin)
	);

	register PC(
		.D (BUSMUXOUTtoREG),
		.Q (PCtoBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (PCin)
	);

	register IR(
		.D (BUSMUXOUTtoREG),
		.Q (),
		.clk (clk),
		.clr (clr),
		.enable (IRin)
	);
	
	md_mux MDMux(
		.md_mux_out (MDMUXtoMDR),
		.bus_mux_out (BUSMUXOUTtoREG),
		.m_data_in (memorychip),
		.read (read)
	);
	
	register MDR(
		.D (BUSMUXOUTtoREG),
		.Q (MDRtoBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (MDRin)
	);

	register MAR(
		.D (BUSMUXOUTtoREG),
		.Q (memorychip),
		.clk (clk),
		.clr (clr),
		.enable (MARin)
	);
	
	register Z_HIGH(
		.D (BUSMUXOUTtoREG),
		.Q (ZHIGHtoBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (Zin)
	);

	register Z_LOW(
		.D (BUSMUXOUTtoREG),
		.Q (ZLOWtoBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (Zin)
	);

	register INPORT(
		.D (BUSMUXOUTtoREG),
		.Q (INPORTtoBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (INPORTin)
	);

	register C_SIGN(
		.D (BUSMUXOUTtoREG),
		.Q (CSIGNtoBUSMUX),
		.clk (clk),
		.clr (clr),
		.enable (Cin)
	);

	bus_mux BusMux(
		.r0 (R0toBUSMUX),
		.r1 (R1toBUSMUX),
		.r2 (R2toBUSMUX),
		.r3 (R3toBUSMUX),
		.r4 (R4toBUSMUX),
		.r5 (R5toBUSMUX),
		.r6 (R6toBUSMUX),
		.r7 (R7toBUSMUX),
		.r8 (R8toBUSMUX),
		.r9 (R9toBUSMUX),
		.r10 (R10toBUSMUX),
		.r11 (R11toBUSMUX),
		.r12 (R12toBUSMUX),
		.r13 (R13toBUSMUX),
		.r14 (R14toBUSMUX),
		.r15 (R15toBUSMUX),
		.HI (HItoBUSMUX),
		.LO (LOtoBUSMUX),
		.z_high (ZHIGHtoBUSMUX),
		.z_low (ZLOWtoBUSMUX),
		.PC (PCtoBUSMUX),
		.MDR (MDRtoBUSMUX),
		.in_port (INPORTtoBUSMUX),
		.c_sign_extended (CSIGNtoBUSMUX),
		.select (CODEtoBUSMUX),
		.bus_mux_out (BUSMUXOUTtoREG)
	);

	encoder BusEncoder(
		.Data (enable),
		.Code (CODEtoBUSMUX)
	);
	
endmodule