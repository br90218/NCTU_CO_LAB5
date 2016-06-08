//Subject:		CO project 5 - MUX 2to1
//--------------------------------------------------------------------------------
//Version:		1
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module MUX_2to1(
	data0_i,
	data1_i,
	select_i,
	data_o
);

parameter size = 0;

//I/O ports
input	[size-1:0]	data0_i;
input	[size-1:0]	data1_i;
input				select_i;
output	[size-1:0]	data_o;

//Internal Signals
reg		[size-1:0]	data_o;

//Main function
always@ (*) begin
	if (select_i==1'b0) data_o=data0_i;
	else data_o=data1_i;
end

endmodule