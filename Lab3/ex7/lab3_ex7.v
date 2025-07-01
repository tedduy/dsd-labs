module lab3_ex7(SW,LEDR,LEDG);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0]LEDG;
	assign LEDR=SW;
	shift_left_register DUT(.clk(SW[2]), .rst(SW[1]),.d_in(SW[0]),.d_out(LEDG[3:0]));
endmodule

module shift_left_register(
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
             d_out<={d_out[2:0],d_in};   
    end
endmodule