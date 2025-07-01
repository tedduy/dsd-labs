// Testbench 
module tb_Mux_N_bit;
    reg [4:0] in0_5, in1_5;           
    reg [15:0] in0_16, in1_16;         
    reg [31:0] in0_32, in1_32;         
    wire [4:0] mux_out_5;              
    wire [15:0] mux_out_16;            
    wire [31:0] mux_out_32;        
    reg select;

    Mux_N_bit #(5) uut_5 (.in0(in0_5), .in1(in1_5), .mux_out(mux_out_5), .select(select));
    Mux_N_bit #(16) uut_16 (.in0(in0_16), .in1(in1_16), .mux_out(mux_out_16), .select(select));
    Mux_N_bit #(32) uut_32 (.in0(in0_32), .in1(in1_32), .mux_out(mux_out_32), .select(select));

    initial begin
        select = 0;
        in0_5 = 5'b00001;   in1_5 = 5'b00010;           
        in0_16 = 16'h1234;  in1_16 = 16'h5678;          
        in0_32 = 32'hABCDEF12; in1_32 = 32'h98765432; 
	
        $display("------Test Mux N bit------");
        $monitor("Time=%0t Select=%b \n\tN=5  : in0=%b| in1=%b| mux_out=%b \n\tN=16: in0=%h| in1=%h| mux_out=%h \n\tN=32: in0=%h| in1=%h| mux_out=%h",
            $time, select, in0_5, in1_5, mux_out_5, in0_16, in1_16, mux_out_16,  in0_32, in1_32, mux_out_32);
        
        #1;  

        #10;
        select = 0;
        in0_5 = 5'b10101; in1_5 = 5'b11011;
        in0_16 = 16'hA5A5; in1_16 = 16'h5A5A;
        in0_32 = 32'h12345678; in1_32 = 32'h87654321;

        #10;
        select = 1;
        in0_5 = 5'b01010; in1_5 = 5'b11111;
        in0_16 = 16'hABCD; in1_16 = 16'hDCBA;
        in0_32 = 32'h1A2B3C4D; in1_32 = 32'h4D3C2B1A;

        #10;
        $finish;  
    end
endmodule


// Mux N bit
module Mux_N_bit (in0, in1, mux_out, select);
	parameter N=5;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input select;
	assign mux_out = select ? in1 : in0;
endmodule