// Testbench
module tb_Single_Cycle_Processor;
    reg reset, clk;
    wire [31:0] W_PC_out, instruction, W_m2;
    wire [15:0] W_RD1, W_RD2, W_m1, W_ALUout;
    reg [127:0] instr_name;
    
    
    Single_Cycle_Processor_16bit dut(
        .reset(reset),
        .clk(clk),
        .W_PC_out(W_PC_out),
        .instruction(instruction),
        .W_RD1(W_RD1),
        .W_RD2(W_RD2),
        .W_m1(W_m1),
        .W_m2(W_m2),
        .W_ALUout(W_ALUout)
    );
    
    
    always #5 clk = ~clk;
    
    
    always @(instruction) begin
        case (instruction[31:26])
            6'b000000: begin 
                case (instruction[5:0]) // funct field
                    6'b100000: instr_name = "ADD       ";
                    6'b100010: instr_name = "SUB       ";
                    6'b011000: instr_name = "MULT      ";
                    6'b011010: instr_name = "DIV       ";
                    6'b100100: instr_name = "AND       ";
                    6'b100101: instr_name = "OR        ";
                    6'b100110: instr_name = "XOR       ";
                    6'b100111: instr_name = "NOR       ";
                    6'b101000: instr_name = "NAND      ";
                    6'b101010: instr_name = "XNOR      ";
                    6'b000000: instr_name = "SLL       ";
                    6'b000010: instr_name = "SRL       ";
                    6'b111000: instr_name = "ROL       ";
                    6'b110000: instr_name = "ROR       ";
                    default:   instr_name = "UNKNOWN_R ";
                endcase
            end
            6'b000100: instr_name = "BEQ       ";
            6'b100011: instr_name = "LW        ";
            6'b101011: instr_name = "SW        ";
            6'b001000: instr_name = "ADDI      ";
            6'b000101: instr_name = "BNE       ";
            6'b000010: instr_name = "J         ";
            6'b000011: instr_name = "JAL       ";
            default:   instr_name = "UNKNOWN   ";
        endcase
    end
    
    always @(posedge clk) begin
        $display($time,
            " reset=%b | clk=%b | PC=%4d | Inst=%-10s | Op=%6b | rs=%2d | rt=%2d | rd=%2d | zero=%b | Imm=%4h | ALU=%4h | RD1=%4h | RD2=%4h",
            reset, clk, W_PC_out, instr_name, instruction[31:26], 
            instruction[25:21], instruction[20:16], instruction[15:11], 
            dut.C11.zero, instruction[15:0], W_ALUout, W_RD1, W_RD2);
    end
    
    initial begin
        clk = 0;
        reset = 0;
        instr_name = "";
        
        
        $display("\n\t\t\t\t----------TEST SINGLE-CYCLE PROCESSOR----------\n");
        $display("\n\t\t\t\t----------R-TYPE INSTRUCTIONS TEST----------\n");
       
        #10 reset = 1;
        #10 reset = 0;
        #140 $display("\n\t\t\t\t----------I-TYPE INSTRUCTIONS TEST----------\n");
        
        
        #120 $display("\n\t\t\t\t----------J-TYPE INSTRUCTIONS TEST----------\n");
        
        #100 $finish;
    end
endmodule



//Single Cycle Processor 16bit	
module Single_Cycle_Processor_16bit(reset, clk,W_PC_out, instruction, W_RD1, W_RD2,W_m1,W_m2,W_ALUout);
	input reset, clk;
	output [31:0] W_PC_out, instruction, W_m2;
	output [15:0] W_RD1, W_RD2, W_m1, W_ALUout;
	wire [31:0] W_PC_in,W_PC_plus_1,W_Branch_add,W_m4,W_jump_PC;
	wire PCsrc,RegWrite,zero,ALUsrc,MemRead,MemWrite,MemtoReg,RegDst,Branch,jump,shift;
	wire [15:0] W_MemtoReg,W_RD1,W_RD2,W_ALUout,W_m1,W_RDm,W_m5;
	wire [3:0] ALUop;
	wire [4:0] W_m3;
    
	Program_Counter     C1(.clk(clk),.reset(reset),.PC_in( W_PC_plus_1),.PC_out(W_PC_out));
	Adder32Bit 	    C2(.input1(W_PC_out),.input2(32'd1),.out(W_PC_plus_1));
	Mux_32_bit          C3(.in0(W_PC_plus_1),.in1(W_m2),.mux_out(W_m4),.select(PCsrc));
	Mux_32_bit 	    C4(.in0(W_m4),.in1(W_jump_PC),.mux_out(W_PC_in),.select(jump));
	Adder32Bit          C5(.input1(W_PC_plus_1),.input2(W_Branch_add),.out(W_m2));
	Instruction_Memory  C6(.read_address(W_PC_out),.instruction(instruction),.reset(reset));
	Register_File_16bit C7(.clk(clk),.read_addr_1(instruction[25:21]),.read_addr_2(instruction[20:16]),.write_addr(W_m3),.write_data(W_MemtoReg),.RegWrite(RegWrite),.read_data_1(W_RD1),.read_data_2(W_RD2));
	Sign_Extension_16   C8(.sign_in(instruction[15:0]),.sign_out(W_Branch_add));
	Mux_16_bit 	    C9(.in0(W_RD2),.in1(instruction[15:0]),.mux_out(W_m1),.select(ALUsrc));
	Mux_16_bit          C10(.in0(W_RD1),.in1(instruction[15:0]),.mux_out(W_m5),.select(shift));
	ALU_16bit	    C11(.ALU_Sel(ALUop),.A(W_m5),.B(W_m1),.ALU_Out(W_ALUout),.zero(zero));
	Data_Memory_16bit   C12(.clk(clk),.addr(W_ALUout),.write_data(W_RD2),.read_data(W_RDm),.MemRead(MemRead),.MemWrite(MemWrite));
	Mux_16_bit          C13(.in0(W_ALUout),.in1(W_RDm),.mux_out(W_MemtoReg),.select(MemtoReg));
	Sign_Extension_26   C14(.sign_in(instruction[25:0]),.sign_out(W_jump_PC));
	Control              C15(.clk(clk),.Op_intstruct(instruction[31:26]),.ints_function(instruction[5:0]), .RegDst(RegDst),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOp(ALUop),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite),.Zero(zero),.Jump(jump),.Shift(shift));   
	Mux_5_bit 	    C16(.in0(instruction[20:16]),.in1(instruction[15:11]),.mux_out(W_m3),.select(RegDst));
	and		    C17(PCsrc,Branch,zero);
endmodule

// Control
module Control(clk, Op_intstruct, ints_function, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Zero, Jump,Shift);
    input clk,Zero;
    input [5:0] ints_function;
    input [5:0] Op_intstruct;
    output reg RegDst,Branch,MemRead,MemtoReg,Jump,MemWrite,ALUSrc,RegWrite,Shift;
    output reg [3:0] ALUOp;
    always @(*)
    begin
        case (Op_intstruct)
            6'b000000: begin // R-Type Instruction
                RegDst = 1;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;
                Shift =0;
                case (ints_function)
                    6'b100000: ALUOp = 4'b0000; // Addition
                    6'b100010: ALUOp = 4'b0001; // Subtraction
                    6'b011000: ALUOp = 4'b0010; // Multiplication
                    6'b011010: ALUOp = 4'b0011; // Division
                    6'b100100: ALUOp = 4'b0100; // Logical AND
                    6'b100101: ALUOp = 4'b0101; // Logical OR
                    6'b100110: ALUOp = 4'b0110; // Logical XOR
                    6'b100111: ALUOp = 4'b0111; // Logical NOR
                    6'b101000: ALUOp = 4'b1000; // Logical NAND
                    6'b101010: ALUOp = 4'b1001; // Logical XNOR
                    6'b000000: begin // Logical Shift Left
                        ALUOp = 4'b1010;
                        Shift = 1;
                    end
                     6'b000010: begin // Logical Shift Right
                        ALUOp = 4'b1011;
                        Shift = 1;
                    end
                    6'b111000: begin // Rotate Left (ROL)
			ALUOp = 4'b1100;
			Shift = 1; 
		    end
		    6'b110000: begin // Rotate Right (ROR)
			ALUOp = 4'b1101;
			Shift = 1; 
		    end
                    default:   ALUOp = 4'b0000;
                endcase
            end
            // I-Type Instruction
            6'b000100: begin // BEQ
                RegDst = 0;
                Jump = 0;
                Branch = (Zero == 1) ? 1 : 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 4'b1110;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
                Shift =0;
            end
            6'b100011: begin // LW
                RegDst = 0;
                Jump = 0;
                Branch = 0;
                MemRead = 1;
                MemtoReg = 1;
                ALUOp = 4'b0000;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
                Shift =0;
            end
            6'b101011: begin // SW
                RegDst = 0;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 4'b0000;
                MemWrite = 1;
                ALUSrc = 1;
                RegWrite = 0;
                Shift =0;
            end
            6'b001000: begin // ADDI
                RegDst = 0;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 4'b0000;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
		Shift =0;
            end
            6'b000101: begin // BNE
                RegDst = 0;
                Jump = 0;
                Branch = (Zero == 0) ? 1 : 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 4'b1111;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
		Shift =0;
            end
	    // J-Type Instruction
            6'b000010: begin // JUMP
                RegDst = 0;
                Jump = 1;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 4'b0000;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 0;
		Shift =0;
            end
            6'b000011: begin // JUMP and LINK
		RegDst= 1;
		Jump = 1;
		Branch = 0;
		MemRead  = 0;
		MemtoReg = 1;
		ALUOp  = 4'b0000;
		MemWrite= 0;
		ALUSrc = 0;
		RegWrite  = 1;
		Shift =0;
			end
	     default: begin // Default case
                RegDst = 0;
                Branch = 0;
                Jump = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 4'b0000;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
		Shift =0;
            end
        endcase
    end
endmodule
	
	
// Register File 16bit
module Register_File_16bit (clk,read_addr_1, read_addr_2, write_addr, write_data, RegWrite,read_data_1, read_data_2);
	input clk,RegWrite;
	input [4:0] read_addr_1, read_addr_2, write_addr;
	input [15:0] write_data;
	output [15:0] read_data_1, read_data_2;
	reg [15:0] Regfile [31:0];
	integer i;

	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			Regfile[i] = 16'b0;
		end
	Regfile[19]=1; // $s3 = 1
       	Regfile[17]=3; // $s1 = 3
       	Regfile[20]=2; // $s4 = 2
        Regfile[21]=5; // $s5 = 5
	end

	assign read_data_1 = Regfile[read_addr_1];
	assign read_data_2 = Regfile[read_addr_2];

	always @(posedge clk) begin
		if (RegWrite) begin
			Regfile[write_addr] <= write_data;
			//$display("write_addr=%h write_data=%h",write_addr,write_data);
		end
	end
endmodule


// ALU 16bit
module ALU_16bit(ALU_Sel, A, B, ALU_Out, zero);
	input [3:0] ALU_Sel; 
	input [15:0] A;  
	input [15:0] B; 
	output reg [15:0] ALU_Out; 
	output reg zero;
	parameter	ALU_OP_ADD	= 4'b0000, // Addition
			ALU_OP_SUB	= 4'b0001, // Subtraction
			ALU_OP_MUL      = 4'b0010, // Multiplication
			ALU_OP_DIV      = 4'b0011, // Division
			ALU_OP_AND	= 4'b0100, // Logical and 
			ALU_OP_OR	= 4'b0101, // Logical or
			ALU_OP_XOR	= 4'b0110, // Logical xor 
			ALU_OP_NOR	= 4'b0111, // Logical nor
			ALU_OP_NAND	= 4'b1000, // Logical nand 
			ALU_OP_XNOR     = 4'b1001, // Logical xnor
			ALU_OP_SHL      = 4'b1010, // Logical shift left
			ALU_OP_SHR      = 4'b1011, // Logical shift right
			ALU_OP_ROL      = 4'b1100, // Rotate left
			ALU_OP_ROR      = 4'b1101, // Rotate right
			ALU_OP_BEQ	= 4'b1110, // Equal comparison
			ALU_OP_BNE      = 4'b1111; // Not Equal comparison 
	always @(*)
		begin
		 case(ALU_Sel)
			ALU_OP_ADD 	: begin
				               zero=1'bx;
				               ALU_Out = A + B;
				          end
			ALU_OP_SUB 	: ALU_Out = A - B;
			ALU_OP_MUL      : ALU_Out = A * B;
			ALU_OP_DIV      : ALU_Out = A / B;
			ALU_OP_AND 	: ALU_Out = A & B;
			ALU_OP_OR	: ALU_Out = A | B;
			ALU_OP_XOR	: ALU_Out = A ^ B;
			ALU_OP_NOR	: ALU_Out = ~(A | B);
			ALU_OP_NAND	: ALU_Out = ~(A & B);
			ALU_OP_XNOR     : ALU_Out = ~(A ^ B);
			ALU_OP_SHL      : ALU_Out = A<<1;
			ALU_OP_SHR      : ALU_Out = A>>1;
			ALU_OP_ROL      : ALU_Out = {A[6:0],A[7]};
			ALU_OP_ROR      : ALU_Out = {A[0],A[7:1]};
			ALU_OP_BEQ	: begin
						zero = (A==B)?1'b1:1'b0;
						ALU_Out = (A==B)?16'd1:16'd0;
					  end
			ALU_OP_BNE      : begin
						zero = (A!=B)?1'b1:1'b0; 
						// zero here is different from the above zero
						// zero here is equal to 1, when A is different from B
						// zero here is equal to 0, when A is the same as B
						ALU_Out = (A!=B)?16'd1:16'd0;
					  end
		endcase
	end
endmodule


// Sign Extension 16 bit
module Sign_Extension_16 (sign_in, sign_out);
    parameter N = 16;          
    input [N-1:0] sign_in;     
    output [31:0] sign_out;   

    assign sign_out = {{(32-N){sign_in[N-1]}}, sign_in};
endmodule


// Sign Extension 26 bit
module Sign_Extension_26 (sign_in, sign_out);
    parameter N = 26;
	input [N-1:0] sign_in;     
    output [31:0] sign_out;   

    assign sign_out = {{(32-N){sign_in[N-1]}}, sign_in};
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


// Program Counter 
module Program_Counter(clk, reset, PC_in, PC_out);
    input clk, reset;
    input [31:0] PC_in;
    output reg [31:0] PC_out;
    initial begin 
        PC_out = 32'b0;
    end
    
    always @(posedge clk) begin
        if(reset) 
            PC_out <= 32'b0;
        else
            PC_out <= PC_in;
    end
endmodule


// Mux 32_bit
module Mux_32_bit (in0, in1, mux_out, select);
	parameter N=32;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input select;
	assign mux_out = select ? in1 : in0;
endmodule


// Mux 16 bit
module Mux_16_bit (in0, in1, mux_out, select);
	parameter N=16;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input select;
	assign mux_out = select ? in1 : in0;
endmodule


// Mux 5 bit
module Mux_5_bit (in0, in1, mux_out, select);
	parameter N=5;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input select;
	assign mux_out = select ? in1 : in0;
endmodule


//Data Memory 16 bit
module Data_Memory_16bit (clk,addr,write_data,read_data,MemRead,MemWrite);
	input clk;
	input [15:0] addr;
	input [15:0] write_data;
	output reg [15:0] read_data;
	input MemRead;
	input MemWrite;
	integer i;
	reg [15:0] DMemory [0:255];  

	initial begin
		for (i = 0; i < 256; i = i + 1) begin
			DMemory[i] = 16'h0000;
		end
	end

	always @(posedge clk) begin
		if (MemWrite) begin
			DMemory[addr] <= write_data;
			//$display("Memory Write: Address=%h Data=%h", addr, write_data);
		end
	end

	always @(*) begin
		if (MemRead)
			read_data = DMemory[addr];
		else
			read_data = 16'h0000;
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