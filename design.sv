// Import Components
`include "ProgramCounter.sv"
`include "Sum4.sv"
`include "InstructionMemory.sv"
`include "ControlUnit.sv"
`include "RegistersUnit.sv"
`include "ImmGen.sv"
`include "BranchUnit.sv"
`include "MuxALUASrc.sv"
`include "MuxALUBSrc.sv"
`include "ALU.sv"
`include "MuxNextPCSrc.sv"
`include "DataMemory.sv"
`include "MuxRUDataWrSrc.sv"

//Unicycle Processor RISC-V RV32I
module UnicycleProcessorRISCV(input logic clk);
  
  // Program Counter
  logic [31:0] Address;
  // Sum4
  logic [31:0] NextAddress;
  // Instruction Memory
  logic [31:0] Instruction;
  // Control Unit
  logic [4:0] BrOp;
  logic [3:0] ALUOp;
  logic [2:0] ImmSrc;
  logic [2:0] DMCtrl;
  logic [1:0] RUDataWrSrc;
  logic ALUASrc;
  logic ALUBSrc;
  logic RUWr;
  logic DMWr;
  // Registers Unit
  logic [31:0] A;
  logic [31:0] B;
  // Immediate Generator
  logic [31:0] ImmExt;
  // Branch Unit
  logic NextPCSrc;
  // MuxALUASrc
  logic [31:0] ALUA;
  // MuxALUBSrc
  logic [31:0] ALUB;
  // ALU
  logic [31:0] ALURes;
  // MuxNextPCSrc
  logic [31:0] PCSrc;
  // Data Memory
  logic [31:0] DataRd;
  // MuxRUDataWrSrc
  logic [31:0] RUDataWr;
  
  ProgramCounter PC(
    .clk(clk),
    .Src(PCSrc),
    .Address(Address));
  
  Sum4 S4(
    .Address(Address),
    .NextAddress(NextAddress));
  
  InstructionMemory IM(
    .Address(Address),
    .Instruction(Instruction));
  
  ControlUnit CU(
    .OpCode(Instruction[6:0]),
    .Funct3(Instruction[14:12]), 
    .Funct7(Instruction[31:25]), 
    .ALUASrc(ALUASrc),
    .ALUBSrc(ALUBSrc),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp),
    .DMWr(DMWr),
    .DMCtrl(DMCtrl),
    .RUDataWrSrc(RUDataWrSrc),
    .RUWr(RUWr),
    .BrOp(BrOp));
  
  RegistersUnit RU(
    .clk(clk),
    .rs1(Instruction[19:15]),
    .rs2(Instruction[24:20]),
    .rd(Instruction[11:7]),
    .DataWr(RUDataWr),
    .RUWr(RUWr),
    .A(A),
    .B(B));
  
  ImmGen IG(
    .Inst(Instruction),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt));
  
  BranchUnit BU(
    .A(A),
    .B(B),
    .BrOp(BrOp),
    .NextPCSrc(NextPCSrc));
  
  MuxALUASrc MuxASrc(
    .ALUASrc(ALUASrc),
    .A(A),
    .PCAddress(Address),
    .ALUA(ALUA));
  
  MuxALUBSrc MuxBSrc(
    .ALUBSrc(ALUBSrc),
    .B(B),
    .ImmExt(ImmExt),
    .ALUB(ALUB));
  
  ALU AL(
    .A(ALUA),
    .B(ALUB),
    .ALUOp(ALUOp),
    .ALURes(ALURes));
  
  MuxNextPCSrc MuxNPSrc(
    .NextPCSrc(NextPCSrc),
    .NextAddress(NextAddress),
    .ALURes(ALURes),
    .PCSrc(PCSrc));
    
  DataMemory DM(
    .Address(ALURes),
    .DataWr(B),
    .DMWr(DMWr),
    .DMCtrl(DMCtrl),
    .DataRd(DataRd));
  
  MuxRUDataWrSrc MuxRUDWSrc(
    .RUDataWrSrc(RUDataWrSrc),
    .NextAddress(NextAddress),
    .DataRd(DataRd),
    .ALURes(ALURes),
    .RUDataWr(RUDataWr));
  
endmodule