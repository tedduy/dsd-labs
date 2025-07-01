module tb_BEQ_Proc;
    reg reset, clk;
    wire [31:0] W_PC_out, instruction, W_m2;
    wire [15:0] W_RD1, W_RD2, W_m1, W_ALUout;
    

    beq_Processor dut(reset, clk, W_PC_out, instruction, W_RD1, W_RD2, W_m1, W_m2, W_ALUout);

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $monitor($time,
            " reset=%b | clk=%b | W_PC_out=%4d | Opcode=%6b | rs=%d | rt=%d | zero=%d | Imm=%h | W_ALUout=%h | W_RD1=%h | W_RD2=%h",
            reset, clk, W_PC_out, instruction[31:26], instruction[25:21], instruction[20:16], dut.C9.zero,
            instruction[15:0], W_ALUout, W_RD1, W_RD2);


        clk = 0;
        reset = 1;
        $display("                    ----------TEST BEQ-PROCESSOR----------");

        #10 reset = 0;

        #30 $finish;
    end
endmodule