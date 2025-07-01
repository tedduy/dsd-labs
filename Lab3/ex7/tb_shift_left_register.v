module tb_shift_left_register;
  reg clk, rst, d_in;
  wire [3:0] d_out;
  shift_left_register uut (
    .clk(clk),
    .rst(rst),
    .d_in(d_in),
    .d_out(d_out)
  );
  always #1 clk = ~clk;
  initial begin
    clk = 0;
    rst = 1;
    $display("Reset=%b --> d_out=%b", rst, d_out);
    #10 rst = 0;
    $display("Reset=%b --> d_out=%b", rst, d_out);
    drive(1);
    drive(0);
    drive(1);
    drive(1);
    drive(0);
    #5;
    $finish;
  end
  task drive(input value);
    begin
      d_in = value;
      #2;
      $display("d_in=%b --> d_out=%b", d_in, d_out);
    end
  endtask
endmodule
