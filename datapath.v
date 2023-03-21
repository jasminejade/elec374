module datapath(
	output [31:0] Outport_output,
	input [31:0] Inport_input,
	input wire clk, clr, Yin, Zin, MDRin, IRin, PCin, MARin, MDRout, Zlowout, PCout, IncPC, Read, Cout,
	input wire GRA, GRB, GRC, RAM_read, RAM_write, Rin_logic, BA_out,
	input wire [4:0] opcode
);
	wire [15:0] Rin, Rout;
	wire Rout_logic;
	
	wire INPORTin, LOin, Cin, HIin, OUTPORTin;
	wire HIout, LOout, Yout, Zhighout, INPORTout;
	wire br_flag, CONin;
	
	wire [31:0] BUSMUXOUT, ALU_PC, RAMtoMDR;
	wire [31:0] R0toBUSMUX, R1toBUSMUX, R2toBUSMUX, R3toBUSMUX, R4toBUSMUX, R5toBUSMUX, 
					R6toBUSMUX, R7toBUSMUX, R8toBUSMUX, R9toBUSMUX, R10toBUSMUX, R11toBUSMUX, 
					R12toBUSMUX, R13toBUSMUX, R14toBUSMUX, R15toBUSMUX, HItoBUSMUX, LOtoBUSMUX, 
					PCtoBUSMUX, MDRtoBUSMUX, INPORTtoBUSMUX, CSIGNtoBUSMUX, ZHIGHtoBUSMUX, ZLOWtoBUSMUX;
	wire [31:0] YtoALU, ALUtoZHIGH, ALUtoZLO;
	wire [31:0] MDMUXtoMDR, MARtoMEMORY, IRtoCONTROL, outport_output;
	wire [4:0] CODEtoBUSMUX, CODEtoALU;
	
	RAM ram(RAM_write, RAM_read, MARtoMEMORY[8:0], MDRtoBUSMUX, RAMtoMDR);
	select_and_encode IR_logic(IRtoCONTROL, GRA, GRB, GRC, Rin_logic, Rout_logic, BA_out, CSIGNtoBUSMUX, CODEtoALU, Rin, Rout);
	con_ff CONFF(IRtoCONTROL[20:19], BUSMUXOUT, CONin, br_flag);
	ALU alu(IncPC, br_flag, YtoALU, BUSMUXOUT, opcode, ALUtoZLO, ALUtoZHIGH);

	wire [31:0] R0out;
	register R0(BUSMUXOUT, clk, clr, Rin[0], R0out);
	assign R0toBUSMUX = {32{!BA_out}} & R0out;
	
	register R1(BUSMUXOUT, clk, clr, Rin[1], R1toBUSMUX);
	register R2(BUSMUXOUT, clk, clr, Rin[2], R2toBUSMUX);
	register R3(BUSMUXOUT, clk, clr, Rin[3], R3toBUSMUX);	
	register R4(BUSMUXOUT, clk, clr, Rin[4], R4toBUSMUX);
	register R5(BUSMUXOUT, clk, clr, Rin[5], R5toBUSMUX);
	register R6(BUSMUXOUT, clk, clr, Rin[6], R6toBUSMUX);
	register R7(BUSMUXOUT, clk, clr, Rin[7], R7toBUSMUX);
	register R8(BUSMUXOUT, clk, clr, Rin[8], R8toBUSMUX);
	register R9(BUSMUXOUT, clk, clr, Rin[9], R9toBUSMUX);
	register R10(BUSMUXOUT, clk, clr, Rin[10], R10toBUSMUX);
	register R11(BUSMUXOUT, clk, clr, Rin[11], R11toBUSMUX);
	register R12(BUSMUXOUT, clk, clr, Rin[12], R12toBUSMUX);
	register R13(BUSMUXOUT, clk, clr, Rin[13], R13toBUSMUX);
	register R14(BUSMUXOUT, clk, clr, Rin[14], R14toBUSMUX);
	register R15(BUSMUXOUT, clk, clr, Rin[15], R15toBUSMUX);
	register HI(BUSMUXOUT, clk, clr, HIin, HItoBUSMUX);
	register LO(BUSMUXOUT, clk, clr, LOin, LOtoBUSMUX);
	register IR(BUSMUXOUT, clk, clr, IRin, IRtoCONTROL);
	register Y(BUSMUXOUT, clk, clr, Yin, YtoALU);
	register Z_HIGH(ALUtoZHIGH, clk, clr, Zin, ZHIGHtoBUSMUX);
	register Z_LOW(ALUtoZLO, clk, clr, Zin, ZLOWtoBUSMUX);
	register MAR(BUSMUXOUT, clk, clr, MARin, MARtoMEMORY);
	register MDR(MDMUXtoMDR, clk, clr, MDRin, MDRtoBUSMUX);
	register #(32'd0) PC(BUSMUXOUT, clk, clr, PCin, PCtoBUSMUX);
	register INPORT(Inport_input, clk, clr, INPORTin, INPORTtoBUSMUX);
	register OUTPORT(BUSMUXOUT, clk, clr, OUTPORTin, outport_output);
	
	md_mux MDMux(BUSMUXOUT, RAMtoMDR, Read, MDMUXtoMDR);

	bus_mux BusMux(R0toBUSMUX, R1toBUSMUX, R2toBUSMUX, R3toBUSMUX, R4toBUSMUX, R5toBUSMUX, 
						R6toBUSMUX, R7toBUSMUX, R8toBUSMUX, R9toBUSMUX, R10toBUSMUX, R11toBUSMUX, 
						R12toBUSMUX, R13toBUSMUX, R14toBUSMUX, R15toBUSMUX, HItoBUSMUX, LOtoBUSMUX,
						ZHIGHtoBUSMUX, ZLOWtoBUSMUX, PCtoBUSMUX, MDRtoBUSMUX, INPORTtoBUSMUX, 
						CSIGNtoBUSMUX, CODEtoBUSMUX, BUSMUXOUT); 

	encoder BusEncoder(CODEtoBUSMUX, {8'b0, Cout, INPORTout, MDRout, PCout, Zlowout, Zhighout, 
								LOout, HIout, Rout});
endmodule
