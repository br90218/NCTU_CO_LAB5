//Subject:     CO project 5 - PC
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module ProgramCounter(
    clk_i,
	rst_i,
	write_disable,
	pc_in_i,
	pc_out_o
	);

//I/O ports
input           clk_i;
input	        rst_i;
input			write_disable;
input  [32-1:0] pc_in_i;
output [32-1:0] pc_out_o;

//Internal Signals
reg    [32-1:0] pc_out_o;

//Parameter


//Main function
always @(posedge clk_i) begin
    if(~rst_i) begin
	    pc_out_o <= 0;
	end
	else begin
		if(write_disable) pc_out_o <= pc_out_o;
		else pc_out_o <= pc_in_i;
	end
end

endmodule




