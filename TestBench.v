//Subject:     CO project 5 - Test Bench
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------
`timescale 1ns / 1ps
`define CYCLE_TIME 10

module TestBench;

//Internal Signals
reg         CLK;
reg         RST;
integer     count;
integer     i;
integer     handle;

//Greate tested modle
Pipe_CPU_1 cpu(
        .clk_i(CLK),
	    .rst_n(RST)
		);

//Main function

always #(`CYCLE_TIME/2) CLK = ~CLK;

initial  begin
$readmemb("CO_P4_test1.txt", cpu.IM.Instr_Mem);

	CLK = 0;
	RST = 0;
	count = 0;

    #(`CYCLE_TIME)      RST = 1;
    //#(`CYCLE_TIME*40)      $stop;
    #(`CYCLE_TIME*400)      $stop; // for Fab function

end


always@(posedge CLK) begin
    count = count + 1;
	//if( count == 30 ) begin
	if( count == 400 ) begin
	//print result to transcript
	$display("Register===========================================================");
	$display("r0=%10d, r1=%10d, r2=%10d, r3=%10d, r4=%10d, r5=%10d, r6=%10d, r7=%10d",
	cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3], cpu.RF.Reg_File[4],
	cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7],
	);
	$display("r8=%10d, r9=%10d, r10=%9d, r11=%9d, r12=%9d, r13=%9d, r14=%9d, r15=%9d",
	cpu.RF.Reg_File[8], cpu.RF.Reg_File[9], cpu.RF.Reg_File[10], cpu.RF.Reg_File[11], cpu.RF.Reg_File[12],
	cpu.RF.Reg_File[13], cpu.RF.Reg_File[14], cpu.RF.Reg_File[15],
	);
	$display("r16=%9d, r17=%9d, r18=%9d, r19=%9d, r20=%9d, r21=%9d, r22=%9d, r23=%9d",
	cpu.RF.Reg_File[16], cpu.RF.Reg_File[17], cpu.RF.Reg_File[18], cpu.RF.Reg_File[19], cpu.RF.Reg_File[20],
	cpu.RF.Reg_File[21], cpu.RF.Reg_File[22], cpu.RF.Reg_File[23],
	);
	$display("r24=%9d, r25=%9d, r26=%9d, r27=%9d, r28=%9d, r29=%9d, r30=%9d, r31=%9d",
	cpu.RF.Reg_File[24], cpu.RF.Reg_File[25], cpu.RF.Reg_File[26], cpu.RF.Reg_File[27], cpu.RF.Reg_File[28],
	cpu.RF.Reg_File[29], cpu.RF.Reg_File[30], cpu.RF.Reg_File[31],
	);

	$display("\nMemory===========================================================");
	$display("m0=%10d, m1=%10d, m2=%10d, m3=%10d, m4=%10d, m5=%10d, m6=%10d, m7=%10d\nm8=%10d, m9=%10d, m10=%9d, m11=%9d, m12=%9d, m13=%9d, m14=%9d, m15=%9d\nr16=%9d, m17=%9d, m18=%9d, m19=%9d, m20=%9d, m21=%9d, m22=%9d, m23=%9d\nm24=%9d, m25=%9d, m26=%9d, m27=%9d, m28=%9d, m29=%9d, m30=%9d, m31=%9d",
	          cpu.DM.memory[0], cpu.DM.memory[1], cpu.DM.memory[2], cpu.DM.memory[3],
				 cpu.DM.memory[4], cpu.DM.memory[5], cpu.DM.memory[6], cpu.DM.memory[7],
				 cpu.DM.memory[8], cpu.DM.memory[9], cpu.DM.memory[10], cpu.DM.memory[11],
				 cpu.DM.memory[12], cpu.DM.memory[13], cpu.DM.memory[14], cpu.DM.memory[15],
				 cpu.DM.memory[16], cpu.DM.memory[17], cpu.DM.memory[18], cpu.DM.memory[19],
				 cpu.DM.memory[20], cpu.DM.memory[21], cpu.DM.memory[22], cpu.DM.memory[23],
				 cpu.DM.memory[24], cpu.DM.memory[25], cpu.DM.memory[26], cpu.DM.memory[27],
				 cpu.DM.memory[28], cpu.DM.memory[29], cpu.DM.memory[30], cpu.DM.memory[31]
			  );
	//$display("\nPC=%d\n",cpu.PC.pc_i);
	end
	else ;
end

endmodule

