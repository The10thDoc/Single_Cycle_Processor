`define OPCODE_ANDREG 11'b?0001010???
`define OPCODE_ORRREG 11'b?0101010???
`define OPCODE_ADDREG 11'b?0?01011???
`define OPCODE_SUBREG 11'b?1?01011???

`define OPCODE_ADDIMM 11'b?0?10001???
`define OPCODE_SUBIMM 11'b?1?10001???

`define OPCODE_MOVZ   11'b110100101??

`define OPCODE_B      11'b?00101?????
`define OPCODE_CBZ    11'b?011010????

`define OPCODE_LDUR   11'b??111000010
`define OPCODE_STUR   11'b??111000000

module control(
    output reg 	     reg2loc,
    output reg 	     alusrc,
    output reg 	     mem2reg,
    output reg 	     regwrite,
    output reg 	     memread,
    output reg 	     memwrite,
    output reg 	     branch,
    output reg 	     uncond_branch,
    output reg 	     move,  /*Adding move control signal for 2x1 mux*/
    output reg [3:0] aluop,
    output reg [2:0] signop, /*Changing signop to be 3 bit for MOVZ*/
    input [10:0]     opcode
);

always @(*)
begin
    casez (opcode)

        /* Add cases here for each instruction your processor supports */

        default:
        begin
            reg2loc       <= 1'bx;
            alusrc        <= 1'bx;
            mem2reg       <= 1'bx;
            regwrite      <= 1'b0;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'bxxxx;
	    move          <= 1'b0;
            signop        <= 3'bxxx;
        end // case: default

      11'b??111000010:
	begin
	   reg2loc        <= 1'bx;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b1;
	   mem2reg        <= 1'b1;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'b1;
	   regwrite       <= 1'b1;
	   aluop          <= 4'b0010;
	   move           <= 1'b0;
	   signop         <= 3'b010;
	end // case: LDUR

      11'b??111000000:
	begin
	   reg2loc        <= 1'b1;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b0;
	   mem2reg        <= 1'bx;
	   memwrite       <= 1'b1;
	   alusrc         <= 1'b1;
	   regwrite       <= 1'b0;
	   aluop          <= 4'b0010;
	   move           <= 1'b0;
	   signop         <= 3'b010;
	end // case: STUR

      11'b?0?01011???:
	begin
	   reg2loc        <= 1'b0;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b0;
	   mem2reg        <= 1'b0;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'b0;
	   regwrite       <= 1'b1;
	   aluop          <= 4'b0010;
	   move           <= 1'b0;
	   signop         <= 3'bxxx;
	end // case: ADDREG

      11'b?1?01011???:
	begin
	   reg2loc        <= 1'b0;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b0;
	   mem2reg        <= 1'b0;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'b0;
	   regwrite       <= 1'b1;
	   aluop          <= 4'b0110;
	   signop         <= 3'bxxx;
	end // case: SUBREG

      11'b?0?10001???: 
	begin
	   reg2loc        <= 1'b0;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b0;
	   mem2reg        <= 1'b0;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'b0;
	   regwrite       <= 1'b1;
	   aluop          <= 4'b0010;
	   move           <= 1'b0;
	   signop         <= 3'b000;
	end // case: ADDIMM

      11'b?1?10001???: 
	begin
	   reg2loc        <= 1'b0;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b0;
	   mem2reg        <= 1'b0;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'b0;
	   regwrite       <= 1'b1;
	   aluop          <= 4'b0110;
	   move           <= 1'b0;
	   signop         <= 3'b000;
	end // case: SUBIMM
      
      11'b?0001010???:
	begin
	   reg2loc        <= 1'b0;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b0;
	   mem2reg        <= 1'b0;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'b0;
	   regwrite       <= 1'b1;
	   aluop          <= 4'b0000;
	   move           <= 1'b0;
	   signop         <= 3'bxxx;
	end // case: ANDREG

      11'b?0101010???:
	begin
	   reg2loc        <= 1'b0;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b0;
	   mem2reg        <= 1'b0;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'b0;
	   regwrite       <= 1'b1;
	   aluop          <= 4'b0001;
	   move           <= 1'b0;
	   signop         <= 3'bxxx;
	end // case: ORRREG

      11'b?011010????:
	begin
	   reg2loc        <= 1'b1;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b1;
	   memread        <= 1'b0;
	   mem2reg        <= 1'bx;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'b0;
	   regwrite       <= 1'b0;
	   aluop          <= 4'b0111;
	   move           <= 1'b0;
	   signop         <= 3'b011;
	end // case: CBZ

      11'b?00101?????:
	begin
	   reg2loc        <= 1'bx;
	   uncond_branch  <= 1'b1;
	   branch         <= 1'bx;
	   memread        <= 1'b0;
	   mem2reg        <= 1'bx;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'bx;
	   regwrite       <= 1'b0;
	   aluop          <= 4'bxxxx;
	   move           <= 1'b0;
	   signop         <= 3'b001;
	end // case: B

      11'b110100101??:
	begin
	   reg2loc        <= 1'bx;
	   uncond_branch  <= 1'b0;
	   branch         <= 1'b0;
	   memread        <= 1'b0;
	   mem2reg        <= 1'bx;
	   memwrite       <= 1'b0;
	   alusrc         <= 1'bx;
	   regwrite       <= 1'b1;
	   aluop          <= 4'bxxxx;
	   move           <= 1'b1;
	   signop         <= 3'b100;
	end // case: MOVZ
 
    endcase
end

endmodule

