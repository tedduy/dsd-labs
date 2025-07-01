module lab3_ex3(SW,LEDR,LEDG);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0] LEDG;
	
	assign LEDR=SW;
	
    SR_flipflop(.s(SW[1]),.r(SW[0]),.clk(SW[2]),.rst(SW[3]),.q(LEDG[7]),.q_bar(LEDG[6]));
endmodule

module SR_flipflop (s,r,clk,rst,q,q_bar);
  input clk, rst, s, r;
  output reg q;
  output q_bar;
  
  // always@(posedge clk or posedge rst) // for asynchronous reset
  always@(posedge clk) begin // for synchronous reset
    if(rst) q <= 0;
    else begin
      case({s,r})
        2'b00: q <= q;    // No change
        2'b01: q <= 1'b0; // reset
        2'b10: q <= 1'b1; // set
        2'b11: q <= 1'bx; // Invalid inputs
      endcase
    end
  end
  assign q_bar = ~q;
endmodule