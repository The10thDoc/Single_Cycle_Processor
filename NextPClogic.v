module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
   input [63:0] CurrentPC, SignExtImm64;
   input 	Branch, ALUZero, Uncondbranch;
   output reg[63:0] NextPC;

   wire [63:0] 	    Mux0, Mux1;
   wire 	    Selector;
   

   assign #2 Mux0 = CurrentPC + 4;               //Setting up input 0 for Mux
   assign #2 Mux1 = CurrentPC + (SignExtImm64 << 2);    //Setting up input 1 for Mux

   assign Selector = (Uncondbranch || (Branch && ALUZero));//Setting a selector bit for branching
   
   always @(*)  //Placeholder
     begin

	if(Selector)
	  #1 NextPC <= Mux1;
	else
	  #1 NextPC <= Mux0;
	
	/*
	if(Uncondbranch)       //Unconditional always branches
	  NextPC #1 <= Mux1;
	else if(!Branch)       //!Branch always is CurrentPC + 4
	  NextPC #1 <= Mux0;
	else if(ALUZero)       //ALUZero always branches
	  NextPC # <= Mux1;
	else                   //Catching failed conditionals
	  NextPC #1 <= Mux0;
	*/
     end // always @ (*)	
	  
endmodule
