module lab2_ex5(SW,LEDG,LEDR);
	input[17:0]SW;
	output[7:0] LEDG;
	output[17:0] LEDR;
	
	assign LEDR = SW;
	
	encoder83_GL(.a(SW[7:0]),.y(LEDG[7:5]));
	//priorityencoder_83(.en(SW[8]),.i(SW[7:0]),.y(LEDG[7:5]));
endmodule

module encoder83_GL(a,y);
	input [7:0] a;
	output [2:0] y;
	
	or g1(y[0],a[1],a[3],a[5],a[7]);
	or g2(y[1],a[2],a[3],a[6],a[7]);
	or g3(y[2],a[4],a[5],a[6],a[7]);
endmodule

/*
module priorityencoder_83(en,i,y);
  // declare
  input en;
  input [7:0]i;
  // store and declare output values
  output reg [2:0]y;
  always @(en,i)
  begin
    if(en==1)
      begin
        // priority encoder
        // if condition to choose 
        // output based on priority. 
        if(i[7]==1) y=3'b111;
        else if(i[6]==1) y=3'b110;
        else if(i[5]==1) y=3'b101;
        else if(i[4]==1) y=3'b100;
        else if(i[3]==1) y=3'b011;
        else if(i[2]==1) y=3'b010;
        else if(i[1]==1) y=3'b001;
        else
        y=3'b000;
      end
     // if enable is zero, there is
     // an high impedance value. 
    else y=3'bzzz;
  end
endmodule
*/
