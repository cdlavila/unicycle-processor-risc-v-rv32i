module MuxALUBSrc(
  input logic ALUBSrc,
  input logic [31:0] B,
  input logic [31:0] ImmExt,
  output logic [31:0] ALUB);
  
  always @(*)
    begin
      if (ALUBSrc == 0)
        ALUB <= B;
      else
        ALUB <= ImmExt;
    end
endmodule