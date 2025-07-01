module lab5_ex8(SW,LEDR,LEDG);
	input [17:0]SW;
	output [17:0]LEDR;
	output [7:0]LEDG;
	
	assign LEDR=SW;
	
	Data_Memory(.addr(SW[7:0]),.write_data(SW[15:8]),.read_data(LEDG),.clk(SW[16]),.reset(SW[17]),.MemRead(1),.MemWrite(1));
endmodule


module Data_Memory(addr, write_data, read_data, clk, reset, MemRead, MemWrite);
	input [7:0] addr;
	input [7:0] write_data;
	output [7:0] read_data;
	input clk, reset, MemRead, MemWrite;
	reg [7:0] DMemory [7:0];
	integer k;
	assign read_data = (MemRead) ? DMemory[addr] : 8'bx;

	always @(posedge clk or posedge reset)
	begin
		if (reset == 1'b1) 
			begin
				for (k=0; k<8; k=k+1) 
   begin
				        DMemory[k] = 8'b0;
				   end
			end
		else
			if (MemWrite) DMemory[addr] = write_data;
	end
endmodule
