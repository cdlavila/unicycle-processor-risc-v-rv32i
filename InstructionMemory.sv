module InstructionMemory(
  input logic [31:0] Address,
  output logic [31:0] Instruction);
  
  parameter MemorySize = 2**10;
  logic [7:0] Memory [MemorySize - 1: 0];
  
  initial begin 
    $readmemh("Instructions.txt", Memory);
    //$monitor("Address %h", Address);
  end
  
  assign Instruction = {Memory[Address],Memory[Address + 1],
                        Memory[Address + 2],Memory[Address + 3]};
 
endmodule