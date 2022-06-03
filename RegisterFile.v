module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
   output [63:0] BusA, BusB;
   input [63:0]  BusW;
   input [4:0] 	 RA, RB, RW;
   input 	 RegWr;
   input 	 Clk;
   
   reg [63:0] 	 registers [31:0];//Creating thirty-two 64 bit registers

   initial
     begin
	registers[31] <= 0;
     end

    assign #2 BusA = registers[RA];//idk if this works, will have to test
    assign #2 BusB = registers[RB];//Same here
     
    always @ (negedge Clk)
      begin
	 if(RegWr && RW != 31)
            registers[RW] <= #3 BusW;

	 
	 //registers[31] <= 0;//Setting Register X31, or XZR, equal to 0
       
    end

endmodule
