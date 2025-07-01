module lab5_ex10(SW,LEDG,LEDR);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0] LEDG;
	
	assign LEDR =SW;
	
	Sign_Extension (.sign_in(SW[5:0]),.sign_out(LEDG));
endmodule


module Sign_Extension (sign_in, sign_out);
	input [5:0] sign_in;
	output [7:0] sign_out;
	assign sign_out[5:0]=sign_in[5:0];
	assign sign_out[7:6]=sign_in[5]?2'b11:2'b0;
endmodule
