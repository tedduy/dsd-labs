// Testbench
module tb_Program_Counter;
    reg clk, reset;
    reg [31:0] PC_in;
    wire [31:0] PC_out;
    
    Program_Counter  uut(.clk(clk),.reset(reset),.PC_in(PC_in),.PC_out(PC_out));
    
        always #5 clk = ~clk; 
    
        initial begin
        clk = 0;
        reset = 1;
        PC_in = 32'd0;
        
	$display("\n------Test Program Counter 32 bit------");

        $monitor("Time=%0t|reset=%b | clk=%b | PC_in=%h | PC_out=%h |", $time,reset, clk, PC_in, PC_out);
        
        #10 reset = 0;
        
        repeat(10) begin
            #10 PC_in = $random;
        end
        
        #10 reset = 1;
        #10 reset = 0;
        
        $finish;
    end
endmodule

// Program Counter 
module Program_Counter(clk, reset, PC_in, PC_out);
    input clk, reset;
    input [31:0] PC_in;
    output reg [31:0] PC_out;
    
    always @(posedge clk) begin
        if(reset) 
            PC_out <= 32'b0;
        else
            PC_out <= PC_in;
    end
endmodule