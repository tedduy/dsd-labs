module tb_JK_flipflop;
  reg clk, rst, j, k;
  wire q, q_bar;
  
  JK_flipflop dff(j, k, clk, rst, q, q_bar);
  
  always #2 clk = ~clk;
  initial begin
    clk = 0; rst = 1;
    $display("Reset=%b --> q=%b, q_bar=%b", rst, q, q_bar);
    #3 rst = 0;
    $display("Reset=%b --> q=%b, q_bar=%b", rst, q, q_bar);
    
    drive(2'b00);
    drive(2'b01);
    drive(2'b10);
    drive(2'b11); // Toggles previous output
    drive(2'b11); // Toggles previous output
    #5;
    $finish;
  end
  
  task drive(input [1:0] ip);
   begin
    @(posedge clk);
    {j,k} = ip;
    #1 $display("j=%b, k=%b --> q=%b, q_bar=%b",j, k, q, q_bar);
   end
  endtask
  
endmodule