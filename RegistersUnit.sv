module RegistersUnit(
  input logic clk,
  input logic [4:0] rs1,
  input logic [4:0] rs2,
  input logic [4:0] rd,
  input logic [31:0] DataWr,
  input logic RUWr,
  output logic [31:0] A,
  output logic [31:0] B);
  
  logic [31:0] Matrix [31:0];
  
  initial
    begin
      $readmemb("Registers.txt", Matrix);
    end
  
  // Reading
  assign A = Matrix[rs1];
  assign B = Matrix[rs2];
  
  always @(posedge clk)
    begin
      // Writing
      if (RUWr == 1 && rd != 5'b0)
        Matrix[rd] <= DataWr;
      //$monitor("X18 %d", Matrix[18]);
    end
  
endmodule