module lab5_ex7(SW,LEDR,LEDG,HEX7, HEX6);
	input [17:0] SW;
    output [0:6] HEX7, HEX6;
	output [17:0] LEDR;
	output [7:0] LEDG;
	wire [7:0]  W_LED_SEG;

	assign LEDR = SW;
	hex_ssd (W_LED_SEG[3:0],HEX6);
	hex_ssd (W_LED_SEG[7:4],HEX7);
	
	alu(.aluop(SW[17:15]),.ra(SW[12:7]),.rb_or_imm(SW[5:0]),.aluout(W_LED_SEG),.zero(LEDG[7]));
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



module alu(aluop,ra,rb_or_imm,aluout,zero);
	input [2:0] aluop;
	input [7:0] ra;
	input [7:0] rb_or_imm;
	output reg [7:0] aluout;
	output reg zero;

parameter	ALU_OP_ADD	= 3'b000,
			ALU_OP_SUB	= 3'b001,
			ALU_OP_AND	= 3'b010,
			ALU_OP_OR		= 3'b011,
			ALU_OP_NOT_A	= 3'b100,
			ALU_OP_LW		= 3'b101,
			ALU_OP_SW		= 3'b110,
			ALU_OP_BEQ	= 3'b111;
always @(*) 
begin
		case(aluop)
			ALU_OP_ADD 	: aluout = ra + rb_or_imm;
			ALU_OP_SUB 	: aluout = ra - rb_or_imm;
			ALU_OP_AND 	: aluout = ra & rb_or_imm;
			ALU_OP_OR		: aluout = ra | rb_or_imm;
			ALU_OP_NOT_A	: aluout = ~ ra;
			ALU_OP_LW		: aluout = ra + rb_or_imm;
			ALU_OP_SW		: aluout = ra + rb_or_imm;
			ALU_OP_BEQ	: begin
						    zero = (ra==rb_or_imm)?1'b1:1'b0; 
						    aluout = ra - rb_or_imm;
						  end
		endcase
end

endmodule
