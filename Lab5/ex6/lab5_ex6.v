module lab5_ex6(SW,LEDR,LEDG,HEX7, HEX6, HEX5, HEX4);
	input [17:0] SW;

    output [0:6] HEX7, HEX6, HEX5, HEX4;
	output [17:0] LEDR;
	output [7:0] LEDG;
	wire [7:0]  read_data_1, read_data_2;

	assign LEDR = SW;
	
	hex_ssd (read_data_2[3:0],HEX4);
	hex_ssd (read_data_2[7:4],HEX5);
	hex_ssd (read_data_1[3:0],HEX6);
	hex_ssd (read_data_1[7:4],HEX7);
	
	Register_File(.read_addr_1(SW[2:0]),.read_addr_2(SW[5:3]),.write_addr(SW[8:6]),.read_data_1(read_data_1),.read_data_2(read_data_2),.write_data(SW[16:9]),.RegWrite(1),.clk(SW[17]),.reset(0));
endmodule

module hex_ssd (BIN, SSD);
  input [3:0] BIN;
  output reg [0:6] SSD;

  always begin
    case(BIN)
      0:SSD=7'b0000001;
      1:SSD=7'b1001111;
      2:SSD=7'b0010010;
      3:SSD=7'b0000110;
      4:SSD=7'b1001100;
      5:SSD=7'b0100100;
      6:SSD=7'b0100000;
      7:SSD=7'b0001111;
      8:SSD=7'b0000000;
      9:SSD=7'b0001100;
      10:SSD=7'b0001000;
      11:SSD=7'b1100000;
      12:SSD=7'b0110001;
      13:SSD=7'b1000010;
      14:SSD=7'b0110000;
      15:SSD=7'b0111000;
    endcase
  end
endmodule


module Register_File(
    input [2:0] read_addr_1, read_addr_2, write_addr,
    input [7:0] write_data,
    input RegWrite, clk, reset,
    output [7:0] read_data_1, read_data_2
);

    reg [7:0] Regfile [7:0];
    integer k;

    
    assign   read_data_1 = Regfile[read_addr_1];
    assign read_data_2 = Regfile[read_addr_2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (k = 0; k < 8; k = k + 1) begin
                Regfile[k] = 8'b0;
            end
        end else if (RegWrite) begin
            Regfile[write_addr] = write_data;
        end
    end

endmodule
