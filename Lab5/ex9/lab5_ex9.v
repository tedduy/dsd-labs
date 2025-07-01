module lab5_ex9(SW,LEDG,LEDR);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0] LEDG;
	
	assign LEDR =SW;
	
	parameter N = 8;
	Mux_N_bit(.in0(SW[N-1:0]),.in1(SW[2*N-1:N]),.mux_out(LEDG[N-1:0]),.select(SW[17]));
endmodule

module Mux_N_bit(in0, in1, mux_out, select);
	parameter N = 8;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input select;
	assign mux_out = select? in1: in0 ;
endmodule
