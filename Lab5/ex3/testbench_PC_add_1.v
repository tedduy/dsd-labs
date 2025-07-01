module testbench_PC_add_1;
    reg clk, reset;
    wire [7:0] instruction_address;

    PC_ADD_1 DUT(
        .clk(clk), 
        .reset(reset), 
        .instruction_address(instruction_address)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #5 reset = 0;
        $monitor($time, " reset=%b, clk=%b, instruction_address=%b", reset, clk, instruction_address);
        #50 reset=1;
        #5 reset=0;
        
        #100 $finish;
    end
endmodule
