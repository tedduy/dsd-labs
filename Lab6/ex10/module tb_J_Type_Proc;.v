module tb_J_Type_Proc;
    reg reset, clk;
    wire [31:0] W_PC_out, instruction, W_m2;
    wire [15:0] W_RD1, W_RD2, W_m1, W_ALUout;
    reg [127:0] instr_name; 


    J_Type_Processor dut(reset, clk, W_PC_out, instruction, W_RD1, W_RD2, W_m1, W_m2, W_ALUout);

    // Clock generation
    always #5 clk = ~clk;

    // Task to decode instruction name
    task decode_instruction;
        input [31:0] instr;
        output reg [127:0] name; // String for instruction name
        begin
            case (instr[31:26]) // Use opcode field for J-Type instructions
                6'b000010: name = "JUMP (J)";
                6'b000011: name = "JUMP AND LINK (JAL)";
                default: name = "Unknown Instruction";
            endcase
        end
    endtask

    initial begin
        clk = 0;
        reset = 1;
        $display("                    ----------TEST J-TYPE----------");

        #10 reset = 0;
        $monitor($time,
            " reset=%b | clk=%b | W_PC_out=%4d | Instruction=%s | Opcode=%6b | Imm=%h | W_ALUout=%h ",
            reset, clk, W_PC_out, instr_name, instruction[31:26],
            instruction[15:0], W_ALUout);


        // Simulate decoding each instruction during runtime for a limited duration
        repeat (9) begin
            decode_instruction(instruction, instr_name);
            #10; // Wait for the next clock cycle
        end

        $finish;
    end
endmodule
