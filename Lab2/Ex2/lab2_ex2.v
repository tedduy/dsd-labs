module lab2_ex2(SW,LEDG,LEDR);
	input[17:0]SW;
	output[7:0] LEDG;
	output[17:0] LEDR;
	
	assign LEDR = SW;
	
	//demux18_GL(.a(SW[4]),.s(SW[2:0]),.y(LEDG[7:0]));
	//demux18_DF(.a(SW[4]),.s(SW[2:0]),.y(LEDG[7:0]));
	demux18_BH(.a(SW[4]),.s(SW[2:0]),.y(LEDG[7:0]));
endmodule

/*
module demul18_GL(a,s,y);
	input a;
	input [2:0]s;
	output[7:0]y;
	
    wire [2:0] n_s;

    not (n_s[0], s[0]);
    not (n_s[1], s[1]);
    not (n_s[2], s[2]);

    and (y[0], a, n_s[2], n_s[1], n_s[0]); 
    and (y[1], a, n_s[2], n_s[1], s[0]); 
    and (y[2], a, n_s[2], s[1], n_s[0]); 
    and (y[3], a, n_s[2], s[1], s[0]); 
    and (y[4], a, s[2], n_s[1], n_s[0]); 
    and (y[5], a, s[2], n_s[1], s[0]); 
    and (y[6], a, s[2], s[1], n_s[0]); 
    and (y[7], a, s[2], s[1], s[0]); 

endmodule


module demul18_DF(a,s,y);
	input a;
	input [2:0]s;
	output[7:0]y;

	
	assign y[0] = a & (~s[0]) & (~s[1]) & (~s[2]);
	assign y[1] = a & (~s[1]) & s[0] & (~s[2]);
	assign y[2] = a & s[1] & (~s[0]) & (~s[2]);
	assign y[3] = a & s[1] & s[0] & (~s[2]);
	assign y[4] = a & (~s[0]) & (~s[1]) & (s[2]);
	assign y[5] = a & (~s[1]) & s[0] & (s[2]);
	assign y[6] = a & s[1] & (~s[0]) & (s[2]);
	assign y[7] = a & s[1] & s[0] & (s[2]);
endmodule
*/
module demux18_BH(a,s,y);
    input a;
	input [2:0]s;
	output reg [7:0]y;
	
    always @(*) begin
        y[0] = (s == 3'b000) ? a : 1'b0;
        y[1] = (s == 3'b001) ? a : 1'b0;
        y[2] = (s == 3'b010) ? a : 1'b0;
        y[3] = (s == 3'b011) ? a : 1'b0;
        y[4] = (s == 3'b100) ? a : 1'b0;
        y[5] = (s == 3'b101) ? a : 1'b0;
        y[6] = (s == 3'b110) ? a : 1'b0;
        y[7] = (s == 3'b111) ? a : 1'b0;
    end
endmodule
