//Subject:		CO project 4 - MUX 3to1
//--------------------------------------------------------------------------------
//Version:		1
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module MUX_3to1(
	data0_i,
	data1_i,
	data2_i,
	select_i,
	data_o
);

parameter size = 0;

//I/O ports
input	[size-1:0]	data0_i;
input	[size-1:0]	data1_i;
input	[size-1:0]	data2_i;
input	[1:0]		select_i;
output	[size-1:0]	data_o;

//Internal Signals
reg     [size-1:0]	data_o;

//Main function
always@ (*) begin
	case (select_i)
		2'b00:	data_o=data0_i;
		2'b01:	data_o=data1_i;
		2'b10:	data_o=data2_i;
		default:data_o=32'b0;
	endcase
end

endmodule