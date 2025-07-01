module Lab1_ex1(SW,LEDG,LEDR);
	input[17:0] SW;
	output[7:0] LEDG;
	output[17:0] LEDR;
	assign LEDR=SW;
	
	//allgate_DF DUT(.a(SW[1]),.b(SW[0]),.yand(LEDG[6]),.yor(LEDG[5]),.ynot(LEDG[4]),.ynand(LEDG[3]),.ynor(LEDG[2]),.yxor(LEDG[1]),.yxnor(LEDG[0]));
	allgate_BH DUT(.a(SW[1]),.b(SW[0]),.yand(LEDG[6]),.yor(LEDG[5]),.ynot(LEDG[4]),.ynand(LEDG[3]),.ynor(LEDG[2]),.yxor(LEDG[1]),.yxnor(LEDG[0]));
	//allgate_GL DUT(.a(SW[1]),.b(SW[0]),.yand(LEDG[6]),.yor(LEDG[5]),.ynot(LEDG[4]),.ynand(LEDG[3]),.ynor(LEDG[2]),.yxor(LEDG[1]),.yxnor(LEDG[0]));
endmodule

/*
module allgate_DF ( a, b, yand,yor,ynot,ynand,ynor,yxor,yxnor );
	input a,b;
	output yand, yor, ynot, ynand, ynor, yxor, yxnor;

	assign yand = a & b;		// AND Operation
	assign yor = a | b;		// OR Operation
	assign ynot = ~a ;		// NOT Operation
	assign ynand = ~(a & b);	// NAND Operation
	assign ynor = ~(a | b);		//NOR Operation
	assign yxor = a ^ b;		//XOR Operation
	assign yxnor =~(a^b);		//XNOR Operation
endmodule				// END of the module
*/
module allgate_BH ( a, b, yand,yor,ynot,ynand,ynor,yxor,yxnor );
	input a,b;
	output reg  yand, yor, ynot, ynand, ynor, yxor, yxnor;
	
	always @(*) begin
		 yand <= a & b;		// AND Operation
		 yor <= a | b;		// OR Operation
		 ynot <= ~a ;		// NOT Operation
		 ynand <= ~(a & b);	// NAND Operation
		 ynor <= ~(a | b);		//NOR Operation
		 yxor <= a ^ b;		//XOR Operation
		 yxnor <=~(a^b);		//XNOR Operation
	end
endmodule				// END of the module

/*
module allgate_GL ( a, b, yand,yor,ynot,ynand,ynor,yxor,yxnor );
	input a,b;
	output yand, yor, ynot, ynand, ynor, yxor, yxnor;

	and    G1(yand,a,b);		// AND Operation
	or      G2(yor,a, b);		// OR Operation
	not    G3(ynot,a) ;		// NOT Operation
	nand G4 (ynand,a,b);		// NAND Operation
	nor    G5(ynor,a,b);		//NOR Operation
	xor    G6(yxor,a,b);		//XOR Operation
	xnor  G7(yxnor,a,b);		//XNOR Operation
endmodule				// END of the module
*/




