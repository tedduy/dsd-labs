module lab2_ex6(SW,LEDG,LEDR);
	input[17:0]SW;
	output[7:0] LEDG;
	output[17:0] LEDR;
	
	assign LEDR = SW;
	
	dec38_GL(.a(SW[2:0]),.d(LEDG[7:0]));
	//dec38_BH(.a(SW[2:0]),.d(LEDG[7:0]));
	
endmodule


module dec38_GL(a,d);
	input [2:0] a;
	output [7:0] d;

	wire [2:0] n_a;

	not g1(n_a[0],a[0]);
	not g2(n_a[1],a[1]);
	not g3(n_a[2],a[2]);
	
	and g4(d[0], n_a[2], n_a[1], n_a[0]);
    and g5(d[1], n_a[2], n_a[1], a[0]);
    and g6(d[2], n_a[2], a[1], n_a[0]);
    and g7(d[3], n_a[2], a[1], a[0]);
    and g8(d[4], a[2], n_a[1], n_a[0]);
    and g9(d[5], a[2], n_a[1], a[0]);
    and g10(d[6], a[2], a[1], n_a[0]);
    and g11(d[7], a[2], a[1], a[0]);
endmodule

/*

module dec38_BH(a,d);
input [2:0]  a;
output reg [7:0] d;

 always @( a )
	begin
          d=8'd0;
          case (a)
              3'b000: d[0]=1'b1;
              3'b001: d[1]=1'b1;
              3'b010: d[2]=1'b1;
              3'b011: d[3]=1'b1;
              3'b100: d[4]=1'b1;
              3'b101: d[5]=1'b1;
              3'b110: d[6]=1'b1;
              3'b111: d[7]=1'b1;
              default: d=8'd0;
          endcase
      end
endmodule

*/
	