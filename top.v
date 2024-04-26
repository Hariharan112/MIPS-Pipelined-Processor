module top(input clk);

    wire [31:0] pc_input;
    wire [31:0] pc_output;
    wire pc_write_enable; // from the hazard detection unit

    PCRegWrite pc(
        .in(pc_input),
        .clk(clk),
        .out(pc_output),
        .enable(1'b)
    );

    adder32bit pc_adder(
        .in_0(pc_output),
        .in_1(32'h4),
        .out(pc_input)
    );


    wire [31:0] instrread_output;

    IMemBank instr_mem(
        .memread(1'b1),
        .address(pc_output),
        .readdata(instrread_output),
        .clk(clk)
    );

    wire enable_ifid; // from the hazard detection unit
    wire [31:0] ifid_instruction;
    wire [31:0] ifid_pcplus4;

    IFID ifid(
        .clk(clk),
        .instruction(instrread_output),
        .enable(enable_ifid),
        .PCp4(pc_input),
        .instruction_out(ifid_instruction),
        .PCp4_out(ifid_pcplus4)
    );

    wire[31:0] wbwrite_data;//comes from WB stage
    wire[4:0] wb_write_reg;//comes from WB stage
    wire regwrite;//comes from WB stage
    
    wire [31:0] idregA,idregB;
    RegFile regfile(
        .regA(regA),
        .regB(regB),
        .readRegA(ifid_instruction[25:21]), // rs
        .readRegB(ifid_instruction[20:16]), // rt
        .writeReg(write_reg), // rd
        .writeData(write_data),
        .RegWrite(regwrite),
        .clk(clk)
    );

    //define these control signal input iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps;
    // input [3:0]iALUCtrl; as wires

    wire [3:0] idALUCtrl;
    wire idRegDests,idRegWrite,idALUSrc,idMemRead,idMemWrite,idMemToReg,idBranchs,idJumps;

    ControlModule control(
        .opcode(ifid_instruction[31:26]),
        .funct(ifid_instruction[5:0]),
        .RegDests(idRegDests),
        .RegWrite(idRegWrite),
        .ALUSrc(idALUSrc),
        .MemRead(idMemRead),
        .MemWrite(idMemWrite),
        .MemToReg(idMemToReg),
        .Branchs(idBranchs),
        .Jumps(idJumps),
        .ALUCtrl(idALUCtrl)
    );

    //signextended immediate value
    
    wire [31:0] idsignext;
    
    signextender signextend(
        .in(ifid_instruction[15:0]),
        .out(idsignext)
    );

    wire nop_mux_sel; // from the hazard detection unit
    //control signal mux that sets all the control signals to 0 when the instruction is a nop
     wire [3:0] id_nop_ALUCtrl;
    wire id_nop_RegDests,id_nop_RegWrite,id_nop_ALUSrc,id_nop_MemRead,id_nop_MemWrite,id_nop_MemToReg,id_nop_Branchs,id_nop_Jumps;

    //
    ControlMux controlmux(
        .sel(nop_mux_sel),
        .RegDests(idRegDests),
        .RegWrite(idRegWrite),
        .ALUSrc(idALUSrc),
        .MemRead(idMemRead),
        .MemWrite(idMemWrite),
        .MemToReg(idMemToReg),
        .Branchs(idBranchs),
        .Jumps(idJumps),
        .ALUCtrl(idALUCtrl)
        .RegDests_nop(id_nop_RegDests),
        .RegWrite_nop(id_nop_RegWrite),
        .ALUSrc_nop(id_nop_ALUSrc),
        .MemRead_nop(id_nop_MemRead),
        .MemWrite_nop(id_nop_MemWrite),
        .MemToReg_nop(id_nop_MemToReg),
        .Branchs_nop(id_nop_Branchs),
        .Jumps_nop(id_nop_Jumps),
        .ALUCtrl_nop(id_nop_ALUCtrl)
    );

    //IDEX module
    wire[31:0] EX_IR,EX_PC,EX_A,EX_B,EX_Branch,EX_Jump,EX_signext;
    wire EX_RegDests,EX_RegWrite,EX_ALUSrc,EX_MemRead,EX_MemWrite,EX_MemToReg,EX_Branchs,EX_Jumps;
    wire[3:0] EX_ALUCtrl;
    wire[4:0] EX_RegDest;

    wire enable_idex; // from the hazard detection unit

    IDEX idex(
        .clock(clk),
        .iRegDests(idRegDests),
        .iRegWrite(idRegWrite),
        .iALUSrc(idALUSrc),
        .iMemRead(idMemRead),
        .iMemWrite(idMemWrite),
        .iMemToReg(idMemToReg),
        .iBranchs(idBranchs),
        .iJumps(idJumps),
        .iALUCtrl(idALUCtrl),
        .iIR(ifid_instruction),
        .iPC(ifid_pcplus4),
        .iA(idregA),
        .iB(idregB),
        .isignext(.idsignext),
        .iRegDest(ifid_instruction[15:11]),
        .iBranch(ifid_instruction[15:0]),
        .iJump(ifid_instruction[25:0]),
        .oRegDests(EX_RegDests),
        .oRegWrite(EX_RegWrite),
        .oALUSrc(EX_ALUSrc),
        .oMemRead(EX_MemRead),
        .oMemWrite(EX_MemWrite),
        .oMemToReg(EX_MemToReg),
        .oBranchs(EX_Branchs),
        .oJumps(EX_Jumps),
        .oALUCtrl(EX_ALUCtrl),
        .oIR(EX_IR),
        .oPC(EX_PC),
        .oA(EX_A),
        .oB(EX_B),
        .osignext(EX_signext),
        .oRegDest(EX_RegDest),
        .enable(enable_idex)
    );

    wire [31:0] mem_write_reg; //comes from MEM stage

    wire [1:0] forwardA,forwardB;

    ForwardingUnit forward(
        .EX_MEM_rd(EX_RegDest),
        .MEM_WB_rd(wb_write_reg),
        .ID_EX_rs(EX_IR[25:21]),
        .ID_EX_rt(EX_IR[20:16]),
        .EX_MEM_RegWrite(EX_RegWrite),
        .MEM_WB_RegWrite(regwrite),

        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    

    wire [31:0] mem_aluout,mem_pcplus4,mem_write_data;
    mux_4x1 in1mux(
        .in_0(EX_A),
        .in_1(mem_aluout),
        .in_2(wbwrite_data),
        .in_3(32'h0),
        .sel(),
        .Out(ex_aluin1)
    );

    mux_4x1 in2mux(
        .in_0(EX_B),
        .in_1(EX_signext),
        .in_2(mem_aluout),
        .in_3(wbwrite_data),
        .sel(),
        .Out(ex_aluin2)
    );

    wire [31:0] ex_aluin1,ex_aluin2,ex_aluout;
    wire ex_zero,ex_lt,ex_gt;

    ALU alu(
        .data1(ex_aluin1),
        .data2(ex_aluin2),
        .aluoperation(EX_ALUCtrl),
        .result(ex_aluout),
        .zero(ex_zero),
        .lt(ex_lt),
        .gt(ex_gt)
    );
    



endmodule