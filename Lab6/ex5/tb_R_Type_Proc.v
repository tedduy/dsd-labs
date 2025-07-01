module tb_R_Type_Proc;
    reg reset, clk;
    wire [31:0] W_PC_out, instruction, W_m2;
    wire [15:0] W_RD1, W_RD2, W_m1, W_ALUout;
    reg [127:0] instr_name; 

    R_Type_Proc dut(reset, clk, W_PC_out, instruction, W_RD1, W_RD2, W_m1, W_m2, W_ALUout);

    // Clock generation
    always #5 clk = ~clk;

    // Task to decode instruction name
    task decode_instruction;
        input [31:0] instr;
        output reg [127:0] name; // String for instruction name
        begin
            if (instr[31:26] == 6'b000000) begin // R-Type instructions
                case (instr[5:0]) // funct field
                    6'b100000: name = "Addition";
                    6'b100010: name = "Subtraction";
                    6'b011000: name = "Multiplication";
                    6'b011010: name = "Division";
                    6'b100100: name = "Logical AND";
                    6'b100101: name = "Logical OR";
                    6'b100110: name = "Logical XOR";
                    6'b100111: name = "Logical NOR";
                    6'b101000: name = "Logical NAND";
                    6'b101010: name = "Logical XNOR";
                    6'b000000: name = "Shift Left";
                    6'b000010: name = "Shift Right";
                    6'b111000: name = "Rotate Left";
                    6'b110000: name = "Rotate Right";
                    default: name = "Unknown Instruction";
                endcase
            end else begin
                name = "Not R-Type Instruction";
            end
        end
    endtask

    initial begin
        $monitor($time,
            " reset=%b | clk=%b | W_PC_out=%4d | Instruction=%s | Opcode=%6b | rs=%d | rt=%d | rd=%d | Imm=%h | W_ALUout=%h | W_RD1=%h | W_RD2=%h",
            reset, clk, W_PC_out, instr_name, instruction[31:26], instruction[25:21], instruction[20:16], instruction[15:11],
            instruction[15:0], W_ALUout, W_RD1, W_RD2);

        clk = 0;
        reset = 1;
        $display("                    ----------TEST R-TYPE----------");

        #10 reset = 0;

        // Simulate decoding each instruction during runtime for a limited duration
        repeat (13) begin
            decode_instruction(instruction, instr_name);
            #10; // Wait for the next clock cycle
        end

        $finish;
    end
endmodule