module lab3_ex6(SW,LEDR,LEDG);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0]LEDG;
	assign LEDR=SW;
	shift_right_register DUT(.clk(SW[2]), .rst(SW[1]),.d_in(SW[0]),.d_out(LEDG[3:0]));
endmodule

module shift_right_register(
        input clk, // clock input
        input rst, // reset input
        input d_in, // data input
        output reg [3:0] d_out // data output
          );
        always @(posedge clk or posedge rst) begin
        if (rst) begin
                 d_out <= 4'b0000;
            end
        else
             d_out<={d_in, d_out[3:1]};   
//this is a right shift condition , it is showing that in d_out the user given d_in will be msb and rest 3 bit of existing d_out will be at end means it is shifting right side 
//For left shift condition we can use as: d_out<={d_out[3:1], din};
    end
endmodule
