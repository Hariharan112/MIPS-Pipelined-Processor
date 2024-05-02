// Module takes in a bunch of signals, stores it when enable is high at posedge clk
module EXMEM(clock,
iRegDests,iRegWrite,iALUSrc,
iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps,iALUCtrl,
iIR,iPC,iB,iResult,iRegDest,iBranch,iJump,iZero,iALUOut,isignext,

oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,
oMemToReg,oBranchs,oJumps,oALUCtrl,oALUOut,
oIR,oPC,oB,oResult,oRegDest,oBranch,oJump,oZero,osignext,
enable);

// Nomenclature is 'i<name>' for input and 'o<name>' for output

input [31:0] iIR,iPC,iB,iResult,iBranch,iJump,iALUOut,isignext;
input iZero,clock,enable;
input iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps;
input [3:0]iALUCtrl;
input [4:0] iRegDest;
output reg [31:0] oIR,oPC,oB,oResult,oBranch,oJump,oALUOut,osignext;
output reg oZero;
output reg oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,oMemToReg,oBranchs,oJumps;
output reg [3:0]oALUCtrl;
output reg [4:0]oRegDest;

// Initialize any values in the pipe regs
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
    oALUOut<=iALUOut;
    oIR<=iIR;
    oPC<=iPC;
    osignext<=isignext;
    oB<=iB;
    oResult<=iResult;
    oRegDest<=iRegDest;
    oBranch<=iBranch;
    oJump<=iJump;
    oZero<=iZero;
end
end
endmodule

// testbench for this module
// module testbench();
// reg [31:0] iIR,iPC,iB,iResult,iBranch,iJump;
// reg iZero,clock,enable;
// reg iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps;
// reg [3:0]iALUCtrl;
// reg [4:0] iRegDest;
// wire [31:0] oIR,oPC,oB,oResult,oBranch,oJump;
// wire oZero;
// wire oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,oMemToReg,oBranchs,oJumps;
// wire [3:0]oALUCtrl;
// wire [4:0]oRegDest;

// EXMEM uut(clock,
// iRegDests,iRegWrite,iALUSrc,
// iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps,iALUCtrl,
// iIR,iPC,iB,iResult,iRegDest,iBranch,iJump,iZero,

// oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,
// oMemToReg,oBranchs,oJumps,oALUCtrl,
// oIR,oPC,oB,oResult,oRegDest,oBranch,oJump,oZero,enable);

// initial begin
//     $dumpfile("EXMEM.vcd");
//     $dumpvars(0,testbench);

//     iRegDests=1;
//     iRegWrite=1;
//     iALUSrc=1;
//     iMemRead=1;
//     iMemWrite=1;
//     iMemToReg=1;
//     iBranchs=1;
//     iJumps=1;
//     iALUCtrl=4'b0000;
//     iIR=32'b10101010101010101010101010101010;
//     iPC=32'b10101010101010101010101010101010;
//     iB=32'b10101010101010101010101010101010;
//     iResult=32'b10101010101010101010101010101010;
//     iRegDest=5'b10101;
//     iBranch=32'b10101010101010101010101010101010;
//     iJump=32'b10101010101010101010101010101010;
//     iZero=1;
//     clock=0;
//     enable=1;
//     #10;
//     clock=1;
//     #10;
//     clock=0;
//     enable=0;
//     #10;
//     clock=1;
//     #10;
//     iRegDests=0;
//     iRegWrite=0;
//     iALUSrc=0;
//     iMemRead=0;
//     iMemWrite=0;
//     iMemToReg=0;
//     iBranchs=0;
//     clock = 0;
//     #10;
//     clock = 1;
//     #10;
//     $finish;
// end
// endmodule