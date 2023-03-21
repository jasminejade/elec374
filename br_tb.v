`timescale 1ns/10ps

module br_tb;
	reg PCout, MARin, IncPC, Zin;
	reg Zlowout, PCin, Read, MDRin;
	reg MDRout, IRin;
	reg GRA, Rout, CONin;
	reg Yin;
	reg Cout;
	reg clk, clr;
	reg [4:0] opcode;
	reg [31:0] Mdatain;
	
	parameter Default = 4'b0000, T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, T3 = 4'b0100, T4 = 4'b0101, 
								T5 = 4'b0110, T6 = 4'b0111;
	reg [3:0] Present_state = Default;

datapath DUT(
	.PCout (PCout),
	.Zlowout (Zlowout),
	.MDRout (MDRout),
	.MARin (MARin),
	.Zin (Zin),
	.PCin (PCin),
	.MDRin (MDRin),
	.IRin (IRin),
	.Yin (Yin),
	.IncPC (IncPC),
	.Read (Read),
	.clk (clk),
	.clr (clr),
	.Mdatain (Mdatain),
	.opcode (opcode),
	.GRA (GRA),
	.CONin (CONin),
	.Cout (Cout)
);

// add test logic here
initial begin
	clr = 0;
	clk = 0;
	forever #10 clk = ~ clk;
end

always @(posedge clk) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
			Default : #40 Present_state = T0;
			T0 : #40 Present_state = T1;
			T1 : #40 Present_state = T2;
			T2 : #40 Present_state = T3;
			T3 : #40 Present_state = T4;
			T4 : #40 Present_state = T5;
			T5 : #40 Present_state = T6;
		endcase
	end
	
always @(Present_state) // do the required job in each state
	begin
		case (Present_state) // assert the required signals in each clock cycle
			Default: begin
				PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
				MARin <= 0; Zin <= 0; PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0;
				IncPC <= 0; Read <= 0; opcode <= 0; Mdatain <= 32'h00000000;
				GRA <= 0; Cout <= 0;
			end
			T0: begin // see if you need to de-assert these signals
				#10 PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
				#10 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
			end
			T1: begin
				#10 Zlowout <= 1; PCin <= 1; Read <= 1; Mdatain <= 32'h00800075; MDRin <= 1; 
				// Mdatain = opcode for “ld R1, $75”	
				#10 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0; 
			end
			T2: begin
				#10 MDRout <= 1; IRin <= 1;
				#10 MDRout <= 0; IRin <= 0;
			end
			T3: begin
				#10 GRA <= 1; Yin <= 1;
				#10 GRA <= 0; Yin <= 0;
			end
			T4: begin
				#10 Cout <= 1; opcode <= 5'b00011; Zin <= 1;
				#10 Cout <= 0; Zin <= 0;
			end
			T5: begin
				#10 Zlowout <= 1; MARin <= 1;
				#10 Zlowout <= 0; MARin <= 0;
			end
			T6 : begin
				#10 Read <= 1; Mdatain <= 32'h00800075; MDRin <= 1;
				#10 Read <= 0; MDRin <= 0;
			end
		endcase
	end
endmodule 