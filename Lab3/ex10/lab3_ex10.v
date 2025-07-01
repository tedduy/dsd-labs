module lab3_ex10(SW,LEDR,LEDG);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0] LEDG;
	assign LEDR=SW;
	parameter N = 4;
	asynchronous_counter DUT(.clk(SW[2]),.rst(SW[1]),.up_down(SW[0]),.cnt(LEDG[N-1:0]));
	defparam DUT.N=N;
endmodule


module asynchronous_counter #(parameter N = 4) (
  input clk,            
  input rst,            
  input up_down,        
  output reg [N-1:0] cnt 
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      cnt <= {N{1'b0}};
    end
    else begin
      if (up_down && cnt < {N{1'b1}}) begin
        cnt <= cnt + 1'b1;
      end
      else if (!up_down && cnt > 0) begin
        cnt <= cnt - 1'b1;
      end
    end
  end
endmodule
