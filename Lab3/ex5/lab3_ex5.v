module lab3_ex5(SW,LEDR,LEDG);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0] LEDG;
	
	assign LEDR=SW;
	
	T_flipflop (.clk(SW[2]),.rst(SW[1]),.t(SW[0]),.q(LEDG[7]),.q_bar(LEDG[6]));
      
endmodule

module T_flipflop (clk, rst, t, q, q_bar);
  
  input clk, rst, t;
  output reg q;
  output q_bar;
  
  // always@(posedge clk or posedge rst) // for asynchronous reset
  always@(posedge clk) begin // for synchronous reset
    if(rst) q <= 0;
    else begin
      q <= (t?~q:q);
    end
  end
  assign q_bar = ~q;
endmodule
