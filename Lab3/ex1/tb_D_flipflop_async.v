module tb_D_flipflop_async;

    reg clk;
    reg rst;
    reg d;
    wire q;

    D_flipflop_async uut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 0;
        d = 0;

        #10 rst = 1;
        #10 rst = 0;

        #10 d = 1;
        #10 d = 0;
        #10 d = 1;
        #10 d = 0;

        #10 rst = 1;
        #10 rst = 0;
        #10 d = 1;

        #20 $finish;
    end

    initial begin
        $monitor("Time = %t | clk = %b | rst = %b | d = %b | q = %b", $time, clk, rst, d, q);
    end

endmodule
