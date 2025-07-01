// Testbench
module tb_Instruction_Memory;
    reg reset;
    reg [31:0] read_address;
    wire [31:0] instruction;

    Instruction_Memory uut(.reset(reset),.read_address(read_address),.instruction(instruction));

    initial begin
      	
	$display("\n------Test Instruction Memory------");

        $monitor("Time=%0d | reset=%b | read_address=%2d | instruction=%h", $time, reset, read_address, instruction);

        reset = 0;
        read_address = 32'd0;

        // Test Case 1
        #5 reset = 1;  
        #10 reset = 0; 

        // Test Case 2
        #10 read_address = 32'd0;  // Address 0
        #10 read_address = 32'd0;  // Address 0
        #10 read_address = 32'd1;  // Address 1
        #10 read_address = 32'd10;  // Address 10
        #10 read_address = 32'd3;  // Address 3
        #10 read_address = 32'd4;  // Address 4
        #10 read_address = 32'd16;  // Address 16
        #10 read_address = 32'd6;  // Address 6
        #10 read_address = 32'd7;  // Address 7
        #10 read_address = 32'd29;  // Address 29
        

        #50 $finish;
    end
endmodule


// Instruction Memory
module Instruction_Memory (read_address, instruction, reset);
	input reset;
	input [31:0] read_address;
	output [31:0] instruction;
	reg [31:0] Imemory [256:0];
	integer i;
	assign instruction = Imemory[read_address];
	always @(posedge reset)
	begin
	for (i=0; i<32; i=i+1) 
		begin  
		  Imemory[i] = 32'b0;
		end
		/*Test R-type*/
		// add $s6, $s5, $s4          R22 = R21 + R20 = 0x7 (0x5 + 0x2)
		Imemory[0] = 32'b000000_10101_10100_10110_00000_100000;
		// sub $s6, $s5, $s4          R22 = R21 - R20 = 0x3 (0x5 - 0x2)
		Imemory[1] = 32'b000000_10101_10100_10110_00000_100010;
		// mult $s5, $s4              R21 * R20 = 0xA (0x5 * 0x2)
		Imemory[2] = 32'b000000_10101_10100_00000_00000_011000;
		// div $s5, $s4               R21 / R20 = 0x2 (0x5 / 0x2)
		Imemory[3] = 32'b000000_10101_10100_00000_00000_011010;
		// and $s6, $s5, $s4          R22 = AND(R21, R20) = 0x0 (0x5 AND 0x2)
		Imemory[4] = 32'b000000_10101_10100_10110_00000_100100;
		// or $s6, $s5, $s4           R22 = OR(R21, R20) = 0x7 (0x5 OR 0x2)
		Imemory[5] = 32'b000000_10101_10100_10110_00000_100101;
		// xor $s6, $s5, $s4          R22 = XOR(R21, R20) = 0x7 (0x5 XOR 0x2)
		Imemory[6] = 32'b000000_10101_10100_10110_00000_100110;
		// nor $s6, $s5, $s4          R22 = NOR(R21, R20) = 0xFFFFFFF8 (NOR of 0x5 and 0x2)
		Imemory[7] = 32'b000000_10101_10100_10110_00000_100111;
		// nand $s6, $s5, $s4         R22 = NAND(R21, R20) = 0xFFFFFFFD (NAND of 0x5 and 0x2)
		Imemory[8] = 32'b000000_10101_10100_10110_00000_101000;
		// xnor $s6, $s5, $s4         R22 = XNOR(R21, R20) = 0xFFFFFFFE (XNOR of 0x5 and 0x2)
		Imemory[9] = 32'b000000_10101_10100_10110_00000_101010;
		// sll $s6, $s5, $s4          R22 = R21 << R20 = 0x14 (0x5 << 0x2)
		Imemory[10] = 32'b000000_10101_10100_10110_00000_000000;
		// srl $s6, $s5, $s4          R22 = R21 >> R20 = 0x1 (0x5 >> 0x2)
		Imemory[11] = 32'b000000_10101_10100_10110_00000_000010;
		// rol $s6, $s5               R22 = R21 rotated 1 bit left = 0xA (rotate 0x5 left by 1)
		Imemory[12] = 32'b000000_10101_00000_10110_00000_111000;
		// ror $s6, $s5               R22 = R21 rotated 1 bit right = 0x2 (rotate 0x5 right by 1)
		Imemory[13] = 32'b000000_10101_00000_10110_00000_110000;
		
		/*Test I-type*/
        	// addi $s1, $s1, 0x05        R17 = 0x4E => R17 = R17 + 0x5 = 0x53
        	Imemory[14] = 32'b001000_10001_10001_00000_00000_000101;
        	// addi $s1, $s1, 0x05        R17 = 0x53 => R17 = R17 + 0x5 = 0x58
        	Imemory[15] = 32'b001000_10001_10001_00000_00000_000101;
        	// addi $s3, $s1, 0x10        R17 = 0x58 => R19 = R17 + 0x10 = 0x68
        	Imemory[16] = 32'b001000_10001_10011_00000_00000_010000;
        	// sw  $s3, 0x04($s1)        Memory[$s1 + 0x04] = $s3 => Memory[0x58 + 0x04] = 0x68
        	Imemory[17] = 32'b101011_10001_10011_00000_00000_000100;
        	// lw $s7, 0x04($s1)        $s7 = Memory[$s1 + 0x04] = 0x68
		Imemory[18] = 32'b100011_10001_10111_00000_00000_000100;
        	// beq $s7, $s3, 0x08        R23 (0x68) == R19 (0x68) move to Imemory[22 + 8 + 1]
        	Imemory[19] = 32'b000100_10111_10011_00000_00000_001000;
        	// addi $s1, $zero, 0x11      R17 = 0x11
        	Imemory[20] = 32'b001000_00000_10001_00000_00000_010001;
        	// addi $s1, $zero, 0x22      R17 = 0x22
        	Imemory[21] = 32'b001000_00000_10001_00000_00000_100010;
        	// addi $s1, $zero, 0x33      R17 = 0x33
        	Imemory[22] = 32'b001000_00000_10001_00000_00000_110011;
        	// bne $s1, $s7, 0x04        (R17 (0x33) != R23 (0x68)) move to Imemory[26 + 4 + 1]
        	Imemory[23] = 32'b000101_10001_10111_00000_00000_000100;
        	// addi $s2, $zero, 0x66      R18 = 0x66
        	Imemory[24] = 32'b001000_00000_10010_00000_00001_100110;
        	// addi $s2, $zero, 0x77      R18 = 0x77
        	Imemory[25] = 32'b001000_00000_10010_00000_00001_110111;
        
        	/* Test J-type  */
	 	// j 0x74 (JUMP to Imemory[116])
		Imemory[26] = 32'b000010_00000_00000_00000_00001_110100; 
		// jal 0x74 (Jump and Link to Imemory[116])		
		Imemory[27] = 32'b000011_00000_00000_00000_00001_110100; 
		// j 0x78 (JUMP to Imemory[120]) 
		Imemory[28] = 32'b000010_00000_00000_00000_00001_111000;  
		// jal 0x78 (Jump and Link to Imemory[120])
		Imemory[29] = 32'b000011_00000_00000_00000_00001_111000;  
		// j 0x64 (JUMP to Imemory[100])
		Imemory[30] = 32'b000010_00000_00000_00000_00001_100100;  
		// jal 0x68 (Jump and Link to Imemory[104])
		Imemory[31] = 32'b000011_00000_00000_00000_00001_101000; 
	 	// j 0x6C (JUMP to Imemory[108])
		Imemory[32] = 32'b000010_00000_00000_00000_00001_101100; 
		// jal 0x70 (Jump and Link to Imemory[112])
		Imemory[33] = 32'b000011_00000_00000_00000_00001_110000;  
		// j 0x74 (JUMP to Imemory[116])
		Imemory[34] = 32'b000010_00000_00000_00000_00001_110100; 	
		// j 0x7C (JUMP to Imemory[124])
		Imemory[35] = 32'b000010_00000_00000_00000_00001_111100;  

	end
endmodule