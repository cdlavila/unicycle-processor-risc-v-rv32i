module BranchUnit(
  input logic [31:0] A, // Viene de RU[rs1]
  input logic [31:0] B, // Viene de RU[rs2]
  input logic [4:0] BrOp,
  output logic NextPCSrc);
  
  always @(*)
    begin
      if (BrOp[4])
          NextPCSrc = 1;
      else
        if (BrOp[3])
          case (BrOp[2:0])
            3'b000: // BEQ
              NextPCSrc = (A == B);
            3'b001: // BNE
              NextPCSrc = (A != B);
            3'b100: // BLT
              NextPCSrc = (A < B);
            3'b101: // BGE
              NextPCSrc = (A >= B);
            3'b110: // BLTU
              NextPCSrc = ($unsigned(A) < $unsigned(B));
            3'b111: // BGEU
              NextPCSrc = ($unsigned(A) >= $unsigned(B));
            default:
              NextPCSrc = 1'bx;
          endcase
      	else
        	NextPCSrc = 0;
    end
endmodule