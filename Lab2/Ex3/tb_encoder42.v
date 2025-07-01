module  tb_encoder42;
    reg [3:0]a;
    wire [1:0]y;
    
    encoder42_BH dut(a,y);
    
    initial begin
    a=4'b0000;
    
    $monitor("Time: %0t,a = %b,y = %b",$time,a,y);
    #10 a=4'b0001;
    #10 a=4'b0010;
    #10 a=4'b0100;
    #10 a=4'b1000;
    
    $finish;
    end
endmodule