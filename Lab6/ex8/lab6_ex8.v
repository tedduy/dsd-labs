module lab6_ex8(SW,LEDG,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7);
	input [17:0]SW;
	output [17:0]LEDR;
	output [7:0]LEDG;
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	wire [31:0] W_PC_out,W_LED_SEG, W_m2;
	wire [15:0] W_RD1, W_RD2, W_m1, W_ALUout;

	
	assign LEDR=SW;
	hex_ssd (W_RD1 [3:0], HEX0);
	hex_ssd (W_RD1[7:4], HEX1);
	hex_ssd ( W_RD2[3:0],HEX2);
	hex_ssd ( W_RD2[7:4],HEX3);
	hex_ssd (W_PC_out[3:0],HEX4);
	hex_ssd (W_PC_out[7:4],HEX5);
	hex_ssd (W_ALUout[3:0],HEX6);
	hex_ssd (W_ALUout[7:4],HEX7);


		beq_Processor  (.reset(SW[0]),.clk(SW[1]),.W_PC_out(W_PC_out),.instruction(W_LED_SEG),.W_RD1(W_RD1),.W_RD2(W_RD2),.W_m1(W_m1),.W_m2(W_m2),.W_ALUout(W_ALUout));
	endmodule
module hex_ssd (BIN, SSD);
	  input [3:0] BIN;
	  output reg [0:6] SSD;

	  always begin
		case(BIN)
		  0:SSD=7'b0000001;
		  1:SSD=7'b1001111;
		  2:SSD=7'b0010010;
		  3:SSD=7'b0000110;
		  4:SSD=7'b1001100;
		  5:SSD=7'b0100100;
		  6:SSD=7'b0100000;
		  7:SSD=7'b0001111;
		  8:SSD=7'b0000000;
		  9:SSD=7'b0001100;
		  10:SSD=7'b0001000;
		  11:SSD=7'b1100000;
		  12:SSD=7'b0110001;
		  13:SSD=7'b1000010;
		  14:SSD=7'b0110000;
		  15:SSD=7'b0111000;
		endcase
	  end
	endmodule

	
	
	
	module beq_Processor (reset, clk,W_PC_out, instruction, W_RD1, W_RD2,W_m1,W_m2,W_ALUout);
		input reset, clk;
		output [31:0] W_PC_out, instruction, W_m2;
		output [15:0] W_RD1, W_RD2, W_m1, W_ALUout;
		wire [31:0] W_PC_in,W_PC_plus_1,W_Branch_add;
		wire PCsrc,RegWrite,zero,ALUsrc,MemRead,MemWrite,MemtoReg,RegDst,Branch,jump;
		wire [15:0] W_MemtoReg,W_RD1,W_RD2,W_ALUout,W_m1,W_RDm;
		wire [3:0] ALUop;
		wire [4:0] W_m3;

	    
	    
		Program_Counter     C1(.clk(clk),.reset(reset),.PC_in( W_PC_plus_1),.PC_out(W_PC_out));
		Adder32Bit 		    C2(.input1(W_PC_out),.input2(32'd1),.out(W_PC_plus_1));
		Mux_32_bit 		    C3(.in0(W_PC_plus_1),.in1(W_m2),.mux_out(W_PC_in),.select(PCsrc));
		Adder32Bit          C4(.input1(W_PC_plus_1),.input2(W_Branch_add),.out(W_m2));
		Instruction_Memory  C5 (.read_address(W_PC_out),.instruction(instruction),.reset(reset));
		Register_File_16bit C6 (.clk(clk),.read_addr_1(instruction[25:21]),.read_addr_2(instruction[20:16]),.write_addr(W_m3),.write_data(W_MemtoReg),.RegWrite(RegWrite),.read_data_1(W_RD1),.read_data_2(W_RD2));
		Sign_Extension 		C7(.sign_in(instruction[15:0]),.sign_out(W_Branch_add));
		Mux_16_bit 		    C8(.in0(W_RD2),.in1(instruction[15:0]),.mux_out(W_m1),.select(ALUsrc));
		ALU_16bit			C9(.ALU_Sel(ALUop),.A(W_RD1),.B(W_m1),.ALU_Out(W_ALUout),.zero(zero));
		Data_Memory_16bit   C10(.clk(clk),.addr(W_ALUout),.write_data(W_RD2),.read_data(W_RDm),.MemRead(MemRead),.MemWrite(MemWrite));
		Mux_16_bit 		    C11(.in0(W_ALUout),.in1(W_RDm),.mux_out(W_MemtoReg),.select(MemtoReg));
		Control             C12(.clk(clk),.Op_intstruct(instruction[31:26]),.ints_function(instruction[5:0]), .RegDst(RegDst),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOp(ALUop),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite),.Zero(zero),.Jump(jump));
		Mux_5_bit 		    C13(.in0(instruction[20:16]),.in1(instruction[15:11]),.mux_out(W_m3),.select(RegDst));
	endmodule


module Control(clk, Op_intstruct, ints_function, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Zero, Jump);
    input clk,Zero;
    input [5:0] ints_function;
    input [5:0] Op_intstruct;
    output reg RegDst,Branch,MemRead,MemtoReg,Jump;
    output reg [3:0] ALUOp;
    output reg MemWrite,ALUSrc,RegWrite;
    always @(*)
    begin
        case (Op_intstruct)
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
            end
        endcase
    end
endmodule
	
	module Register_File_16bit (clk,read_addr_1, read_addr_2, write_addr, write_data, RegWrite,read_data_1, read_data_2);
		input clk,RegWrite;
		input [4:0] read_addr_1, read_addr_2, write_addr;
		input [15:0] write_data;
		output [15:0] read_data_1, read_data_2;
		reg [15:0] Regfile [31:0];
		integer i;

		// Initialize registers
		initial begin
			for (i = 0; i < 32; i = i + 1) begin
				Regfile[i] = 16'b0;
			end
		 Regfile[19]=1; // $s3 = 1
        	Regfile[17]=3; // $s1 = 3
        	Regfile[20]=2; // $s4 = 2
            Regfile[21]=5; // $s5 = 5
		end


		// Read Data Logic
		assign read_data_1 = Regfile[read_addr_1];
		assign read_data_2 = Regfile[read_addr_2];

		// Write Data Logic
		always @(posedge clk) begin
			if (RegWrite) begin
					Regfile[write_addr] <= write_data;
					//$display("write_addr=%h write_data=%h",write_addr,write_data);
			end
		end
	endmodule



	module ALU_16bit(ALU_Sel, A, B, ALU_Out, zero);
		input [3:0] ALU_Sel; // ALU selection
		input [15:0] A; // 16-bit input 1 
		input [15:0] B; // 16-bit input 2 
		output reg [15:0] ALU_Out; // ALU 16-bit output
		output reg zero;
		 parameter	ALU_OP_ADD	    = 4'b0000, // Addition
					ALU_OP_SUB	    = 4'b0001, // Subtraction
					ALU_OP_MUL      = 4'b0010, // Multiplication
					ALU_OP_DIV      = 4'b0011, // Division
					ALU_OP_AND	    = 4'b0100, // Logical and 
					ALU_OP_OR		= 4'b0101, // Logical or
					ALU_OP_XOR	    = 4'b0110, // Logical xor 
					ALU_OP_NOR		= 4'b0111, // Logical nor
					ALU_OP_NAND		= 4'b1000, // Logical nand 
					ALU_OP_XNOR     = 4'b1001, // Logical xnor
					ALU_OP_SHL      = 4'b1010, // Logical shift left
					ALU_OP_SHR      = 4'b1011, // Logical shift right
					ALU_OP_ROL      = 4'b1100, // Rotate left
					ALU_OP_ROR      = 4'b1101, // Rotate right
					ALU_OP_BEQ	    = 4'b1110, // Equal comparison
					ALU_OP_BNE      = 4'b1111; // Not Equal comparison 
		always @(*)
		begin
			case(ALU_Sel)
				ALU_OP_ADD 	    : ALU_Out = A + B;
				ALU_OP_SUB 	    : ALU_Out = A - B;
				ALU_OP_MUL      : ALU_Out = A * B;
				ALU_OP_DIV      : ALU_Out = A / B;
				ALU_OP_AND 	    : ALU_Out = A & B;
				ALU_OP_OR	    : ALU_Out = A | B;
				ALU_OP_XOR	    : ALU_Out = A ^ B;
				ALU_OP_NOR		: ALU_Out = ~(A | B);
				ALU_OP_NAND		: ALU_Out = ~(A & B);
				ALU_OP_XNOR     : ALU_Out = ~(A ^ B);
				ALU_OP_SHL      : ALU_Out = A<<1;
				ALU_OP_SHR      : ALU_Out = A>>1;
				ALU_OP_ROL      : ALU_Out = {A[6:0],A[7]};
				ALU_OP_ROR      : ALU_Out = {A[0],A[7:1]};
				ALU_OP_BEQ	    : begin
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



	// Sign Extension
	module Sign_Extension (sign_in, sign_out);
		input [15:0] sign_in;
		output [31:0] sign_out;
		assign sign_out[15:0]=sign_in[15:0];
		assign sign_out[31:16]=sign_in[15]?16'b1111_1111_1111_1111 : 16'b0;
	endmodule


module Adder32Bit(input1, input2, out);
    input [31:0] input1, input2;
    output [31:0] out;
    reg [31:0]out;
    always@( input1 or input2)
        begin
            out <= input1 + input2;
        end
endmodule

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



module Mux_32_bit (in0, in1, mux_out, select);
	parameter N=32;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input select;
	assign mux_out = select ? in1 : in0;
endmodule



module Mux_16_bit (in0, in1, mux_out, select);
	parameter N=16;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input select;
	assign mux_out = select ? in1 : in0;
endmodule

module Mux_5_bit (in0, in1, mux_out, select);
	parameter N=5;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input select;
	assign mux_out = select ? in1 : in0;
endmodule


module Data_Memory_16bit (clk,addr,write_data,read_data,MemRead,MemWrite);
		input clk;
		input [15:0] addr;
		input [15:0] write_data;
		output reg [15:0] read_data;
		input MemRead;
		input MemWrite;
		integer i;
		reg [15:0] DMemory [0:255];  

		// Initialize memory for simulation
		initial begin
			
			for (i = 0; i < 256; i = i + 1) begin
				DMemory[i] = 16'h0000;
			end
		end

		// Synchronous write
		always @(posedge clk) begin
			if (MemWrite) begin
				DMemory[addr] <= write_data;
				$display("Memory Write: Address=%h Data=%h", addr, write_data);
			end
		end

		// Asynchronous read
		always @(*) begin
			if (MemRead)
				read_data = DMemory[addr];
			else
				read_data = 16'h0000;
		end
	endmodule

module Instruction_Memory (read_address, instruction, reset);
	input reset;
	input [31:0] read_address;
	output [31:0] instruction;
	reg [31:0] Imemory [256:0];
	integer k;
	// I-MEM in this case is addressed by word, not by byte
	assign instruction = Imemory[read_address];
	always @(posedge reset)
	begin
	for (k=0; k<32; k=k+1) 
		begin  
		  // here Out changes k=0 to k=16
		  Imemory[k] = 32'b0;
		end
		/*Test BEQ-type*/
		Imemory[0] = 32'b000100_10010_10011_0000000000000011; // beq $s2, $s3, label3 -> offset = 3
		Imemory[1] = 32'b000100_10001_10101_0000000000000100; // beq $s1, $s5, label4 -> offset = 4
		Imemory[2] = 32'b000100_10000_10100_0000000000000110; // beq $s0, $s4, label5 -> offset = 6
		Imemory[3] = 32'b000100_10010_10000_0000000000000111; // beq $s2, $s0, label6 -> offset = 7


	end
endmodule



