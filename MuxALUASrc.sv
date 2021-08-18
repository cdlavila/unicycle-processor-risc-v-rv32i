module MuxALUASrc(
  input logic ALUASrc,
  input logic [31:0] A,
  input logic [31:0] PCAddress,
  output logic [31:0] ALUA);
  
  always @(*)
    begin
      if (ALUASrc == 0)
        ALUA <= A;
      else
        ALUA <= PCAddress;
    end
endmodule