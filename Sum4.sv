module Sum4(
  input logic [31:0] Address,
  output logic [31:0] NextAddress);
  
  //Output
  assign NextAddress = Address + 4;
endmodule