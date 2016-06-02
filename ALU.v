//Subject:		CO project 4 - ALU
//--------------------------------------------------------------------------------
//Version:		3
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module ALU(
	src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
);

// IO ports
input	[32-1:0]	src1_i;
input	[32-1:0]	src2_i;
input	[4-1:0]		ctrl_i;

output	[32-1:0]	result_o;
output				zero_o;

reg		[32-1:0]	result_o;
wire				zero_o;

// Parameter
parameter	AND		= 4'b0000;		// 0
parameter	OR		= 4'b0001;		// 1
parameter	ADD		= 4'b0010;		// 2
parameter	SUB		= 4'b0110;		// 6
parameter	SLT		= 4'b0111;		// 7
parameter	MULT	= 4'b0011;		// 3
parameter	JR		= 4'b1000;		// 8
parameter	SLL		= 4'b0101;		// 5
parameter	SRL		= 4'b1111;		// 15
parameter 	LUI		= 4'b0100; 		// 4

always@ (*) begin
	case (ctrl_i)
		AND:	result_o = src1_i & src2_i;
		OR:		result_o = src1_i | src2_i;
		ADD:	result_o = src1_i + src2_i;
		SUB:	result_o = src1_i - src2_i;
		SLT: begin
			if (src1_i[31] == src2_i[31]) begin
				if (src1_i < src2_i) result_o = 32'b1;
				else result_o = 32'b0;
			end
			else begin
				if (src1_i[31] == 1) result_o = 32'b1;
				else result_o = 32'b0;
			end
		end
		MULT:	result_o = src1_i * src2_i;
		SLL:	result_o = src2_i << src1_i;
		SRL:	result_o = src2_i >> src1_i;
		LUI:	result_o = src2_i << 16;
		JR:		result_o = src1_i;
		default:	result_o = 32'b0;
	endcase
end

assign zero_o = (result_o == 0) ? 1 : 0;

endmodule