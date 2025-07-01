module tb_alu;
// Inputs
reg [7:0] ra, rb_or_imm;
reg [2:0] aluop;

// Outputs
wire [7:0] aluout;
wire zero;

// Instantiate the ALU
integer i;
alu test_unit (
    aluop,         // ALU Operation Select
    ra,            // ALU 8-bit Input A
    rb_or_imm,     // ALU 8-bit Input B
    aluout,        // ALU 8-bit Output
    zero           // Zero Flag Output
);

initial begin
    // Monitor values
    $monitor("Time=%0t | ra=%d | rb_or_imm=%h | aluop=%d | aluout=%d | zero=%b", 
             $time, ra, rb_or_imm, aluop, aluout, zero);

    // Initial values
    ra = 8'd3;
    rb_or_imm = 8'd2;
    aluop = 3'b0;

    // Loop to test ALU operations
    for (i = 0; i <= 7; i = i + 1) begin
        aluop = aluop + 3'b1;  // Increment ALU operation
        #10;                   // Delay for each operation
    end

    // Change inputs for another test
    ra = 8'd5;
    rb_or_imm = 8'd3;
    aluop = 3'b0; // Test an operation with new inputs
    #10;
end
endmodule
