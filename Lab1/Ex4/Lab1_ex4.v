module Lab1_ex4(SW,LEDG,LEDR);
	input[17:0] SW;
	output [17:0] LEDR;
	output [7:0] LEDG;

	assign LEDR=SW;
	
	
	four_bit_adder_STRU(.cin(SW[0]),.a(SW[8:5]),.b(SW[4:1]),.s(LEDG[7:4]),.cout(LEDG[3]));
endmodule


module full_adder_STRU(a,b,cin,Sum,Carry);
	output Sum,Carry;
	input a,b,cin;
	wire x,y,z;
	xor g1(x,a,b);
    xor g2(Sum,x,cin);
	and g3(y,x,cin);
	and g4(z,a,b);
	or  g5(Carry,y,z);
endmodule

module four_bit_adder_STRU(cin,a,b,s,cout);
	input [3:0] a,b;
	input cin;
	output [3:0] s;
	output cout;
	wire [2:0] w_carry;
	full_adder_STRU  C1(a[0],b[0],cin,s[0], w_carry[0]);
	full_adder_STRU  C2(a[1],b[1], w_carry[0],s[1], w_carry[1]);
	full_adder_STRU  C3(a[2],b[2], w_carry[1],s[2], w_carry[2]);
	full_adder_STRU  C4(a[3],b[3], w_carry[2],s[3], cout);
endmodule

