//Subject:     CO project 5 - Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------
module Pipe_Reg(
            rst_i,
			clk_i,
			data_i,
			write_disable,
			flush,
			data_o
);

parameter size = 0;
input                    rst_i;
input                    clk_i;
input 					 write_disable;
input		  			 flush;
input      [size-1: 0] data_i;
output reg [size-1: 0] data_o;

always @(posedge clk_i or negedge  rst_i) begin
	if( rst_i == 0) begin
		data_o <= 0;
	end
    else begin
    	if (write_disable) data_o <= data_o;
    	else if (flush) data_o <= 0;
    	else data_o <= data_i;
    end
end

endmodule