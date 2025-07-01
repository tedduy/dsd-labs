module lab6_ex3(SW,LEDG,LEDR,HEX0,HEX1,HEX2,HEX3);
		input [17:0]SW;
		output [17:0]LEDR;
		output [7:0]LEDG;
		output [0:6] HEX3, HEX2, HEX1, HEX0;
		wire [15:0] W_LED_SEG;
		
		assign LEDR=SW;
		hex_ssd (W_LED_SEG[3:0], HEX0);
		hex_ssd (W_LED_SEG[7:4], HEX1);
		hex_ssd (W_LED_SEG[11:8],HEX2);
		hex_ssd (W_LED_SEG[15:12],HEX3);
		

		LW_datapath(.rs(SW[17:13]), .rt(SW[12:8]), .offset(SW[7:1]),.clk(SW[0]),.ALU_Sel(4'b0000),.MemWrite(1'b0),.MemRead(1'b1),.Mem_Out(W_LED_SEG));
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

	module LW_datapath(rs, rt, offset, clk, ALU_Sel, MemWrite, MemRead, Mem_Out);
		input [4:0] rs, rt;
		input [7:0] offset;
		input MemWrite, MemRead, clk;
		input [3:0] ALU_Sel;
		output [15:0] Mem_Out;    
		wire [15:0] W_RD1, W_RD2, W_RD3, ALUout;
		wire zero;  

		Register_File_16bit C1(
			.clk(clk), 
			.RegWrite(1'b1),  
			.write_data(Mem_Out), 
			.read_addr_1(rs), 
			.read_addr_2(rt), 
			.write_addr(rt), 
			.read_data_1(W_RD1), 
			.read_data_2(W_RD2)
		);

		Sign_Extension C3(
			.sign_in(offset), 
			.sign_out(W_RD3)
		);

		ALU_16bit C2(
			.ALU_Sel(ALU_Sel), 
			.A(W_RD1), 
			.B(W_RD3), 
			.ALU_Out(ALUout), 
			.zero(zero)
		);

		Data_Memory_16bit C4(
			.clk(clk),
			.addr(ALUout), 
			.write_data(W_RD2), 
			.read_data(Mem_Out), 
			.MemRead(MemRead), 
			.MemWrite(MemWrite)
		);
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
		  Regfile[16] = 16'h33;  // Register 16 (contains 0x33)
		  Regfile[17] = 16'h66;  // Register 17 (contains 0x66)
		  Regfile[18] = 16'h2;  // Register 16 (contains 0x33)
		  Regfile[19] = 16'h5;  // Register 17 (contains 0x66)
		end


		// Read Data Logic
		assign read_data_1 = Regfile[read_addr_1];
		assign read_data_2 = Regfile[read_addr_2];

		// Write Data Logic
		always @(posedge clk) begin
			if (RegWrite) begin
					Regfile[write_addr] <= write_data;
					$display("write_addr=%h write_data=%h",write_addr,write_data);
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
		input [7:0] sign_in;
		output [15:0] sign_out;
		assign sign_out[7:0]=sign_in[7:0];
		assign sign_out[15:8]=sign_in[7]?8'b1111_1111:8'b0;
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
			DMemory[16'h0037] = 16'hAAAA;
			DMemory[16'h003B] = 16'hBBBB;
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