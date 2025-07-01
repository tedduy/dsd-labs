module tb_Universal_shift_register;
    reg clk, rst, shift_control, d_in;
    wire [3:0] d_out;

    Universal_shift_register DUT (
        .clk(clk),
        .rst(rst),
        .shift_control(shift_control),
        .d_in(d_in),
        .d_out(d_out)
    );

    always #1 clk = ~clk; // Clock with a period of 10 time units

    initial begin
        clk = 0; rst = 1; shift_control = 0; d_in = 0;
        $display("Reset=%b, d_out=%b", rst, d_out);

        #10 rst = 0;
        $display("Reset=%b, d_out=%b", rst, d_out);

        // Test shifting operations
        drive(1, 1); // Shift left with d_in = 1
        drive(1, 1); // Shift left with d_in = 1
        drive(0, 0); // Shift right with d_in = 0
        drive(0, 1); // Shift right with d_in = 1
        drive(1, 1); // Shift left with d_in = 0

        #10;
        $finish;
    end

    task drive(input shift_ctl, input din);
        begin
            shift_control = shift_ctl;
            d_in = din;
            #2; // Wait for one clock cycle
            $display("shift_control=%b, d_in=%b, d_out=%b", shift_control, d_in, d_out);
        end
    endtask

endmodule
