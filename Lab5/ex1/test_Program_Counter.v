module test_Program_Counter;
    reg t_clk, t_reset;
    reg [7:0] t_PC_in;
    wire [7:0] t_PC_out;
    
    // Instantiate Device Under Test (DUT)
    Program_Counter DUT (
        .clk(t_clk),
        .reset(t_reset),
        .PC_in(t_PC_in),
        .PC_out(t_PC_out)
    );
    
    // Clock Generation
    always #5 t_clk = ~t_clk; 
    
    // Test Sequence
    initial begin
        // Initialize signals
        t_clk = 0;
        t_reset = 1;
        t_PC_in = 8'b00000000;
        
        // Monitor changes
        $monitor($time, " reset=%b | clk=%b | PC_in=%b | PC_out=%b |", t_reset, t_clk, t_PC_in, t_PC_out);
        
        // Reset sequence
        #10 t_reset = 0;
        
        // Random input tests
        repeat(20) begin
            #10 t_PC_in = $random;
        end
        
        // Additional reset test
        #10 t_reset = 1;
        #10 t_reset = 0;
        
        // Finish simulation
        #50 $finish;
    end
endmodule