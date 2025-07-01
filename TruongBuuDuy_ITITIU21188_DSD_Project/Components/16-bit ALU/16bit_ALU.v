// Testbench
module tb_ALU_16bit;

    reg [3:0] ALU_Sel;
    reg [15:0] A,B;
    wire [15:0] ALU_Out;
    wire zero;

    
    ALU_16bit uut (.ALU_Sel(ALU_Sel),.A(A),.B(B),.ALU_Out(ALU_Out),.zero(zero));

    initial begin
        $display("\n------Test ALU 16 bit------");
        $monitor("Time: %0t | ALU_Sel: %b | A: %h | B: %h | ALU_Out: %h | Zero: %b", 
                 $time, ALU_Sel, A, B, ALU_Out, zero);

        
        A = 16'h0005;  
        B = 16'h0003;  


        ALU_Sel = 4'b0000; #10; // Addition
        ALU_Sel = 4'b0001; #10; // Subtraction
        ALU_Sel = 4'b0010; #10; // Multiplication
        ALU_Sel = 4'b0011; #10; // Division
        ALU_Sel = 4'b0100; #10; // Logical AND
        ALU_Sel = 4'b0101; #10; // Logical OR
        ALU_Sel = 4'b0110; #10; // Logical XOR
        ALU_Sel = 4'b0111; #10; // Logical NOR
        ALU_Sel = 4'b1000; #10; // Logical NAND
        ALU_Sel = 4'b1001; #10; // Logical XNOR
        ALU_Sel = 4'b1010; #10; // Logical Shift Left
        ALU_Sel = 4'b1011; #10; // Logical Shift Right
        ALU_Sel = 4'b1100; #10; // Rotate Left
        ALU_Sel = 4'b1101; #10; // Rotate Right
        ALU_Sel = 4'b1110; #10; // Equal Comparison
        ALU_Sel = 4'b1111; #10; // Not Equal Comparison

        $finish;
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