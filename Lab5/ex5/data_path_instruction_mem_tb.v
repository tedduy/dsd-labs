module data_path_instruction_mem_tb;

    // Testbench signals
    reg clk, reset;
    wire [7:0] read_address;
    wire [31:0] instruction;
    
    // Instantiate the Unit Under Test (UUT)
    data_path_instruction_mem uut (
        .reset(reset),
        .clk(clk),
        .read_address(read_address),
        .instruction(instruction)
    );
    
    // Clock generation
    always begin
        #5 clk = ~clk;  // Generate clock with a period of 10 time units
    end
    
    // Stimulus block
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        
        // Test 1: Apply reset
        #5 reset = 1;   // Apply reset at time 5
        #10 reset = 0;  // Deassert reset at time 15
        
        // Test 2: Observe instruction read after reset deassertion
        #20;  // Wait for a few clock cycles to allow the system to process
        
        // Test 3: Apply reset again
        #30 reset = 1;   // Apply reset at time 30
        #10 reset = 0;   // Deassert reset at time 40
        
        // Test 4: Observe the instruction read again after reset deassertion
        #40; // Wait for some cycles
        
        // Test 5: Final state check
        #50; // Wait for final states

        // Finish simulation
        $finish;
    end

    // Monitor signals for observation
    initial begin
        $monitor("At time %t, reset = %b, read_address = %b, instruction = %b", 
                 $time, reset, read_address, instruction);
    end

endmodule
