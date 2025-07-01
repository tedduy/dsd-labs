module lab2_ex3(SW,LEDG,LEDR);
	input[17:0]SW;
	output[7:0] LEDG;
	output[17:0] LEDR;
	
	assign LEDR = SW;
	
	//encoder42_GL(.a(SW[3:0]),.y(LEDG[7:6]));
	//encoder42_DF(.a(SW[3:0]),.y(LEDG[7:6]));
	encoder42_BH(.a(SW[3:0]),.y(LEDG[7:6]));
endmodule
/*
module encoder42_GL(a,y);
	input [3:0]a;
	output [1:0]y;
	
    wire n_a2,w;
    
    not (n_a2, a[2]);
  

    and (w, n_a2,a[1]);
    or (y[0], w, a[3]);  
    or (y[1], a[2], a[3]);  

endmodule


module encoder42_DF(a,y);
	input [3:0]a;
	output [1:0]y;
   
    assign y[0] = a[1] | a[3];
    assign y[1] = a[2] | a[3];
endmodule
*/

module encoder42_BH(a,y);
	input [3:0]a;
	output reg [1:0]y;

    always @(*) begin
        case (1'b1) 
            a[3]: y = 2'b11;
            a[2]: y = 2'b10;
            a[1]: y = 2'b01;
            a[0]: y = 2'b00;
            default: y = 2'b00;
        endcase
    end

endmodule

