onerror {resume}
quietly virtual signal -install /TestBench/cpu { /TestBench/cpu/ID_instr_i[25:21]} ID_Rs
quietly virtual signal -install /TestBench/cpu { /TestBench/cpu/ID_instr_i[20:16]} ID_Rt
quietly virtual signal -install /TestBench/cpu { /TestBench/cpu/ID_instr_i[15:11]} ID_Rd
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /TestBench/cpu/IF_current_pc
add wave -noupdate -radix decimal /TestBench/cpu/new_pc_to_IF
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix decimal -childformat {{{/TestBench/cpu/ID_Rs[25]} -radix decimal} {{/TestBench/cpu/ID_Rs[24]} -radix decimal} {{/TestBench/cpu/ID_Rs[23]} -radix decimal} {{/TestBench/cpu/ID_Rs[22]} -radix decimal} {{/TestBench/cpu/ID_Rs[21]} -radix decimal}} -subitemconfig {{/TestBench/cpu/ID_instr_i[25]} {-radix decimal} {/TestBench/cpu/ID_instr_i[24]} {-radix decimal} {/TestBench/cpu/ID_instr_i[23]} {-radix decimal} {/TestBench/cpu/ID_instr_i[22]} {-radix decimal} {/TestBench/cpu/ID_instr_i[21]} {-radix decimal}} /TestBench/cpu/ID_Rs
add wave -noupdate -radix decimal /TestBench/cpu/EX_instr_i_25_21
add wave -noupdate -radix decimal /TestBench/cpu/ID_Rt
add wave -noupdate -radix decimal /TestBench/cpu/EX_instr_i_20_16
add wave -noupdate -radix decimal /TestBench/cpu/ID_Rd
add wave -noupdate -radix decimal /TestBench/cpu/EX_instr_i_15_11
add wave -noupdate -divider ALU_Src1
add wave -noupdate -radix decimal /TestBench/cpu/EX_Rs_data_i
add wave -noupdate -radix decimal /TestBench/cpu/WB_MemToReg_data_o
add wave -noupdate -radix decimal /TestBench/cpu/MEM_ALU_result_i
add wave -noupdate -radix binary /TestBench/cpu/ALU_Src1_select
add wave -noupdate -radix decimal /TestBench/cpu/ALU_Src1_o
add wave -noupdate -divider ALU_SRC2
add wave -noupdate -radix decimal /TestBench/cpu/EX_Rt_data_i
add wave -noupdate -radix decimal /TestBench/cpu/WB_MemToReg_data_o
add wave -noupdate -radix decimal /TestBench/cpu/MEM_ALU_result_i
add wave -noupdate -radix binary /TestBench/cpu/ALU_Src2_select
add wave -noupdate -radix decimal /TestBench/cpu/ALU_Src2_o
add wave -noupdate -divider Src2_Select
add wave -noupdate -radix decimal /TestBench/cpu/ALU_Src2_o
add wave -noupdate -radix decimal /TestBench/cpu/EX_sign_extended_val_i
add wave -noupdate -radix binary /TestBench/cpu/EX_ALUSrc_i
add wave -noupdate -radix decimal /TestBench/cpu/EX_ALUSrc_data_o
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix decimal /TestBench/cpu/EX_instr_i_25_21
add wave -noupdate -radix decimal /TestBench/cpu/EX_instr_i_20_16
add wave -noupdate /TestBench/cpu/MEM_RegWrite_i
add wave -noupdate /TestBench/cpu/WB_RegWrite_o
add wave -noupdate -radix decimal /TestBench/cpu/MEM_RegDst_addr_i
add wave -noupdate -radix decimal /TestBench/cpu/WB_RegDst_addr_i
add wave -noupdate -radix binary /TestBench/cpu/ALU_Src1_select
add wave -noupdate -radix binary /TestBench/cpu/ALU_Src2_select
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50129 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 272
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {283945 ps} {416635 ps}
