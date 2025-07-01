module lab3_ex2(SW,LEDR,LEDG);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0] LEDG;
	
	assign LEDR=SW;
	
	D_flipflop_sync(.d(SW[2]),.rst(SW[1]),.clk(SW[0]),.q(LEDG[7]));
endmodule


module D_flipflop_sync ( 
     input clk, rst, 
     input d, 
     output reg q 
); 
always@(posedge clk) 
  begin 
if(rst) q <= 0; 
else q <= d; 
end 
endmodule
