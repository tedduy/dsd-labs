module lab2_ex1(SW,LEDG,LEDR);
	input[17:0]SW;
	output[7:0] LEDG;
	output[17:0] LEDR;
	
	assign LEDR = SW;
	
	//m81_GL(.d(SW[11:4]),.s(SW[2:0]),.out(LEDG[7]));
	//m81_DF(.d(SW[11:4]),.s(SW[2:0]),.out(LEDG[7]));
	m81_BEH(.d(SW[11:4]),.s(SW[2:0]),.out(LEDG[7]));
endmodule

/*
module m81_GL(d,s,out);
	input [7:0] d;
	input [2:0] s;
	output out;
	wire [10:0] t;
	not(t[0], s[0]);
	not(t[1], s[1]);
	not(t[2], s[2]);
	and(t[3], d[0], t[0], t[1], t[2]), (t[4], d[1],s[0], t[1], t[2]);
	and(t[5], d[2], t[0], s[1], t[2]), (t[6], d[3], s[0], s[1], t[2]);
	and(t[7], d[4], t[0], t[1], s[2]), (t[8], d[5], s[0], t[1], s[2]);
	and(t[9], d[6], t[0], s[1], s[2]), (t[10], d[7], s[0], s[1], s[2]);
	or(out, t[3], t[4], t[5], t[6], t[7],t[8], t[9], t[10]);
endmodule


module m81_DF(d,s,out);
	input [7:0] d;
	input [2:0] s;
	wire [2:0] n_s;
	output out;
	assign n_s[0]=~s[0];
	assign n_s[1]=~s[1];
	assign n_s[2]=~s[2];
	assign out = (d[0] & n_s[2] & n_s[1] & n_s[0]) | (d[1] & n_s[2] & n_s[1] & s[0]) | (d[2] & n_s[2] & s[1] & n_s[0]) + (d[3] & n_s[2] & s[1] & s[0]) + (d[4] & s[2] & n_s[1] & n_s[0]) + (d[5] & s[2] & n_s[1] & s[0]) + (d[6] & s[2] & s[1] & n_s[0]) + (d[7] & s[2] & s[1] & s[0]);
endmodule
*/

module m81_BEH(d,s,out);
	input [7:0] d;
	input [2:0] s;
	output reg out;
	always@(*) begin
		case(s)
		3'b000: out=d[0];
		3'b001: out=d[1];
		3'b010: out=d[2];
		3'b011: out=d[3];
		3'b100: out=d[4];
		3'b101: out=d[5];
		3'b110: out=d[6];
		3'b111: out=d[7];
		default: out=1'b0;
		endcase
	end
endmodule


