`timescale 1ns / 1ps

module tb_Register_File;
    reg [2:0] read_addr_1, read_addr_2, write_addr;
    reg [7:0] write_data;
    reg clk, reset, RegWrite;
    wire [7:0] read_data_1, read_data_2;
    
    Register_File uut (
        .read_addr_1(read_addr_1),
        .read_addr_2(read_addr_2),
        .write_addr(write_addr),
        .write_data(write_data),
        .RegWrite(RegWrite),
        .clk(clk),
        .reset(reset),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );
    
    always #5 clk = ~clk; // Toggle clock every 5ns
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;   // Reset is initially 1
        RegWrite = 0;
        write_addr = 3'b000;
        write_data = 8'b0;
        read_addr_1 = 3'b000;
        read_addr_2 = 3'b000;

        // Print simulation results
        $monitor("Time: %0d | Clk: %b | Reset: %b | RegWrite: %b | Read Addr 1: %03b | Read Data 1: %02x | Read Addr 2: %03b | Read Data 2: %02x | Write Addr: %03b | Write Data: %02x",
                 $time, clk, reset, RegWrite, read_addr_1, read_data_1, read_addr_2, read_data_2, write_addr, write_data);
        
        // Initial Reset
        #10 reset = 0;  // Release reset after 10ns

        // Write sequence
        #10 RegWrite = 1; write_addr = 3'b001; write_data = 8'h07; // Write 7 (binary 0111) to register 001
        #10 write_addr = 3'b010; write_data = 8'h08; // Write 8 (binary 1000) to register 010
        #10 write_addr = 3'b011; write_data = 8'h09; // Write 9 (binary 1001) to register 011
        #10 write_addr = 3'b100; write_data = 8'h0A; // Write A (binary 1010) to register 100
        #10 write_addr = 3'b101; write_data = 8'h0B; // Write B (binary 1011) to register 101

        // Disable writing and start reading
        #10 RegWrite = 0;

        // Read from registers after writes
        #10 read_addr_1 = 3'b001; read_addr_2 = 3'b101; // Read from registers 001 and 101
        #10 read_addr_1 = 3'b011; read_addr_2 = 3'b100; // Read from registers 011 and 100
        #10 read_addr_1 = 3'b101; read_addr_2 = 3'b101; // Read from register 101 twice
        #10 read_addr_1 = 3'b100; read_addr_2 = 3'b100; // Read from register 100 twice

        // End the simulation after a final check
        #10 $finish;
    end
endmodule
