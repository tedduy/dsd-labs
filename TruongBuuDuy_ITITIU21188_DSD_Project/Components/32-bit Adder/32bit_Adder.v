module tb_Adder32Bit;

    reg signed [31:0] input1, input2;
    wire [31:0] out;

        Adder32Bit uut (.input1(input1),.input2(input2),.out(out));

    initial begin
	 $display("------Test Adder 32 bit------");

        $monitor("Time=%0t | input1 = %d | input2 = %d | out = %d", $time, input1, input2, out);

        // Test case 1: Add two positive numbers
        input1 = 32'd25;
        input2 = 32'd30;
        #10; 
        // Test case 2: Add a positive and a negative number
        input1 = 32'd100;
        input2 = -32'd50;
        #10; 
        // Test case 3: Add two large numbers
        input1 = 32'd4294967295; // Max unsigned 32-bit value
        input2 = 32'd1;
        #10; 
        
        $finish;
    end

endmodule


// Adder 32 bit
module Adder32Bit(input1, input2, out);
    input [31:0] input1, input2;
    output [31:0] out;
    reg [31:0]out;
    always@( input1 or input2)
        begin
            out <= input1 + input2;
        end
endmodule
