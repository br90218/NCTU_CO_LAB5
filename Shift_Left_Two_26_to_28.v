//Subject:		CO project 5 - Shift_Left_Two_26_to_28
//--------------------------------------------------------------------------------
//Version:		1
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Shift_Left_Two_26_to_28(
    data_i,
    data_o
    );

//I/O ports
input	[25:0]	data_i;
output	[27:0]	data_o;

//shift left 2
assign data_o[27:2] = data_i[25:0];
assign data_o[1:0] = 2'b00;

endmodule