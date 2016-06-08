//Subject:		CO project 5 - Decoder
//--------------------------------------------------------------------------------
//Version:		3
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Decoder(
	instr_op_i,
	Branch_o,
	MemToReg_o,
	BranchType_o,
	Jump_o,
	MemRead_o,
	MemWrite_o,
	ALUOp_o,
	ALUSrc_o,
	RegWrite_o,
	RegDst_o
);

// IO ports
input	[6-1:0]	instr_op_i;

output			Branch_o;
output	[1:0]	MemToReg_o;
output	[1:0]	BranchType_o;
output			Jump_o;
output 			MemRead_o;
output			MemWrite_o;
output	[3-1:0]	ALUOp_o;
output			ALUSrc_o;
output			RegWrite_o;
output	[1:0]	RegDst_o;

reg				Branch_o;
reg		[1:0]	MemToReg_o;
reg		[1:0]	BranchType_o;
reg				Jump_o;
reg 			MemRead_o;
reg				MemWrite_o;
reg		[3-1:0]	ALUOp_o;
reg				ALUSrc_o;
reg				RegWrite_o;
reg		[1:0]	RegDst_o;

// Parameters
parameter		Instr_op_R_Type = 6'b000000;
parameter		Instr_op_BGEZ	= 6'b000001;
parameter 		Instr_op_JUMP	= 6'b000010;
parameter		Instr_op_JAL	= 6'b000011;
parameter		Instr_op_BEQ	= 6'b000100;
parameter		Instr_op_BNE	= 6'b000101;
parameter		Instr_op_BGT	= 6'b000111;
parameter		Instr_op_ADDI	= 6'b001000;
parameter		Instr_op_SLTI	= 6'b001010;
parameter		Instr_op_ORI	= 6'b001101;
parameter		Instr_op_LUI	= 6'b001111;
parameter		Instr_op_LW		= 6'b100011;
parameter		Instr_op_SW		= 6'b101011;

always@ (instr_op_i) begin
	case (instr_op_i)
		Instr_op_R_Type: begin
			Branch_o=0;
			MemToReg_o=1;
			//BranchType_o: don't care
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b010;
			ALUSrc_o=0;
			RegWrite_o=1;
			RegDst_o=1;
		end
		Instr_op_BGEZ: begin
			Branch_o=1;
			//MemToReg_o: don't care
			BranchType_o=2;
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b001;
			//ALUSrc_o: don't care
			RegWrite_o=0;
			//RegDst_o: don't care
		end
		Instr_op_JUMP: begin
			//Branch_o: don't care
			//MemToReg_o: don't care
			//BranchType_o: don't care
			Jump_o=1;
			MemRead_o=0;
			MemWrite_o=0;
			//ALUOp_o: don't care
			//ALUSrc_o: don't care
			RegWrite_o=0;
			//RegDst_o: don't care
		end
		Instr_op_JAL: begin
			//Branch_o: don't care
			MemToReg_o=2;
			//BranchType_o: don't care
			Jump_o=1;
			MemRead_o=0;
			MemWrite_o=0;
			//ALUOp_o: don't care
			//ALUSrc_o: don't care
			RegWrite_o=1;
			RegDst_o=2;
		end
		Instr_op_BEQ: begin
			Branch_o=1;
			//MemToReg_o: don't care
			BranchType_o=0;
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b001;
			ALUSrc_o=0;
			RegWrite_o=0;
			//RegDst_o: don't care
		end
		Instr_op_BNE: begin
			Branch_o=1;
			//MemToReg_o: don't care
			BranchType_o=3;
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b001;
			ALUSrc_o=0;
			RegWrite_o=0;
			//RegDst_o: don't care
		end
		Instr_op_BGT: begin
			Branch_o=1;
			//MemToReg_o: don't care
			BranchType_o=1;
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b001;
			ALUSrc_o=0;
			RegWrite_o=0;
			//RegDst_o: don't care
		end
		Instr_op_ADDI: begin
			Branch_o=0;
			MemToReg_o=1;
			//BranchType_o: don't care
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b000;
			ALUSrc_o=1;
			RegWrite_o=1;
			RegDst_o=0;
		end
		Instr_op_SLTI: begin
			Branch_o=0;
			MemToReg_o=1;
			//BranchType_o: don't care
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b011;
			ALUSrc_o=1;
			RegWrite_o=1;
			RegDst_o=0;
		end
		Instr_op_ORI: begin
			Branch_o=0;
			MemToReg_o=1;
			//BranchType_o: don't care
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b101;
			ALUSrc_o=1;
			RegWrite_o=1;
			RegDst_o=0;
		end
		Instr_op_LUI: begin
			Branch_o=0;
			MemToReg_o=1;
			//BranchType_o: don't care
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=0;
			ALUOp_o=3'b100;
			ALUSrc_o=1;
			RegWrite_o=1;
			RegDst_o=0;
		end
		Instr_op_LW: begin
			Branch_o=0;
			MemToReg_o=0;
			//BranchType_o: don't care
			Jump_o=0;
			MemRead_o=1;
			MemWrite_o=0;
			ALUOp_o=3'b000;
			ALUSrc_o=1;
			RegWrite_o=1;
			RegDst_o=0;
		end
		Instr_op_SW: begin
			Branch_o=0;
			//MemToReg_o: don't care
			//BranchType_o: don't care
			Jump_o=0;
			MemRead_o=0;
			MemWrite_o=1;
			ALUOp_o=3'b000;
			ALUSrc_o=1;
			RegWrite_o=0;
			//RegDst_o: don't care
		end
		default: begin

		end
	endcase
end
endmodule
