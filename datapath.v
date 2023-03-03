module datapath(
	input wire clk, clr, R1in, R2in, R3in, Yin, Zin, MDRin, IRin, PCin, MARin, R2out, R3out, MDRout, Zlowout, PCout, IncPC, Read,
	input wire [31:0] Mdatain,
	input wire [4:0] opcode
);
	wire	R0in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, HIin, LOin, INPORTin, Cin;
	wire	R0out, R1out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, INPORTout, Cout, Yout, Zhighout;
	
	wire [31:0] BUSMUXOUT;
	wire [31:0] R0toBUSMUX, R1toBUSMUX, R2toBUSMUX, R3toBUSMUX, R4toBUSMUX, R5toBUSMUX, R6toBUSMUX, R7toBUSMUX, R8toBUSMUX, R9toBUSMUX, 
		  R10toBUSMUX, R11toBUSMUX, R12toBUSMUX, R13toBUSMUX, R14toBUSMUX, R15toBUSMUX, HItoBUSMUX, LOtoBUSMUX, PCtoBUSMUX, MDRtoBUSMUX,
		  INPORTtoBUSMUX, CSIGNtoBUSMUX, ZHIGHtoBUSMUX, ZLOWtoBUSMUX;
	wire [31:0] YtoALU, ALUtoZHIGH, ALUtoZLO;
	wire [31:0] MDMUXtoMDR, MARtoMEMORY, IRtoCONTROL;
	wire [4:0] CODEtoBUSMUX;
	
	md_mux MDMux(BUSMUXOUT, Mdatain, Read, MDMUXtoMDR);
	register MDR(MDMUXtoMDR, clk, clr, MDRin, MDRtoBUSMUX);
	
	ALU alu(YtoALU, BUSMUXOUT, opcode, ALUtoZLO, ALUtoZHIGH);
	
	register R0(BUSMUXOUT, clk, clr, R0in, R0toBUSMUX);
	register R1(BUSMUXOUT, clk, clr, R1in, R1toBUSMUX);
	register R2(BUSMUXOUT, clk, clr, R2in, R2toBUSMUX);
	register R3(BUSMUXOUT, clk, clr, R3in, R3toBUSMUX);	
	register R4(BUSMUXOUT, clk, clr, R4in, R4toBUSMUX);	
	register R5(BUSMUXOUT, clk, clr, R5in, R5toBUSMUX);
	register R6(BUSMUXOUT, clk, clr, R6in, R6toBUSMUX);
	register R7(BUSMUXOUT, clk, clr, R7in, R7toBUSMUX);
	register R8(BUSMUXOUT, clk, clr, R8in, R8toBUSMUX);
	register R9(BUSMUXOUT, clk, clr, R9in, R9toBUSMUX);
	register R10(BUSMUXOUT, clk, clr, R10in, R10toBUSMUX);
	register R11(BUSMUXOUT, clk, clr, R11in, R11toBUSMUX);
	register R12(BUSMUXOUT, clk, clr, R12in, R12toBUSMUX);
	register R13(BUSMUXOUT, clk, clr, R13in, R13toBUSMUX);
	register R14(BUSMUXOUT, clk, clr, R14in, R14toBUSMUX);
	register R15(BUSMUXOUT, clk, clr, R15in, R15toBUSMUX);
	register HI(BUSMUXOUT, clk, clr, HIin, HItoBUSMUX);
	register LO(BUSMUXOUT, clk, clr, LOin, LOtoBUSMUX);
	register IR(BUSMUXOUT, clk, clr, IRin, IRtoCONTROL);
	
	register_pc PC(BUSMUXOUT, clk, clr, PCin, IncPC, PCtoBUSMUX);

	register MAR(BUSMUXOUT, clk, clr, MARin, MARtoMEMORY);
	register Y(BUSMUXOUT, clk, clr, Yin, YtoALU);
	
	register Z_HIGH(ALUtoZHIGH, clk, clr, Zin, ZHIGHtoBUSMUX);
	register Z_LOW(ALUtoZLO, clk, clr, Zin, ZLOWtoBUSMUX);
	
	register INPORT(BUSMUXOUT, clk, clr, INPORTin, INPORTtoBUSMUX);
	register C_SIGN(BUSMUXOUT, clk, clr, Cin, CSIGNtoBUSMUX);

	bus_mux BusMux(R0toBUSMUX, R1toBUSMUX, R2toBUSMUX, R3toBUSMUX, R4toBUSMUX, R5toBUSMUX, R6toBUSMUX, R7toBUSMUX, R8toBUSMUX, 
						R9toBUSMUX, R10toBUSMUX, R11toBUSMUX, R12toBUSMUX, R13toBUSMUX, R14toBUSMUX, R15toBUSMUX, HItoBUSMUX, LOtoBUSMUX,
						ZHIGHtoBUSMUX, ZLOWtoBUSMUX, PCtoBUSMUX, MDRtoBUSMUX, INPORTtoBUSMUX, CSIGNtoBUSMUX, CODEtoBUSMUX, BUSMUXOUT);

	encoder BusEncoder(CODEtoBUSMUX, {8'b0, Cout, INPORTout, MDRout, PCout, Zlowout, Zhighout, LOout, HIout, R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out});
	
endmodule
