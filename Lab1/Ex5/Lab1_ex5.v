module Lab1_ex5(SW,LEDG,LEDR);
	input[17:0] SW;
	output[7:0] LEDG;
	output [17:0] LEDR;
	
	assign LEDR=SW;
	
	//mux21_DF(.i(SW[2:1]),.sel(SW[0]),.y(LEDG[7]));
	//mux21_BEH(.i(SW[2:1]),.sel(SW[0]),.y(LEDG[7]));
	mux21_GL(.i(SW[2:1]),.sel(SW[0]),.y(LEDG[7]));
endmodule

/*
module mux21_DF(i,sel,y);
	input sel;
	input [1:0] i;
	output y;
	assign y =(i[0]&(~sel))|(i[1]&sel);
endmodule


module mux21_BEH(i,sel,y);
	input sel;
	input [1:0] i;
	output reg y;
	always@(*) begin
 	if(sel==0) y=i[0];
	if(sel==1)y=i[1];
 	end
endmodule
*/

module mux21_GL(i,sel,y);
	input sel;
	input [1:0] i;
	output y;
	wire net1,net2,net3;
	not g1(net1,sel);
	and g2(net2,i[1],sel);
	and g3(net3,i[0],net1);
	or g4(y,net3,net2);
endmodule

