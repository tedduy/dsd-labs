module tb_T_flipflop;
  reg clk, rst, t;
  wire q, q_bar;
  
  T_flipflop dff(clk, rst, t, q, q_bar);
  
  always #2 clk = ~clk;
  initial begin
    clk = 0; rst = 1;
    $display("Reset=%b --> q=%b, q_bar=%b", rst, q, q_bar);
    #3 rst = 0;
    $display("Reset=%b --> q=%b, q_bar=%b", rst, q, q_bar);
    
    drive(0); // Same as previous output
    drive(1); // Toggles previous output
    drive(1); // Toggles previous output
    drive(1); // Toggles previous output
    drive(0); // Same as previous output
    #5;
    $finish;
  end
  
  task drive(input ip);
	begin
    @(posedge clk);
    t = ip;
    #1 $display("t=%b --> q=%b, q_bar=%b",t, q, q_bar);
    end
  endtask
  
endmodule