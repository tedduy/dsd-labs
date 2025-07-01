// Testbench
module tb_Data_Memory_16bit;

    reg clk,MemRead,MemWrite;
    reg [15:0] addr,write_data;
    
    wire [15:0] read_data;

    Data_Memory_16bit uut(.clk(clk),.addr(addr),.write_data(write_data),.read_data(read_data),.MemRead(MemRead),.MemWrite(MemWrite));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        addr = 16'h0000;
        write_data = 16'h0000;
        MemRead = 0;
        MemWrite = 0;
        
        $display("\n------Test Data Memory 16 bit------");

        $monitor("Time=%0t | Addr=%h | WriteData=%h | ReadData=%h | MemRead=%b | MemWrite=%b",
                 $time, addr, write_data, read_data, MemRead, MemWrite);

        // Write data to memory
        #10;
        addr = 16'h0001;
        write_data = 16'h1234;
        MemWrite = 1;
        MemRead = 0;
        #10;
        MemWrite = 0; // Stop write

        // Read data from memory
        #10;
        addr = 16'h0001;
        MemRead = 1;
        #10;
        MemRead = 0; // Stop read

        // Write 
        #10;
        addr = 16'h0002;
        write_data = 16'h5678;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        // Read         
        #10;
        addr = 16'h0002;
        MemRead = 1;
        #10;
        MemRead = 0;

        // Test reading an uninitialized memory location
        #10;
        addr = 16'h00FF;
        MemRead = 1;
        #10;
        MemRead = 0;

 
        #20;
        $finish;
    end

endmodule

//Data Memory 16 bit
module Data_Memory_16bit (clk,addr,write_data,read_data,MemRead,MemWrite);
	input clk;
	input [15:0] addr;
	input [15:0] write_data;
	output reg [15:0] read_data;
	input MemRead;
	input MemWrite;
	integer i;
	reg [15:0] DMemory [0:255];  

	initial begin
		for (i = 0; i < 256; i = i + 1) begin
			DMemory[i] = 16'h0000;
		end
	end

	always @(posedge clk) begin
		if (MemWrite) begin
			DMemory[addr] <= write_data;
			$display("Memory Write: Address=%h Data=%h", addr, write_data);
		end
	end

	always @(*) begin
		if (MemRead)
			read_data = DMemory[addr];
		else
			read_data = 16'h0000;
	end
endmodule