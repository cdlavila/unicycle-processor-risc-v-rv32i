module ControlUnit(
  input logic [6:0] OpCode,
  input logic [2:0] Funct3,
  input logic [6:0] Funct7, 
  output logic ALUASrc,
  output logic ALUBSrc,
  output logic [2:0] ImmSrc,
  output logic [3:0] ALUOp,
  output logic DMWr,
  output logic [2:0] DMCtrl,
  output logic [1:0] RUDataWrSrc,
  output logic RUWr,
  output logic [4:0] BrOp);
  
  always @(*)
    begin
      case (OpCode)
        7'b0110011: //Type R Instructions
          begin
            ALUASrc = 0;
            ALUBSrc = 0;
            ImmSrc = 3'bxxx;
            ALUOp = {Funct7[5], Funct3};
            DMWr = 0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'b00;
            RUWr = 1;
            BrOp = 5'b00xx;
          end
        7'b0010011: // Type I Arithmetic-Logic Instructions
          begin
            ALUASrc = 0;
            ALUBSrc = 1;
            ImmSrc = 3'b000;
            //srli or srai instructions
            if (Funct3 == 3'b101)
              ALUOp = {Funct7[5],Funct3};
            //Other instructions
            else
              ALUOp = {1'b0, Funct3};
            DMWr = 0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'b00;
            RUWr = 1;
            BrOp = 5'b00xx;
          end
        7'b0000011: // Type I (load) Instruction
          begin
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ImmSrc = 3'b000;
            ALUOp = 4'b0000;
            DMWr = 0;
            DMCtrl = Funct3;
            RUDataWrSrc = 2'b01;
            RUWr = 1;
            BrOp = 5'b00xxx;
          end
        7'b1100111: // Type I (jalr) Instruction
          begin
            ALUASrc = 0;
            ALUBSrc = 1;
            ImmSrc = 3'b000;
            ALUOp = 4'b0000;
            DMWr = 0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'b10;
            RUWr = 0;
            BrOp = 5'b1xxxx;
          end
        7'b0100011: // Type S Instruction 
          begin 
            ALUASrc = 0;
            ALUBSrc = 1;
            ImmSrc = 3'b001;
            ALUOp = 4'b0000;
            DMWr = 1;
            DMCtrl = Funct3;
            RUDataWrSrc = 2'bxx;
            RUWr = 0;
            BrOp = 5'b00xx; 
          end
        7'b1100011: // Type B Instruction 
          begin
            ALUASrc = 1;
            ALUBSrc = 1;
            ImmSrc = 3'b101;
            ALUOp = 4'b0000;
            DMWr = 0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'bxx;
            RUWr = 0;
            BrOp = {2'b01,Funct3};
          end
        7'b1101111: // Type J Instructions 
          begin 
            ALUASrc = 1;
            ALUBSrc = 1;
            ImmSrc = 3'b110;
            ALUOp = 4'b0000;
            DMWr = 0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'b10;
            RUWr = 1;
            BrOp = 5'b1xxxx;
          end
        7'b0110111: // Type U (lui) Instrucion
          begin 
            ALUASrc = 1'bx;
            ALUBSrc = 1;
            ImmSrc = 3'b010;
            ALUOp = 4'b1111;
            DMWr = 0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'b00;
            RUWr = 1;
            BrOp = 5'b00xxx;
          end
        7'b0010111: // Type U (auipc) Instruction
          begin 
            ALUASrc = 1;
            ALUBSrc = 1;
            ImmSrc = 3'b010;
            ALUOp = 4'b0000;
            DMWr = 0;
            DMCtrl = 3'bxxx;
            RUDataWrSrc = 2'b00;
            RUWr = 1'b1;
            BrOp = 5'b00xxx;
          end
      endcase
    end
endmodule