module MuxRUDataWrSrc(
  input logic [1:0] RUDataWrSrc,
  input logic [31:0] NextAddress,
  input logic [31:0] DataRd,
  input logic [31:0] ALURes,
  output logic [31:0] RUDataWr);
  
  always @(*)
    begin
      case (RUDataWrSrc)
        2'b10: RUDataWr <= NextAddress;
        2'b01: RUDataWr <= DataRd;
        2'b00: RUDataWr <= ALURes;
        default: RUDataWr <= 0;
      endcase
    end
endmodule