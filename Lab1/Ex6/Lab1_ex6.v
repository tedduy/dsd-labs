module Lab1_ex6(SW,LEDR,LEDG);
	input[17:0] SW;
	output[7:0] LEDG;
	output [17:0] LEDR;
	
	assign LEDR=SW;
	
	//mux41_GL(.s(SW[1:0]), .i(SW[5:2]), .y(LEDG[7]));
	//mux41_DF(.s(SW[1:0]), .i(SW[5:2]), .y(LEDG[7]));
	//mux41_BEH_v1(.s(SW[1:0]), .i(SW[5:2]), .y(LEDG[7]));
	mux41_BEH_v2(.s(SW[1:0]), .i(SW[5:2]), .y(LEDG[7]));
endmodule

/*
module mux41_GL(i,s,y);
	input [3:0] i;
	input [1:0] s;
	output y;
	wire [1:0] n_s;
	wire [3:0]a;
	not g0(n_s[0],s[0]);
	not g1(n_s[1],s[1]);
	and g2(a[0],i[0],n_s[0],n_s[1]);
	and g3(a[1],i[1],n_s[1],s[0]);
	and g4(a[2],i[2],s[1],n_s[0]);
	and g5(a[3],i[3],s[1],s[0]);
	or  g6(y,a[0],a[1],a[2],a[3]);
endmodule


module mux41_DF(i,s,y);
	input [3:0] i;
	input [1:0] s;
	output y;
	assign y= i[0]&(~s[1])&(~s[0]) | i[1] &(~s[1])&s[0]  | i[2]&s[1]&(~s[0]) | i[3]&s[1]&s[0];
endmodule

module mux41_BEH_v1(i,s,y );
	output reg y ;
	input [3:0] i ;
	input [1:0] s ;
	always @ (i,s) begin
		if (s[1]==0&s[0]==0)
		y <= i[0];
		else if (s[1]==0&s[0]==1)
		y <= i[1];
		else if (s[1]==1&s[0]==0)
		y <= i[2];
	else
		y <= i[3];
	end
endmodule
*/

module mux41_BEH_v2(i,s,y );
	output reg y ;
	input [3:0]i;
	input [1:0]s;
	always@(i,s) begin
		case ({s[1],s[0]})
		2'b00: y <= i[0];
		2'b01: y <= i[1];
		2'b10: y <= i[2];
		2'b11: y <= i[3];
		endcase 
	end
endmodule




