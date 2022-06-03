/*
`define I_TYPE 3'b000
`define B      3'b001
`define D_TYPE 3'b010
`define CBZ    3'b011
`define IW     3'b100
 */

module SignExtender(BusImm, Imm26, Ctrl);
   output reg[63:0] BusImm;
   input [25:0]  Imm26;
   input [2:0] 	 Ctrl;  //Making signop up 3 bits for MOVZ functionality

   
   always @(*)
     begin
     if(Ctrl == 3'b000)
       BusImm <= {{52{Imm26[21]}}, Imm26[21:10]};
     else if(Ctrl == 3'b001)
       BusImm <= {{38{Imm26[25]}}, Imm26[25:0]};
     else if(Ctrl == 3'b010)
       BusImm <= {{55{Imm26[20]}}, Imm26[20:12]};
     else if(Ctrl == 3'b011)
       BusImm <= {{45{Imm26[23]}}, Imm26[23:5]};
     else if(Ctrl == 3'b100)  //MOVZ functionality
       begin
	  BusImm <= {{48{1'b0}}, Imm26[20:5]} << (16*Imm26[22:21]);
	  //BusImm = BusImm << (16*Imm26[22:21]);
	  
	  /*
	  if(Imm26[22:21] == 2'b01)
	    BusImm = BusImm << 16;
	  else if(Imm26[22:21] == 2'b10)
	    BusImm = BusImm << 32;
	  else if(Imm26[22:21] == 2'b11)
	    BusImm = BusImm << 48;
	   */
       end
   end
   
   /*
   case(Ctrl)
     //I-type Instruction
     `I_TYPE: assign BusImm = {{52{Imm26[21]}}, Imm26[21:10]};//Address offset in 21:10
     //B Instruction
     `B: assign BusImm = {{38{Imm26[25]}}, Imm26[25:0]};//Address offset in 25:0
     //D-type Instruction
     `D_TYPE: assign BusImm = {{55{Imm26[20]}}, Imm26[20:12]};//Address offset in 20:12
     //CBZ Instruction
     `CBZ: assign BusImm = {{45{Imm26[23]}}, Imm26[23:5]};//Address offset in 23:5
   endcase // case (Ctrl)
  */
endmodule // SignExtender
