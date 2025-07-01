module test_SW_datapath;
    reg [4:0] rs, rt;
    reg [7:0] offset;
    reg MemWrite, MemRead, clk;
    reg [3:0] ALU_Sel;
    wire [15:0] Mem_Out;

    
    SW_datapath uut (
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

    // Enhanced monitoring
    initial begin
        $monitor("Time=%0t rs=%h rt=%h offset=%h RD1=%h RD2=%h ALUout=%h Mem_Out=%h MW=%b MR=%b",
            $time, rs, rt, offset, 
            uut.W_RD1, uut.W_RD2, uut.ALUout, 
            Mem_Out, MemWrite, MemRead);
    end

    // Test stimulus
    initial begin
        // Initialize
        rs = 5'h10;    // Register 16 (contains 0x33)
        rt = 5'h11;    // Register 17 (contains 0x66)
        offset = 8'h0;
        ALU_Sel = 4'b0000;
        MemWrite = 0;
        MemRead = 0;
		

        // Wait for stable state
        #10;

     
        #2; // Small delay after clock edge
        rs = 5'h10;
        rt = 5'h11;
        offset = 8'h4;
        MemWrite = 1;
        MemRead = 0;
        #10;


       
        #2; // Small delay after clock edge
        offset = 8'h8;
        MemWrite = 1;
        MemRead = 0;
        #10;


        // End simulation
        #10 $finish;
    end
endmodule