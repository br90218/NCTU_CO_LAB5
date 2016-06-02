//Subject:		CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:		3
//--------------------------------------------------------------------------------
//Writer:		0210022 鍾承佑, 0210029 鄧仰哲
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
        clk_i,
		rst_n
		);

/****************************************
I/O ports
****************************************/
input clk_i;
input rst_n;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/

parameter IF_ID_SIZE = 64;

wire [32-1:0] new_pc_to_IF; // unused
wire [32-1:0] IF_current_pc;
wire [32-1:0] IF_current_pc_plus_4;
wire [32-1:0] IF_instr_o;
wire [IF_ID_SIZE-1:0] IF_ID_i;
wire [IF_ID_SIZE-1:0] IF_ID_o;

/**** ID stage ****/

parameter ID_EX_SIZE = 185;

//control signal
wire ID_Branch_o;
wire [1:0] ID_MemToReg_o;
wire [1:0] ID_BranchType_o;
wire ID_Jump_o;
wire ID_MemRead_o;
wire ID_MemWrite_o;
wire [2:0] ID_ALUOp_o;
wire ID_ALUSrc_o;
wire ID_RegWrite_o;
wire [1:0] ID_RegDst_o;

wire [32-1:0] ID_current_pc_plus_4_i;
wire [32-1:0] ID_instr_i;

wire [27:0] ID_Jump_Addr_28_bits_o;
wire [32-1:0] ID_Rs_data_o;
wire [32-1:0] ID_Rt_data_o;
wire [32-1:0] ID_sign_extended_val;
wire [ID_EX_SIZE-1:0] ID_EX_i;
wire [ID_EX_SIZE-1:0] ID_EX_o;

/**** EX stage ****/

parameter EX_MEM_SIZE = 176;

//control signal
wire [31:0] EX_Jump_Addr_i;
wire EX_Branch_i;
wire [1:0] EX_MemToReg_i;
wire [1:0] EX_BranchType_i;
wire EX_Jump_i;
wire EX_MemRead_i;
wire EX_MemWrite_i;
wire [2:0] EX_ALUOp_i;
wire EX_ALUSrc_i;
wire EX_RegWrite_i;
wire [1:0] EX_RegDst_i;
wire [31:0] EX_current_pc_plus_4_i;
wire [31:0] EX_Rs_data_i;
wire [31:0] EX_Rt_data_i;
wire [31:0]EX_sign_extended_val_i;
wire [4:0] EX_instr_i_20_16;
wire [4:0] EX_instr_i_15_11;

wire [32-1:0] EX_shifted;
wire [32-1:0] EX_Branch_Addr_o;
wire [32-1:0] EX_ALUSrc_data_o;
wire [4-1:0] EX_ALUCtrl_o;
wire EX_Jump_Reg_o;
wire [32-1:0] EX_ALU_result_o;
wire EX_ALU_zero_o;
wire [5-1:0] EX_RegDst_addr_o;
wire [EX_MEM_SIZE-1:0] EX_MEM_i;
wire [EX_MEM_SIZE-1:0] EX_MEM_o;

/**** MEM stage ****/

parameter MEM_WB_SIZE = 105;

//control signal
wire [31:0] MEM_Jump_Addr_i;
wire MEM_Branch_i;
wire [1:0] MEM_MemToReg_i;
wire [1:0] MEM_BranchType_i;
wire MEM_Jump_i;
wire MEM_MemRead_i;
wire MEM_MemWrite_i;
wire MEM_RegWrite_i;
wire [31:0] MEM_current_pc_plus_4_i;
wire [31:0] MEM_Branch_Addr_i;
wire MEM_ALU_zero_i;
wire [31:0] MEM_ALU_result_i;
wire [31:0]MEM_Rt_data_i;
wire [4:0] MEM_RegDst_addr_i;

wire [32-1:0] MEM_Read_data_o;
wire MEM_Branch_selector_o;
wire [31:0] MEM_Mux_PC_Source_PC_plus4_branch_Addr_o;
wire [31:0] MEM_Mux_PC_Source_PC_plus4_branch_Jump_Addr_o;
wire [31:0] MEM_PC_result_Addr_o;
wire MEM_Branch_mux;
wire [MEM_WB_SIZE-1:0] MEM_WB_i;
wire [MEM_WB_SIZE-1:0] MEM_WB_o;

/**** WB stage ****/

//control signal
wire WB_Jump_Reg_i;
wire [1:0] WB_MemToReg_i ;
wire WB_RegWrite_i;
wire [31:0] WB_current_pc_plus_4_i;
wire [31:0] WB_Read_data_i;
wire [31:0] WB_ALU_result_i;
wire [4:0] WB_RegDst_addr_i;
wire WB_RegWrite_o;

wire [32-1:0] WB_MemToReg_data_o;

/****************************************
Instnatiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) PC_selector(
	.data0_i(IF_current_pc_plus_4),
	.data1_i(MEM_PC_result_Addr_o),
	.select_i(MEM_Jump_Reg_i | MEM_Branch_i | MEM_Jump_i),
	.data_o(new_pc_to_IF)
	);

ProgramCounter PC(
	.clk_i(clk_i),
	.rst_i(rst_n),
	.pc_in_i(new_pc_to_IF),
	.pc_out_o(IF_current_pc)
	);

Instr_Memory IM(
	.pc_addr_i(IF_current_pc),
	.instr_o(IF_instr_o)
	);

Adder Add_pc(
	.src1_i(IF_current_pc),
	.src2_i(32'd4),
	.sum_o(IF_current_pc_plus_4)
	);

assign IF_ID_i[64-1-:32] = IF_current_pc_plus_4;
assign IF_ID_i[32-1-:32] = IF_instr_o;

Pipe_Reg #(.size(IF_ID_SIZE)) IF_ID(       //N is the total length of input/output
	.rst_i(rst_n),
	.clk_i(clk_i),
	.data_i(IF_ID_i),
	.data_o(IF_ID_o)
	);

//Instantiate the components in ID stage

assign ID_current_pc_plus_4_i = IF_ID_o[64-1-:32];
assign ID_instr_i = IF_ID_o[32-1-:32];

Shift_Left_Two_26_to_28 Jump_Shifter (
	.data_i(ID_instr_i[25:0]),
	.data_o(ID_Jump_Addr_28_bits_o)
);

Reg_File RF(
	.clk_i(clk_i),
	.rst_n(rst_n),
	.RSaddr_i(ID_instr_i[25:21]),
	.RTaddr_i(ID_instr_i[20:16]),
	.RDaddr_i(WB_RegDst_addr_i),
	.RDdata_i(WB_MemToReg_data_o),
	.RegWrite_i(WB_RegWrite_o),
	.RSdata_o(ID_Rs_data_o),
	.RTdata_o(ID_Rt_data_o)
	);

Decoder Control(
	.instr_op_i(ID_instr_i[31:26]),
	.Branch_o(ID_Branch_o),
	.MemToReg_o(ID_MemToReg_o),
	.BranchType_o(ID_BranchType_o),
	.Jump_o(ID_Jump_o),
	.MemRead_o(ID_MemRead_o),
	.MemWrite_o(ID_MemWrite_o),
	.ALUOp_o(ID_ALUOp_o),
	.ALUSrc_o(ID_ALUSrc_o),
	.RegWrite_o(ID_RegWrite_o),
	.RegDst_o(ID_RegDst_o)
	);

Sign_Extend Sign_Extend(
	.data_i(ID_instr_i[15:0]),
	.data_o(ID_sign_extended_val)
	);

// 32-bit jump address
assign ID_EX_i[184:181] = ID_current_pc_plus_4_i[31:28];
assign ID_EX_i[180:153] = ID_Jump_Addr_28_bits_o;

assign ID_EX_i[152] = ID_Branch_o;
assign ID_EX_i[151:150] = ID_MemToReg_o;
assign ID_EX_i[149:148] = ID_BranchType_o;
assign ID_EX_i[147] = ID_Jump_o;
assign ID_EX_i[146] = ID_MemRead_o;
assign ID_EX_i[145] = ID_MemWrite_o;
assign ID_EX_i[144:142] = ID_ALUOp_o;
assign ID_EX_i[141] = ID_ALUSrc_o;
assign ID_EX_i[140] = ID_RegWrite_o;
assign ID_EX_i[139:138] = ID_RegDst_o;
assign ID_EX_i[137-:32] = ID_current_pc_plus_4_i;
assign ID_EX_i[105-:32] = ID_Rs_data_o;
assign ID_EX_i[73-:32] = ID_Rt_data_o;
assign ID_EX_i[41-:32] = ID_sign_extended_val;
assign ID_EX_i[9:5] = ID_instr_i[20:16];
assign ID_EX_i[4:0] = ID_instr_i[15:11];

Pipe_Reg #(.size(ID_EX_SIZE)) ID_EX(
	.rst_i(rst_n),
	.clk_i(clk_i),
	.data_i(ID_EX_i),
	.data_o(ID_EX_o)
	);

//Instantiate the components in EX stage

assign EX_Jump_Addr_i = ID_EX_o[184:153];
assign EX_Branch_i = ID_EX_o[152];
assign EX_MemToReg_i = ID_EX_o[151:150];
assign EX_BranchType_i = ID_EX_o[149:148];
assign EX_Jump_i = ID_EX_o[147];
assign EX_MemRead_i = ID_EX_o[146];
assign EX_MemWrite_i = ID_EX_o[145];
assign EX_ALUOp_i = ID_EX_o[144:142];
assign EX_ALUSrc_i = ID_EX_o[141];
assign EX_RegWrite_i = ID_EX_o[140];
assign EX_RegDst_i = ID_EX_o[139:138];
assign EX_current_pc_plus_4_i = ID_EX_o[137-:32];
assign EX_Rs_data_i = ID_EX_o[105-:32];
assign EX_Rt_data_i = ID_EX_o[73-:32];
assign EX_sign_extended_val_i = ID_EX_o[41-:32];
assign EX_instr_i_20_16 = ID_EX_o[9:5];
assign EX_instr_i_15_11 = ID_EX_o[4:0];

Shift_Left_Two_32 Shifter (
	.data_i(EX_sign_extended_val_i),
	.data_o(EX_shifted)
);

Adder Branch_Addr_adder (
	.src1_i(EX_current_pc_plus_4_i),
	.src2_i(EX_shifted),
	.sum_o(EX_Branch_Addr_o)
);

ALU ALU(
	.src1_i(EX_Rs_data_i),
	.src2_i(EX_ALUSrc_data_o),
	.ctrl_i(EX_ALUCtrl_o),
	.result_o(EX_ALU_result_o),
	.zero_o(EX_ALU_zero_o)
	);

ALU_Ctrl ALU_Control(
	.funct_i(EX_sign_extended_val_i[5:0]),
	.ALUOp_i(EX_ALUOp_i),
	.ALUCtrl_o(EX_ALUCtrl_o),
	.Jump_Reg_o(EX_Jump_Reg_o)
	);

MUX_2to1 #(.size(32)) Mux1(
	.data0_i(EX_Rt_data_i),
	.data1_i(EX_sign_extended_val_i),
	.select_i(EX_ALUSrc_i),
	.data_o(EX_ALUSrc_data_o)
	);

MUX_3to1 #(.size(5)) Mux2(
	.data0_i(EX_instr_i_20_16),
	.data1_i(EX_instr_i_15_11),
	.data2_i(5'd31),
	.select_i(EX_RegDst_i),
	.data_o(EX_RegDst_addr_o)
	);

assign EX_MEM_i[175:144] = EX_Jump_Addr_i;
assign EX_MEM_i[143] = EX_Jump_Reg_o;
assign EX_MEM_i[142] = EX_Branch_i;
assign EX_MEM_i[141:140] = EX_MemToReg_i;
assign EX_MEM_i[139:138] = EX_BranchType_i;
assign EX_MEM_i[137] = EX_Jump_i;
assign EX_MEM_i[136] = EX_MemRead_i;
assign EX_MEM_i[135] = EX_MemWrite_i;
assign EX_MEM_i[134] = EX_RegWrite_i;
assign EX_MEM_i[133:102] = EX_current_pc_plus_4_i;
assign EX_MEM_i[101:70] = EX_Branch_Addr_o;
assign EX_MEM_i[69] = EX_ALU_zero_o;
assign EX_MEM_i[68-:32] = EX_ALU_result_o;
assign EX_MEM_i[36-:32] = EX_Rt_data_i;
assign EX_MEM_i[4:0] = EX_RegDst_addr_o;

Pipe_Reg #(.size(EX_MEM_SIZE)) EX_MEM(
	.rst_i(rst_n),
	.clk_i(clk_i),
	.data_i(EX_MEM_i),
	.data_o(EX_MEM_o)
	);

//Instantiate the components in MEM stage

assign MEM_Jump_Addr_i = EX_MEM_o[175:144];
assign MEM_Jump_Reg_i = EX_MEM_o[143];
assign MEM_Branch_i = EX_MEM_o[142];
assign MEM_MemToReg_i = EX_MEM_o[141:140];
assign MEM_BranchType_i = EX_MEM_o[139:138];
assign MEM_Jump_i = EX_MEM_o[137];
assign MEM_MemRead_i = EX_MEM_o[136];
assign MEM_MemWrite_i = EX_MEM_o[135];
assign MEM_RegWrite_i = EX_MEM_o[134];
assign MEM_current_pc_plus_4_i = EX_MEM_o[133:102];
assign MEM_Branch_Addr_i = EX_MEM_o[101:70];
assign MEM_ALU_zero_i = EX_MEM_o[69];
assign MEM_ALU_result_i = EX_MEM_o[68-:32];
assign MEM_Rt_data_i = EX_MEM_o[36-:32];
assign MEM_RegDst_addr_i = EX_MEM_o[4:0];

Data_Memory DM(
	.clk_i(clk_i),
	.addr_i(MEM_ALU_result_i),
	.data_i(MEM_Rt_data_i),
	.MemRead_i(MEM_MemRead_i),
	.MemWrite_i(MEM_MemWrite_i),
	.data_o(MEM_Read_data_o)
	);

MUX_4to1 #(.size(1)) BranchType_selector(
	.data0_i(MEM_ALU_zero_i),
	.data1_i(!(MEM_ALU_zero_i | MEM_ALU_result_i[31])),
	.data2_i(!MEM_ALU_result_i[31]),
	.data3_i(!MEM_ALU_zero_i),
	.select_i(MEM_BranchType_i),
	.data_o(MEM_Branch_selector_o)
	);

MUX_2to1 #(.size(32)) Mux_PC_Source_PC_plus4_branch(
	.data0_i(MEM_current_pc_plus_4_i),
	.data1_i(MEM_Branch_Addr_i),
	.select_i(MEM_Branch_selector_o),
	.data_o(MEM_Mux_PC_Source_PC_plus4_branch_Addr_o)
	);

MUX_2to1 #(.size(32)) Mux_PC_Source_PC_plus4_branch_Jump(
	.data0_i(MEM_Mux_PC_Source_PC_plus4_branch_Addr_o),
	.data1_i(MEM_ALU_result_i),
	.select_i(MEM_Jump_Reg_i),
	.data_o(MEM_Mux_PC_Source_PC_plus4_branch_Jump_Addr_o)
	);

MUX_2to1 #(.size(32)) Jump_PC_selector(
	.data0_i(MEM_Mux_PC_Source_PC_plus4_branch_Jump_Addr_o),
	.data1_i(MEM_Jump_Addr_i),
	.select_i(MEM_Jump_i),
	.data_o(MEM_PC_result_Addr_o)
	);

assign MEM_Branch_mux = MEM_Branch_i & MEM_Branch_selector_o;

assign MEM_WB_i[104] = MEM_Jump_Reg_i;
assign MEM_WB_i[103:102] = MEM_MemToReg_i;
assign MEM_WB_i[101] = MEM_RegWrite_i;
assign MEM_WB_i[100-:32] = MEM_current_pc_plus_4_i;
assign MEM_WB_i[68-:32] = MEM_Read_data_o;
assign MEM_WB_i[36-:32] = MEM_ALU_result_i;
assign MEM_WB_i[4:0] = MEM_RegDst_addr_i;

Pipe_Reg #(.size(MEM_WB_SIZE)) MEM_WB(
	.rst_i(rst_n),
	.clk_i(clk_i),
	.data_i(MEM_WB_i),
	.data_o(MEM_WB_o)
	);

//Instantiate the components in WB stage
assign WB_Jump_Reg_i = MEM_WB_o[104];
assign WB_MemToReg_i = MEM_WB_o[103:102];
assign WB_RegWrite_i = MEM_WB_o[101];
assign WB_current_pc_plus_4_i = MEM_WB_o[100-:32];
assign WB_Read_data_i = MEM_WB_o[68-:32];
assign WB_ALU_result_i = MEM_WB_o[36-:32];
assign WB_RegDst_addr_i = MEM_WB_o[4:0];

MUX_3to1 #(.size(32)) Mux3(
	.data0_i(WB_Read_data_i),
	.data1_i(WB_ALU_result_i),
	.data2_i(WB_current_pc_plus_4_i),
	.select_i(WB_MemToReg_i),
	.data_o(WB_MemToReg_data_o)
	);

assign WB_RegWrite_o = (!WB_Jump_Reg_i & WB_RegWrite_i);

/****************************************
signal assignment
****************************************/
endmodule

