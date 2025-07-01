module lab6_ex1(SW,LEDG,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,KEY);
	input [17:0]SW;
	input [3:0] KEY;
	output [17:0]LEDR;
	output [7:0]LEDG;
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	wire [31:0] W_LED_SEG;
	
	assign LEDR=SW;
	assign LEDG[3:0]=KEY;
	hex_ssd (W_LED_SEG[3:0], HEX0);
	hex_ssd (W_LED_SEG[7:4], HEX1);
	hex_ssd (W_LED_SEG[11:8],HEX2);
	hex_ssd (W_LED_SEG[15:12],HEX3);
	hex_ssd (W_LED_SEG[19:16],HEX4);
	hex_ssd (W_LED_SEG[23:20],HEX5);
	hex_ssd (W_LED_SEG[27:24],HEX6);
	hex_ssd (W_LED_SEG[31:28],HEX7);

	Datapath_R_Type(.clk(KEY[0]),.rst(KEY[1]),.RegWrite(0),.A(SW[4:0]),.B(SW[9:5]),.C(SW[14:10]),.ALU_Sel(SW[17:15]),.Zero(LEDG[7]),.ALU_Out(W_LED_SEG));
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

module Datapath_R_Type(clk,rst,RegWrite, A, B, C,ALU_Sel,Zero,ALU_Out);
	input clk,rst,RegWrite;
	input [4:0] A, B, C;
	input [2:0] ALU_Sel;
	output Zero;
	output [31:0]ALU_Out;
	wire  [31:0] W_RD1,W_RD2;
	Register_File_16bit C1(.clk(clk), .rst(rst),.RegWrite(RegWrite),
	.write_data(ALU_Out),.read_addr_1(A), .read_addr_2(B), .write_addr(C), 
	.read_data_1(W_RD1), .read_data_2(W_RD2));

	ALU_16bit C2(.ALU_Sel(ALU_Sel),.A(W_RD1),.B(W_RD2),.ALU_Out(ALU_Out),.zero(Zero));

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
			$display("write_addr=%h write_data=%h",write_addr,write_data);
		end
	end
endmodule


module ALU_16bit(ALU_Sel, A, B, ALU_Out, zero);
	input [2:0] ALU_Sel; // ALU selection
	input [31:0] A; // 32-bit input 1 
	input [31:0] B; // 32-bit input 2 
	output reg [31:0] ALU_Out; // ALU 32-bit output
	output reg zero;
	parameter	ALU_OP_ADD	    = 3'b000,
			    ALU_OP_SUB	    = 3'b001, 
			    ALU_OP_MUL      = 3'b010, 
			    ALU_OP_DIV      = 3'b011, 
			    ALU_OP_AND	    = 3'b100,
			    ALU_OP_OR		= 3'b101, 
			    ALU_OP_BEQ	    = 3'b110, 
			    ALU_OP_BNE		= 3'b111;

    always @(*)
	begin
		case(ALU_Sel)
			ALU_OP_ADD 	    : ALU_Out = A + B;
			ALU_OP_SUB 	    : ALU_Out = A - B;
			ALU_OP_MUL      : ALU_Out = A * B;
			ALU_OP_DIV      : ALU_Out = A / B;
			ALU_OP_AND 	    : ALU_Out = A & B;
			ALU_OP_OR	    : ALU_Out = A | B;
			ALU_OP_BEQ	    : begin
					            zero = (A==B)?1'b1:1'b0;
					            ALU_Out = (A==B)?31'd1:31'd0;
					          end
			ALU_OP_BNE      : begin
					            zero = (A!=B)?1'b1:1'b0; 
					            // zero here is different from the above zero
					            // zero here is equal to 1, when A is different from B
					            // zero here is equal to 0, when A is the same as B
					            ALU_Out = (A!=B)?31'd1:31'd0;
					          end
		endcase
    end
endmodule
