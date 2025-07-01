module lab3_ex9(SW,LEDR,LEDG);
	input [17:0] SW;
	output [17:0] LEDR;
	output [7:0]LEDG;
	assign LEDR=SW;
	Universal_shift_register_N_bit(.clk(SW[2]), .rst(SW[1]),.d_in(SW[0]),.d_out(LEDG[N-1:0]));
	defparam DUT.N=4;
endmodule

module Universal_shift_register #(parameter N = 4) (
    input clk,          // clock input
    input rst,          // reset input
    input shift_control, // control for shift direction
    input d_in,         // data input
    output reg [N-1:0] d_out // data output
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            d_out <= {N{1'b0}}; // Reset the output to 0's
        end
        else begin
            if (shift_control) begin
                d_out <= {d_out[N-2:0], d_in}; // Shift left (MSB gets d_in)
            end
            else begin
                d_out <= {d_in, d_out[N-1:1]}; // Shift right (LSB gets d_in)
            end
        end
    end
endmodule