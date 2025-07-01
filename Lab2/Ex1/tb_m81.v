
module tb_m81;

    reg [7:0] d;
    reg [2:0] s;
    wire out;

    m81_BEH uut (
        .d(d),
        .s(s),
        .out(out)
    );

    initial begin
        d = 8'b00000000;
        s = 3'b000;

        d = 8'b10101010;
        #10 s = 3'b000;
        #10 s = 3'b001;
        #10 s = 3'b010;
        #10 s = 3'b011;
        #10 s = 3'b100;
        #10 s = 3'b101;
        #10 s = 3'b110;
        #10 s = 3'b111;

        d = 8'b11001100;
        #10 s = 3'b000;
        #10 s = 3'b001;
        #10 s = 3'b010;
        #10 s = 3'b011;
        #10 s = 3'b100;
        #10 s = 3'b101;
        #10 s = 3'b110;
        #10 s = 3'b111;

        #10 $finish;
    end

    initial begin
        $monitor("Time = %t | d = %b | s = %b | out = %b", $time, d, s, out);
    end

endmodule
