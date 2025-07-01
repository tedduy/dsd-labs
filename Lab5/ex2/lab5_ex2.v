module lab5_ex2(SW,LEDR,LEDG);
	input [17:0]SW;
	output [17:0]LEDR;
	output [7:0]LEDG;
	
	assign LEDR=SW;
	
	Adder8Bit(.input1(SW[17:10]),.input2(SW[7:0]),.out(LEDG));
endmodule

module Adder8Bit(input1, input2, out);

 input [7:0] input1, input2;
 output [7:0] out;
 reg [7:0]out;
 always@( input1 or input2)
 begin
 	out  <= input1 + input2;
 end
endmodule
