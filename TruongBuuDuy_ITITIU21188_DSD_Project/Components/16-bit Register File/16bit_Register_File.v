// Testbench 
module tb_Register_File_16bit;
    reg clk,RegWrite;
    reg [4:0] read_addr_1, read_addr_2, write_addr;
    reg [15:0] write_data;
    wire [15:0] read_data_1, read_data_2;

   
    Register_File_16bit uut (.clk(clk),.read_addr_1(read_addr_1),.read_addr_2(read_addr_2),.write_addr(write_addr),.write_data(write_data),.RegWrite(RegWrite),.read_data_1(read_data_1),.read_data_2(read_data_2)
    );

       always #5 clk = ~clk;

    initial begin
        clk = 0;
        RegWrite = 0;
        read_addr_1 = 5'b0;
        read_addr_2 = 5'b0;
        write_addr = 5'b0;
        write_data = 16'b0;

	$display("\n------Test Register File 16 bit------");

        $monitor("Time=%0t | ReadAddr1=%h ReadData1=%h | ReadAddr2=%h ReadData2=%h | WriteAddr=%h WriteData=%h RegWrite=%b",
                 $time, read_addr_1, read_data_1, read_addr_2, read_data_2, write_addr, write_data, RegWrite);

        // Read default values from registers
        #10;
        read_addr_1 = 5'd19; // Reading $s3
        read_addr_2 = 5'd17; // Reading $s1

        #10;
        read_addr_1 = 5'd20; // Reading $s4
        read_addr_2 = 5'd21; // Reading $s5

        // Write to a register
        #10;
        write_addr = 5'd10; // Write to $t2
        write_data = 16'h1234;
        RegWrite = 1;
        #10;
        RegWrite = 0;

        // Read back the written value
        #10;
        read_addr_1 = 5'd10; // Reading $t2
        read_addr_2 = 5'd20; // Reading $s4

        // Write to another register
        #10;
        write_addr = 5'd5; // Write to $a1
        write_data = 16'h5678;
        RegWrite = 1;
        #10;
        RegWrite = 0;

        // Read back the new values
        #10;
        read_addr_1 = 5'd5; // Reading $a1
        read_addr_2 = 5'd10; // Reading $t2

        #20;
        $finish;
    end

endmodule


// Register File 16bit
module Register_File_16bit (clk,read_addr_1, read_addr_2, write_addr, write_data, RegWrite,read_data_1, read_data_2);
	input clk,RegWrite;
	input [4:0] read_addr_1, read_addr_2, write_addr;
	input [15:0] write_data;
	output [15:0] read_data_1, read_data_2;
	reg [15:0] Regfile [31:0];
	integer i;

	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			Regfile[i] = 16'b0;
		end
	Regfile[19]=1; // $s3 = 1
       	Regfile[17]=3; // $s1 = 3
       	Regfile[20]=2; // $s4 = 2
        Regfile[21]=5; // $s5 = 5
	end

	assign read_data_1 = Regfile[read_addr_1];
	assign read_data_2 = Regfile[read_addr_2];

	always @(posedge clk) begin
		if (RegWrite) begin
			Regfile[write_addr] <= write_data;
			$display("write_addr=%h write_data=%h",write_addr,write_data);
		end
	end
endmodule