
module IDEX(clock,
iRegDests,iRegWrite,iALUSrc,iMemRead,
iMemWrite,iMemToReg,iBranchs,iJumps,iALUCtrl,
iIR,iPC,iA,iB,iRegDest,iBranch,iJump,

oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,
oMemToReg,oBranchs,oJumps,oALUCtrl,
oIR,oPC,oA,oB,oRegDest,oBranch,oJump,
enable);

// Nomenclature is 'i<name>' for input and 'o<name>' for output
input [31:0] iIR,iPC,iA,iB,iBranch,iJump;
input clock,enable;
input iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps;
input [3:0]iALUCtrl;
input [4:0] iRegDest;
output [31:0] oIR,oPC,oA,oB,oBranch,oJump;
output oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,oMemToReg,oBranchs,oJumps;
output [3:0]oALUCtrl;
output [4:0]oRegDest;
reg [31:0] oIR,oPC,oA,oB,oResult,oBranch,oJump;
reg oZero;
reg oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,oMemToReg,oBranchs,oJumps;
reg [3:0]oALUCtrl;
reg [4:0]oRegDest;


initial begin
    oPC=32'b0;
    oIR=32'b0;
end
always @(posedge clock)
begin
    if(enable)begin
        oRegDests<=iRegDests;
        oRegWrite<=iRegWrite;
        oALUSrc<=iALUSrc;
        oMemRead<=iMemRead;
        oMemWrite<=iMemWrite;
        oMemToReg<=iMemToReg;
        oBranchs<=iBranchs;
        oJumps<=iJumps;
        oALUCtrl<=iALUCtrl;
        oIR<=iIR;
        oPC<=iPC;
        oA<=iA;
        oB<=iB;
        oRegDest<=iRegDest;
        oBranch<=iBranch;
        oJump<=iJump;
    end
end
endmodule

//testbench for this module

// module testbench();
// reg [31:0] iIR,iPC,iA,iB,iBranch,iJump;
// reg iZero,clock,enable;
// reg iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps;
// reg [3:0]iALUCtrl;
// reg [4:0] iRegDest;

// IDEX IDEX(clock,
// iRegDests,iRegWrite,iALUSrc,iMemRead,
// iMemWrite,iMemToReg,iBranchs,iJumps,iALUCtrl,
// iIR,iPC,iA,iB,iRegDest,iBranch,iJump,

// oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,
// oMemToReg,oBranchs,oJumps,oALUCtrl,
// oIR,oPC,oA,oB,oRegDest,oBranch,oJump,
// enable);

// initial begin
//     $dumpfile("IDEX.vcd");
//     $dumpvars(0,testbench);
//     clock = 0;
//     //repeat module for clock

//     iRegDests=1'b0;
//     iRegWrite=1'b0;
//     iALUSrc=1'b0;
//     iMemRead=1'b0;
//     iMemWrite=1'b0;
//     iMemToReg=1'b0;
//     iBranchs=1'b0;
//     iJumps=1'b0;
//     iALUCtrl=4'b0000;
//     iIR=32'b0;
//     iPC=32'b0;
//     iA=32'b0;
//     iB=32'b0;
//     iRegDest=5'b00000;
//     iBranch=32'b0;
//     iJump=32'b0;
//     enable=1'b0;
//     #10;
//     enable=1'b1;
//     #20;

//     iRegDests=1'b1;
//     iRegWrite=1'b1;
//     iALUSrc=1'b1;
//     iMemRead=1'b1;
//     iMemWrite=1'b1;
//     iMemToReg=1'b1;
//     #10;
//     enable = 0;
//     #10;
//     iRegDests=1'b0;
//     iRegWrite=1'b0;
//     iALUSrc=1'b0;
//     iMemRead=1'b0;
//     iMemWrite=1'b0;
//     iMemToReg=1'b0;
//     #10;
//     enable = 1;
//     #20;
//     $finish;



// end
// initial begin
// repeat(20) begin
//         #10
//         clock = ~clock;
// end
// end

// endmodule