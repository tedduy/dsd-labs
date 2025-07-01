module tb_synchronous_counter;
  parameter N = 4;
  
  reg clk, rst, up_down;
  wire [N-1:0] cnt;
  
  synchronous_counter DUT (
    .clk(clk),
    .rst(rst),
    .up_down(up_down),
    .cnt(cnt)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0; rst = 1; up_down = 1;
    $display("rst=%b, up_down=%b, cnt=%b", rst, up_down, cnt);
    
    #10 rst = 0;
    $display("rst=%b, up_down=%b, cnt=%b", rst, up_down, cnt);
    
    // Test counting up
    drive(1);  // cnt = 1
    drive(1);  // cnt = 2
    drive(1);  // cnt = 3
    drive(1);  // cnt = 4
    
    // Test counting down
    up_down = 0;
    drive(0);  // cnt = 3
    drive(0);  // cnt = 2
    drive(0);  // cnt = 1
    drive(0);  // cnt = 0
    
    // Test reset
    rst = 1;
    #10 rst = 0;
    $display("rst=%b, up_down=%b, cnt=%b", rst, up_down, cnt);
    
    #10;
    $finish;
  end

  task drive(input up_dn);
    begin
      up_down = up_dn;
      #10;
      $display("rst=%b, up_down=%b, cnt=%b", rst, up_down, cnt);
    end
  endtask
endmodule