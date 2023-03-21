module bus_mux(
	input	[31:0]			r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, 
								r11, r12, r13, r14, r15, HI, LO, z_high, 
								z_low, PC, MDR, in_port, c_sign_extended,
	input wire	[4:0]		select,
	output reg	[31:0]	bus_mux_out
);
	
	always @(*) begin
		case(select)
			5'd0	:	bus_mux_out <= r0;
			5'd1	:	bus_mux_out <= r1;
			5'd2	:	bus_mux_out <= r2;
			5'd3	:	bus_mux_out <= r3;
			5'd4	:	bus_mux_out <= r4;
			5'd5	:	bus_mux_out <= r5;
			5'd6	:	bus_mux_out <= r6;
			5'd7	:	bus_mux_out <= r7;
			5'd8	:	bus_mux_out <= r8;
			5'd9	:	bus_mux_out <= r9;
			5'd10	:	bus_mux_out <= r10;
			5'd11	:	bus_mux_out <= r11;
			5'd12	:	bus_mux_out <= r12;
			5'd13	:	bus_mux_out <= r13;
			5'd14	:	bus_mux_out <= r14;
			5'd15	:	bus_mux_out <= r15;
			5'd16	:	bus_mux_out <= HI;
			5'd17	:	bus_mux_out <= LO;
			5'd18	:	bus_mux_out <= z_high;
			5'd19	:	bus_mux_out <= z_low;
			5'd20	:	bus_mux_out <= PC;
			5'd21	:	bus_mux_out <= MDR;
			5'd22	:	bus_mux_out <= in_port;
			5'd23	:	bus_mux_out <= c_sign_extended;
			5'd24 : 	bus_mux_out <= 32'hF;
			default	:	bus_mux_out <= 32'd0;
		endcase
	end
endmodule
