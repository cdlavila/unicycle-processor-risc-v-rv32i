module ImmGen(
  input logic [31:0] Inst,
  input logic [2:0] ImmSrc,
  output logic [31:0] ImmExt);
  
  always @(*)
    begin
      case (ImmSrc)
        3'b000: //Type I Instruction
          ImmExt = {{20{Inst[31]}}, Inst[31:20]};
        3'b001: //Type S Instruction
          ImmExt = {{20{Inst[31]}}, Inst[31:25], Inst[11:7]};
        3'b101: //Type B Instruction
          ImmExt = {{19{Inst[31]}}, Inst[31], Inst[7], Inst[30:25],
                    Inst[11:8], 1'b0};
        3'b010: //Type U Instruction
          ImmExt = {{11{Inst[31]}}, Inst[31:12], 1'b0};
        3'b110: //Type J Instruction
          ImmExt = {{11{Inst[31]}}, Inst[31], Inst[19:12],
                    Inst[20], Inst[30:21], 1'b0};
        default: //Type R Instruction
          ImmExt = 32'b0;
      endcase
    end
endmodule