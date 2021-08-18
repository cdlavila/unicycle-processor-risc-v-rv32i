module MuxNextPCSrc(
  input logic NextPCSrc,
  input logic [31:0] NextAddress,
  input logic [31:0] ALURes,
  output logic [31:0] PCSrc);
  
  always @(*)
    begin
      if (NextPCSrc == 0)
        PCSrc <= NextAddress;
      else
        PCSrc <= ALURes;
    end
endmodule