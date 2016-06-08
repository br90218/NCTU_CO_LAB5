//Subject:		CO project 5 - ALU Controller
//--------------------------------------------------------------------------------
//Version:		3
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module ALU_Ctrl(
	funct_i,
	ALUOp_i,
	ALUCtrl_o,
	Jump_Reg_o
);

// IO ports
input	[5:0]	funct_i;
input	[2:0]	ALUOp_i;

output	[4-1:0]	ALUCtrl_o;
output			Jump_Reg_o;

//Internal Signals
reg		[4-1:0] ALUCtrl_o;
wire			Jump_Reg_o;

// Parameter
parameter	AND		= 4'b0000;		// 0
parameter	OR		= 4'b0001;		// 1
parameter	ADD		= 4'b0010;		// 2
parameter	SUB		= 4'b0110;		// 6
parameter	SLT		= 4'b0111;		// 7
parameter	MULT	= 4'b0011;		// 3

parameter	SLL		= 4'b0101;		// 5
parameter	SRL		= 4'b1111;		// 15
parameter 	LUI		= 4'b0100; 		// 4
parameter 	JR		= 4'b1000;		// 8

parameter	funct_SLL	= 6'b000000;
parameter	funct_SRLV	= 6'b000110;
parameter	funct_JR	= 6'b001000;
parameter	funct_MULT	= 6'b011000;
parameter	funct_ADD	= 6'b100000;
parameter	funct_SUB	= 6'b100010;
parameter	funct_AND	= 6'b100100;
parameter	funct_OR	= 6'b100101;
parameter	funct_SLT	= 6'b101010;

always@ (*) begin
	case (ALUOp_i)
		3'b000:		ALUCtrl_o = ADD;
		3'b001:		ALUCtrl_o = SUB;
		3'b010: begin
			case (funct_i)
				funct_SLL:
					ALUCtrl_o = SLL;
				funct_SRLV:
					ALUCtrl_o = SRL;
				funct_JR:
					ALUCtrl_o = JR;
				funct_MULT:
					ALUCtrl_o = MULT;
				funct_ADD:
					ALUCtrl_o = ADD;
				funct_SUB:
					ALUCtrl_o = SUB;
				funct_AND:
					ALUCtrl_o = AND;
				funct_OR:
					ALUCtrl_o = OR;
				funct_SLT:
					ALUCtrl_o = SLT;
			endcase
		end
		3'b011:		ALUCtrl_o = SLT;
		3'b100:		ALUCtrl_o = LUI;
		3'b101:		ALUCtrl_o = OR;
	endcase
end
assign Jump_Reg_o = (funct_i == 6'b001000 & ALUOp_i == 3'b010) ? 1 : 0;
endmodule