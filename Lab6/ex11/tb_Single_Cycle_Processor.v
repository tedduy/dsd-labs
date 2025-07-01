module tb_Single_Cycle_Processor;
    reg reset, clk;
    wire [31:0] W_PC_out, instruction, W_m2;
    wire [15:0] W_RD1, W_RD2, W_m1, W_ALUout;
    reg [127:0] instr_name;
    
    
    Single_Cycle_Processor_16bit dut(
        .reset(reset),
        .clk(clk),
        .W_PC_out(W_PC_out),
        .instruction(instruction),
        .W_RD1(W_RD1),
        .W_RD2(W_RD2),
        .W_m1(W_m1),
        .W_m2(W_m2),
        .W_ALUout(W_ALUout)
    );
    
    
    always #5 clk = ~clk;
    
    
    always @(instruction) begin
        case (instruction[31:26])
            6'b000000: begin 
                case (instruction[5:0]) // funct field
                    6'b100000: instr_name = "ADD       ";
                    6'b100010: instr_name = "SUB       ";
                    6'b011000: instr_name = "MULT      ";
                    6'b011010: instr_name = "DIV       ";
                    6'b100100: instr_name = "AND       ";
                    6'b100101: instr_name = "OR        ";
                    6'b100110: instr_name = "XOR       ";
                    6'b100111: instr_name = "NOR       ";
                    6'b101000: instr_name = "NAND      ";
                    6'b101010: instr_name = "XNOR      ";
                    6'b000000: instr_name = "SLL       ";
                    6'b000010: instr_name = "SRL       ";
                    6'b111000: instr_name = "ROL       ";
                    6'b110000: instr_name = "ROR       ";
                    default:   instr_name = "UNKNOWN_R ";
                endcase
            end
            6'b000100: instr_name = "BEQ       ";
            6'b100011: instr_name = "LW        ";
            6'b101011: instr_name = "SW        ";
            6'b001000: instr_name = "ADDI      ";
            6'b000101: instr_name = "BNE       ";
            6'b000010: instr_name = "J         ";
            6'b000011: instr_name = "JAL       ";
            default:   instr_name = "UNKNOWN   ";
        endcase
    end
    
    always @(posedge clk) begin
        $display($time,
            " reset=%b | clk=%b | PC=%4d | Inst=%-10s | Op=%6b | rs=%2d | rt=%2d | rd=%2d | zero=%b | Imm=%4h | ALU=%4h | RD1=%4h | RD2=%4h",
            reset, clk, W_PC_out, instr_name, instruction[31:26], 
            instruction[25:21], instruction[20:16], instruction[15:11], 
            dut.C11.zero, instruction[15:0], W_ALUout, W_RD1, W_RD2);
    end
    
    initial begin
        clk = 0;
        reset = 0;
        instr_name = "";
        
        
        $display("\n\t\t\t\t----------TEST SINGLE-CYCLE PROCESSOR----------\n");
        $display("\n\t\t\t\t----------R-TYPE INSTRUCTIONS TEST----------\n");
       
        #10 reset = 1;
        #10 reset = 0;
        #140 $display("\n\t\t\t\t----------I-TYPE INSTRUCTIONS TEST----------\n");
        
        
        #120 $display("\n\t\t\t\t----------J-TYPE INSTRUCTIONS TEST----------\n");
        
        #100 $finish;
    end
endmodule