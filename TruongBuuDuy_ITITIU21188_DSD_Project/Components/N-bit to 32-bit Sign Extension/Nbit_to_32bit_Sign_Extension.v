// Testbench 
module tb_Sign_Extension_N_bit;

    reg [15:0] sign_in_16; // For N = 16
    reg [25:0] sign_in_26; // For N = 26
    wire [31:0] sign_out_16;
    wire [31:0] sign_out_26;

    // N = 16
    Sign_Extension_N_bit #(16) uut_16 (.sign_in(sign_in_16),.sign_out(sign_out_16));

    // N = 26
    Sign_Extension_N_bit #(26) uut_26 (.sign_in(sign_in_26),.sign_out(sign_out_26));

    initial begin
	$display("\n------Test Sign Extension N bit------");

        $monitor("Time=%0t | N=16: sign_in=%b | sign_out=%b | N=26: sign_in=%b | sign_out=%b",
                 $time, sign_in_16, sign_out_16, sign_in_26, sign_out_26);

        // Test Case 1: Positive input 
        sign_in_16 = 16'b0000_1111_0000_1111;
        sign_in_26 = 26'b0000_0000_1111_0000_1111_0000_11; 
        #10;

        // Test Case 2: Negative input         
	sign_in_16 = 16'b1111_1111_0000_1111; 
        sign_in_26 = 26'b1111_1111_1111_0000_1111_0000_11; 
        #10;

        // Test Case 3: Smallest negative value 
        sign_in_16 = 16'b1000_0000_0000_0000;
        sign_in_26 = 26'b1000_0000_0000_0000_0000_0000_00;
        #10;

        // Test Case 4: Largest positive value         
	sign_in_16 = 16'b0111_1111_1111_1111;
        sign_in_26 = 26'b0111_1111_1111_1111_1111_1111_11;
        #10;

        $finish;
    end

endmodule


// Sign Extension N-bit
module Sign_Extension_N_bit (sign_in, sign_out);
    parameter N = 16;          
    input [N-1:0] sign_in;     
    output [31:0] sign_out;   

    assign sign_out = {{(32-N){sign_in[N-1]}}, sign_in};
endmodule