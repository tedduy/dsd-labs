module Lab1_ex3(SW,LEDG,LEDR);
	input [17:0] SW;
	output [7:0] LEDG;
	output [17:0] LEDR;
	
	assign LEDR = SW;
	
	//full_adder_DF(.a(SW[2]),.b(SW[1]),.cin(SW[0]),.S(LEDG[7]),.Cout(LEDG[6]));
	//full_adder_BH1(.a(SW[2]),.b(SW[1]),.cin(SW[0]),.S(LEDG[7]),.Cout(LEDG[6]));
	//full_adder_BH2(.a(SW[2]),.b(SW[1]),.cin(SW[0]),.S(LEDG[7]),.Cout(LEDG[6]));
	//full_adder_BH3(.a(SW[2]),.b(SW[1]),.cin(SW[0]),.S(LEDG[7]),.Cout(LEDG[6]));
	full_adder_GL(.a(SW[2]),.b(SW[1]),.cin(SW[0]),.S(LEDG[7]),.Cout(LEDG[6]));
endmodule 

/*
module full_adder_DF(a, b, cin,S, Cout);
  input a,b,cin;
  output S, Cout;	
	
  assign S = a ^ b ^ cin;
  assign Cout = (a & b) | (b & cin) | (a & cin);
endmodule


module full_adder_BH1 (a, b, cin,  S,  Cout);
 input a,b,cin;
 output reg S,Cout;
 always @(a or b or cin)
  begin 

   case ({a , b , cin})
     3'b000: begin S = 0; Cout = 0; end 
     3'b001: begin S = 1; Cout = 0; end 
     3'b010: begin S = 1; Cout = 0; end 
     3'b011: begin S = 0; Cout = 1; end 
     3'b100: begin S = 1; Cout = 0; end 
     3'b101: begin S = 0; Cout = 1; end 
     3'b110: begin S = 0; Cout = 1; end 
     3'b111: begin S = 1; Cout = 1; end 
   endcase 
  end
endmodule


module full_adder_BH2( a, b, cin, S, Cout);

 input wire a, b, cin;
 output reg S, Cout;

 always @(a or b or cin) begin
	if(a==0 && b==0 && cin==0)
	 begin
	   S=0;
	   Cout=0;
     end

 else if(a==0 && b==0 && cin==1)
  begin
   S=1;
   Cout=0;
  end

 else if(a==0 && b==1 && cin==0)
  begin
   S=1;
   Cout=0;
  end

 else if(a==0 && b==1 && cin==1)
  begin
   S=0;
   Cout=1;
  end

 else if(a==1 && b==0 && cin==0)
  begin
   S=1;
   Cout=0;
  end

 else if(a==1 && b==0 && cin==1)
  begin
   S=0;
   Cout=1;
  end

 else if(a==1 && b==1 && cin==0)
  begin
   S=0;
   Cout=1;
  end

 else if(a==1 && b==1 && cin==1)
  begin
   S=1;
   Cout=1;
  end

end

endmodule


module full_adder_BH3(a,b,cin,S,Cout);
	output reg S,Cout;
	input  a,b,cin;
 
	always @ (a,b,cin) 
	  begin
		S   <= a^ b^cin;
		Cout <=(a&b) | (b&cin) | (cin&a);
	  end
endmodule
*/

module full_adder_GL(a,b,cin,S,Cout);
	output S,Cout;
	input a,b,cin;
	wire x,y,z;
	
	xor g1(x,a,b);
    xor g2(S,x,cin);
	and g3(y,x,cin);
	and g4(z,a,b);
	or  g5(Cout,z,y);
endmodule






