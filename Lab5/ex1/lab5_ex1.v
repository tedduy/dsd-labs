module lab5_ex1(SW,LEDG,LEDR);
	input [17:0]SW;
	output [17:0]LEDR;
	output [7:0]LEDG;

	assign LEDR=SW;

	Program_Counter(.clk(SW[9]),.reset(SW[8]),.PC_in(SW[7:0]),.PC_out(LEDG)); 
	
endmodule

module Program_Counter (clk, reset, PC_in, PC_out);
	input clk, reset;
	input [7:0] PC_in;
	output [7:0] PC_out;
	reg [7:0] PC_out;
	always @ (posedge clk or posedge reset)
	begin
		if(reset==1'b1)
			PC_out<=8'b0;
		else
			PC_out<=PC_in;
	end
endmodule