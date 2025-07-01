module lab2_ex7(SW,LEDG,LEDR);
	input[17:0]SW;
	output[7:0] LEDG;
	output[17:0] LEDR;
	
	assign LEDR = SW;
	
	comp4bit_GL(.a(SW[7:4]),.b(SW[3:0]),.d(LEDG[7:5]));
endmodule

module comp4bit_GL(a,b,d);
	input [3:0]a;
	input [3:0]b;
	output [2:0]d;
	wire [7:0]y;
	
	wire [3:0] n_a;
	wire [3:0] n_b;
	wire [3:0] w;
		
	not g1_0(n_a[0], a[0]);
	not g1_1(n_a[1], a[1]);
	not g1_2(n_a[2], a[2]);
	not g1_3(n_a[3], a[3]);

	not g2_0(n_b[0], b[0]);
	not g2_1(n_b[1], b[1]);
	not g2_2(n_b[2], b[2]);
	not g2_3(n_b[3], b[3]);
	
	xnor g3(w[3],a[3],b[3]);
	xnor g4(w[2],a[2],b[2]);
	xnor g5(w[1],a[1],b[1]);
	xnor g6(w[0],a[0],b[0]);
	
	and g7(d[0],w[0],w[1],w[2],w[3]);

	and g8(y[0],n_a[3],b[3]);
	and g9(y[1],n_a[2],b[2],w[3]);
	and g10(y[2],n_a[1],b[1],w[3],w[2]);
	and g11(y[3],n_a[0],b[0],w[3],w[2],w[1]);
	
	and g12(y[4],a[3],n_b[3]);
	and g13(y[5],a[2],n_b[2],w[3]);
	and g14(y[6],a[1],n_b[1],w[3],w[2]);
	and g15(y[7],a[0],n_b[0],w[3],w[2],w[1]);
	
	or g16(d[1],y[0],y[1],y[2],y[3]);
	or g17(d[2],y[4],y[5],y[6],y[7]);
endmodule
	
	