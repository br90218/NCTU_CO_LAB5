//Subject:		CO project 4 - Adder
//--------------------------------------------------------------------------------
//Version:		1
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:	Just a common 32-bit adder.
//--------------------------------------------------------------------------------

module Adder(
    src1_i,
	src2_i,
	sum_o
);

//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
output [32-1:0]	 sum_o;

//Internal Signals
wire    [32-1:0]	 sum_o;

//Parameter

//Main function
assign sum_o = src1_i + src2_i;

endmodule