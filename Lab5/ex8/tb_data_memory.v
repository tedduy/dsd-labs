`timescale 1ns / 1ps

module tb_data_memory;

    // Inputs
    reg [7:0] addr;
    reg [7:0] write_data;
    reg clk;
    reg reset;
    reg MemRead;
    reg MemWrite;

    // Outputs
    wire [7:0] read_data;

    // Instantiate the Data_Memory module
    Data_Memory uut (
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data),
        .clk(clk),
        .reset(reset),
        .MemRead(MemRead),
        .MemWrite(MemWrite)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        MemRead = 0;
        MemWrite = 0;
        addr = 0;
        write_data = 0;

        // Apply reset
        $display("Applying reset...");
        reset = 1;
        #10;
        reset = 0;

        // Write data to memory
        $display("Writing data to memory...");
        addr = 8'h01;
        write_data = 8'hA5;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        addr = 8'h02;
        write_data = 8'h3C;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        // Read data from memory
        $display("Reading data from memory...");
        addr = 8'h01;
        MemRead = 1;
        #10;
        $display("Read data at address 0x01: %h", read_data);

        addr = 8'h02;
        #10;
        $display("Read data at address 0x02: %h", read_data);

        // Read from uninitialized address
        $display("Reading from uninitialized address...");
        addr = 8'h03;
        #10;
        $display("Read data at address 0x03: %h", read_data);

        // Apply reset and verify memory reset
        $display("Resetting memory...");
        reset = 1;
        #10;
        reset = 0;

        addr = 8'h01;
        #10;
        $display("Read data at address 0x01 after reset: %h", read_data);

        addr = 8'h02;
        #10;
        $display("Read data at address 0x02 after reset: %h", read_data);

        $finish;
    end
endmodule
