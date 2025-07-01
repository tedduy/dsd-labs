module test_LW_datapath;
    reg [4:0] rs, rt;
    reg [7:0] offset;
    reg MemWrite, MemRead, clk;
    reg [3:0] ALU_Sel;
    wire [15:0] Mem_Out;

    LW_datapath uut (
        .rs(rs),
        .rt(rt),
        .offset(offset),
        .clk(clk),
        .ALU_Sel(ALU_Sel),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Mem_Out(Mem_Out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t rs=%h rt=%h offset=%h RD1=%h RD2=%h ALUout=%h Mem_Out=%h MW=%b MR=%b",
            $time, rs, rt, offset, 
            uut.W_RD1, uut.W_RD2, uut.ALUout, 
            Mem_Out, MemWrite, MemRead);
    end

    initial begin
       

        // Initialize signals
        rs = 5'h10;    // R16 contains 0x33
        rt = 5'h11;    // Target register
        offset = 8'h4;
        ALU_Sel = 4'b0000;
        MemWrite = 0;
        MemRead = 1;   // LW needs read enabled

        // Test Case 1: Load from first location
        #20;

        // Test Case 2: Load from second location
        offset = 8'h8;
        #20;

        $finish;
    end
endmodule