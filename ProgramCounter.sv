module ProgramCounter(
  input logic clk,
  input logic [31:0] Src,
  output logic [31:0] Address = 0);
  
  always @(posedge clk)
    begin
      Address <= Src;
    end  
endmodule