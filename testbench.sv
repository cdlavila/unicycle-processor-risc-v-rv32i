//Unicycle Processor RISC-V RV32I Test Bench 
module TestBench();
  logic clk;

  UnicycleProcessorRISCV Test(clk);
  
  always
    begin
      #10 clk = ~clk;
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
      clk = 0;
      #1100;
      $finish();
    end
endmodule
