module testbench_Instruction_Memory;
    reg reset;
    reg [7:0] read_address;
    wire [31:0] instruction;

    Instruction_Memory IM (
        .reset(reset),
        .read_address(read_address),
        .instruction(instruction)
    );

    initial begin
      
        $monitor("Time=%0d reset=%b read_address=%b instruction=%h", $time, reset, read_address, instruction);

        reset = 0;
        read_address = 8'b00000000;

        // Test Case 1
        #5 reset = 1;  
        #10 reset = 0; 

        // Test Case 2
        #10 read_address = 8'b00000000;  // Address 0
        #10 read_address = 8'b00000001;  // Address 1
        #10 read_address = 8'b00000010;  // Address 2
        #10 read_address = 8'b00000011;  // Address 3
        #10 read_address = 8'b00000100;  // Address 4
        #10 read_address = 8'b00000101;  // Address 5
        #10 read_address = 8'b00000110;  // Address 6
        #10 read_address = 8'b00000111;  // Address 7
        #10 read_address = 8'b00011101;  // Address 29
        

        // End simulation
        #50 $finish;
    end
endmodule
