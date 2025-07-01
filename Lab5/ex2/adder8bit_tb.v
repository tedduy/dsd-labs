`timescale 1ns/1ps

module Adder8Bit_tb;
    reg [7:0] input1, input2;
    wire [7:0] out;

  
    Adder8Bit uut (
        .input1(input1),
        .input2(input2),
        .out(out)
    );

    initial begin
        // Test Case 1
        input1 = 8'd15; 
        input2 = 8'd20; 
        #10;
        $display("Test Case 1: input1 = %d, input2 = %d, out = %d", input1, input2, out);

        // Test Case 2
        input1 = 8'd100;
        input2 = 8'd28;
        #10;
        $display("Test Case 2: input1 = %d, input2 = %d, out = %d", input1, input2, out);

        // Test Case 3
        input1 = 8'd254; 
        input2 = 8'd1;
        #10;
        $display("Test Case 3: input1 = %d, input2 = %d, out = %d", input1, input2, out);

        // Test Case 4
        input1 = 8'd0;
        input2 = 8'd0;
        #10;
        $display("Test Case 4: input1 = %d, input2 = %d, out = %d", input1, input2, out);

        
        $finish;
    end

endmodule
