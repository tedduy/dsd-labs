module lab2_ex8(
    input [17:0] SW,
    output [17:0] LEDR,
    output [7:0] LEDG
);
    assign LEDR = SW;
    parameter N = 8;

    compNbit DUT (
        .A(SW[N-1:0]),
        .B(SW[N*2-1:N]),
        .eq(LEDG[0]),
        .gt(LEDG[1]),
        .lt(LEDG[2])
    );
    defparam DUT.N = N;
endmodule

module compNbit #(
    parameter N = 8
)(
    input [N-1:0] A,
    input [N-1:0] B,
    output eq,
    output gt,
    output lt
);
    assign eq = (A == B);
    assign gt = (A > B);
    assign lt = (A < B);
endmodule
