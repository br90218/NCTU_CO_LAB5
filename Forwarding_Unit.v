//Subject:		CO project 5 - Forwarding_Unit
//--------------------------------------------------------------------------------
//Version:		1
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Forwarding_Unit(
    ID_EX_Register_Rs,
    ID_EX_Register_Rt,
    EX_MEM_Register_Rd,
    EX_MEM_RegWrite,
    MEM_WB_Register_Rd,
    MEM_WB_RegWrite,
    Forward_A,
    Forward_B
    );

//I/O ports
input	[5-1:0] ID_EX_Register_Rs;
input	[5-1:0] ID_EX_Register_Rt;
input	[5-1:0] EX_MEM_Register_Rd;
input	[5-1:0] MEM_WB_Register_Rd;
input 	EX_MEM_RegWrite;
input 	MEM_WB_RegWrite;
output	[2-1:0] Forward_A;
output	[2-1:0] Forward_B;

reg 	[2-1:0] Forward_A;
reg 	[2-1:0] Forward_B;

//Forwarding Conditions
always @ (*) begin
	if(MEM_WB_RegWrite & MEM_WB_Register_Rd!=0 & !(EX_MEM_RegWrite & EX_MEM_Register_Rd!=0 & EX_MEM_Register_Rd==ID_EX_Register_Rs) & MEM_WB_Register_Rd==ID_EX_Register_Rs) begin
		Forward_A = 2'b01;
	end
	else if(EX_MEM_RegWrite & EX_MEM_Register_Rd!=0 & EX_MEM_Register_Rd==ID_EX_Register_Rs) begin
		Forward_A = 2'b10;
	end
	else begin
		Forward_A = 2'b00;
	end

	if(MEM_WB_RegWrite & MEM_WB_Register_Rd!=0 & !(EX_MEM_RegWrite & EX_MEM_Register_Rd!=0 & EX_MEM_Register_Rd==ID_EX_Register_Rt)& MEM_WB_Register_Rd==ID_EX_Register_Rt) begin
		Forward_B = 2'b01;
	end
	else if(EX_MEM_RegWrite & EX_MEM_Register_Rd!=0 & EX_MEM_Register_Rd==ID_EX_Register_Rt) begin
		Forward_B = 2'b10;
	end
	else begin
		Forward_B = 2'b00;
	end
end

endmodule