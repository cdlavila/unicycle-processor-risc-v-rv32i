module DataMemory(
  input logic [31:0] Address,
  input logic signed [31:0] DataWr,
  input logic DMWr,
  input logic [2:0] DMCtrl,
  output logic signed [31:0] DataRd);

  parameter MemorySize = 2**10;
  logic [7:0] Memory [MemorySize - 1: 0];
  integer i;
  
  initial begin 
    $readmemh("Memory.txt", Memory);
  end

  always @(*) begin
    // Writing
    if(DMWr == 1) begin
      case (DMCtrl)
        //Byte
        3'b000: begin
          Memory[Address] = DataWr[7:0];
        end

        //Half word
        3'b001: begin
          Memory[Address] = DataWr[7:0];
          Memory[Address + 1] = DataWr[15:8];
        end

        //Word
        3'b010: begin
          Memory[Address] = DataWr[7:0];
          Memory[Address + 1] = DataWr[15:8];
          Memory[Address + 2] = DataWr[23:16];
          Memory[Address + 3] = DataWr[31:24];
        end
      endcase
    end
    
    // Reading
    case (DMCtrl)
      //Byte
      3'b000: begin
        DataRd = {{24{Memory[Address][7]}}, Memory[Address]};
      end

      //Half word
      3'b001: begin
        DataRd = {{16{Memory[Address+1][7]}},
                  Memory[Address+1], Memory[Address]};
      end

      //Word
      3'b010: begin
        DataRd = {Memory[Address+3], Memory[Address+3],
                  Memory[Address+1], Memory[Address]};
      end

      //Byte unsigned
      3'b100: begin
        DataRd = {24'b0, Memory[Address]};
      end

      //Half word unsigned
      3'b101: begin
        DataRd = {16'b0, Memory[Address+1], Memory[Address]};
      end

      default: DataRd = 32'bx;
      
    endcase
    
  end

endmodule
