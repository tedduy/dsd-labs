module tb_beq_Datapath;

    // Inputs
    reg clk;
    reg [4:0] rs, rt;
    reg [7:0] offset;
    reg [15:0] PC_plus_4;
    reg [3:0] ALU_Sel;

    // Outputs
    wire [15:0] beq_add;
    wire zero;

    // Instantiate the Unit Under Test (UUT)
    beq_Datapath uut (
        .clk(clk),
        .rs(rs),
        .rt(rt),
        .offset(offset),
        .PC_plus_4(PC_plus_4),
        .ALU_Sel(ALU_Sel),
        .beq_add(beq_add),
        .zero(zero)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rs = 5'h11;    // Register 17
        rt = 5'h10;    // Register 16
        offset = 8'h04; // Offset
        PC_plus_4 = 16'h0003; // Initial PC + 4 value
        ALU_Sel = 4'b1110;    // BEQ operation

        // Display header
        $display("Time\tPC_plus_4\tBEQ_Address\tZero");

        // Monitor signals
        $monitor("%0d\t%h\t%h\t%b", $time, PC_plus_4, beq_add, zero);

        // Test Case 1: rs != rt
        #10;
        rs = 5'h18; // Register 24
        rt = 5'h19; // Register 25

        // Test Case 2: rs == rt
        #10;
        rs = 5'h11; // Register 17
        rt = 5'h11; // Register 17

        // Test Case 3: Change offset
        #10;
        offset = 8'hFF; // Negative offset

        #10;
        $finish;
    end

endmodule
