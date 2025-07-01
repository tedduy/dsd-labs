module tb_asynchronous_counter;
  parameter N = 4;  // Declare 'N' parameter her
  reg clk, rst, up_down;
  wire [N-1:0] cnt;  // Wire 'cnt' width is now based on 'N'
  asynchronous_counter #(.N(N)) DUT (
    .clk(clk),
    .rst(rst),
    .up_down(up_down),
    .cnt(cnt)
  );

  always #5 clk = ~clk; // Clock with a period of 10 time units

  initial begin
    // Initial values
    clk = 0; rst = 1; up_down = 1;
    $display("rst=%b, up_down=%b, cnt=%b", rst, up_down, cnt);
    
    // Apply reset
    #10 rst = 0;
    $display("rst=%b, up_down=%b, cnt=%b", rst, up_down, cnt);

    // Test counting up
    drive(1, 1);  // cnt = 1
    drive(1, 1);  // cnt = 2
    drive(1, 1);  // cnt = 3
    drive(1, 1);  // cnt = 4

    // Test counting down
    up_down = 0;
    drive(1, 0);  // cnt = 3
    drive(1, 0);  // cnt = 2
    drive(1, 0);  // cnt = 1
    drive(1, 0);  // cnt = 0

    // Test reset
    rst = 1;
    #10 rst = 0;
    $display("rst=%b, up_down=%b, cnt=%b", rst, up_down, cnt);

    #10;
    $finish;
  end

  // Task to drive up_down and observe the counter
  task drive(input clk_edge, input up_dn);
    begin
      up_down = up_dn;
      #10;
      $display("rst=%b, up_down=%b, cnt=%b", rst, up_down, cnt);
    end
  endtask

endmodule
