module lab2_ex4(SW,LEDG,LEDR);
	input[17:0]SW;
	output[7:0] LEDG;
	output[17:0] LEDR;
	
	assign LEDR = SW;
	
	decoder24_GL(.e(SW[2]),.x(SW[1:0]),.y(LEDG[7:4]));
endmodule

module decoder24_GL(e,x,y);
	input e;
	input [1:0]x;
	output [3:0]y;
	
	wire [1:0]nx;
	
	not g1(nx[0],x[0]);
	not g2(nx[1],x[1]);
	
	and g3(y[0],nx[0],nx[1],e);
	and g4(y[1],x[0],nx[1],e);
	and g5(y[2],nx[0],x[1],e);
	and g6(y[3],x[0],x[1],e);
endmodule
	
