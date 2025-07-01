module lab3_ex8(SW,LEDR,LEDG);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0]LEDG;
	assign LEDR=SW;
	Universal_shift_register DUT(.clk(SW[3]), .rst(SW[2]),.shift_control(SW[1]),.d_in(SW[0]),.d_out(LEDG[3:0]));
endmodule

module Universal_shift_register(
        input clk, // clock input
        input rst, // reset input
		input shift_control,
        input d_in, // data input
        output reg [3:0] d_out // data output
          );
        always @(posedge clk or posedge rst) begin
        if (rst) begin
                 d_out <= 4'b0000;
            end
        else
		    begin
			 if(shift_control) begin
                     d_out<={d_out[2:0],d_in};  // shift left 
			 end
			 else   begin
			        d_out<={d_in,d_out[3:1]};  // shift right
			 end
		   end	 
    end
endmodule