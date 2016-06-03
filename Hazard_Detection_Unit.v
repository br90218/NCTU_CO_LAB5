//Subject:		CO project 5 - Hazard Detection Unit
//--------------------------------------------------------------------------------
//Version:		1
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Hazard_Detection_Unit(
    ID_EX_Register_Rt,
    IF_ID_Register_Rs,
    IF_ID_Register_Rt,
    ID_EX_MemRead,
    EX_MEM_Branch,
    ID_Controls_Flush,
    IF_Controls_Flush, //flushes the original IF/ID pipeline register data again to ID/EX pipeline register
    IF_ID_Write_Disable, //Disables IM from writing new values to IF/ID pipeline
    EX_Controls_Flush,
    PC_Write_Disable
    );

//I/O ports
input	[5-1:0] ID_EX_Register_Rt;
input	[5-1:0] IF_ID_Register_Rs;
input	[5-1:0] IF_ID_Register_Rt;
input 	ID_EX_MemRead;
input   EX_MEM_Branch;

output	reg ID_Controls_Flush;
output	reg IF_Controls_Flush;
output	reg IF_ID_Write_Disable;
output  reg EX_Controls_Flush;
output	reg PC_Write_Disable;

//Forwarding Conditions
always @ (*) begin
	if(ID_EX_MemRead & (ID_EX_Register_Rt == IF_ID_Register_Rs | ID_EX_Register_Rt == IF_ID_Register_Rt ))begin //data hazard -- load use hazard
		ID_Controls_Flush = 1'b1;
		IF_Controls_Flush = 1'b0;
		IF_ID_Write_Disable = 1'b1;
		EX_Controls_Flush = 1'b0;
		PC_Write_Disable = 1'b1;
	end
	else if(EX_MEM_Branch)begin
		ID_Controls_Flush = 1'b1;
		IF_Controls_Flush = 1'b1;
		IF_ID_Write_Disable = 1'b0;
		EX_Controls_Flush = 1'b1;
		PC_Write_Disable = 1'b0;
	end
	else begin
		ID_Controls_Flush = 1'b0;
		IF_Controls_Flush = 1'b0;
		IF_ID_Write_Disable = 1'b0;
		EX_Controls_Flush = 1'b0;
		PC_Write_Disable = 1'b0;
	end
end

endmodule