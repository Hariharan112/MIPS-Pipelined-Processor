module EXMEM(clock,iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps,iALUCtrl,
iIR,iPC,iB,iResult,iRegDest,iBranch,iJump,iZero,
oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,oMemToReg,oBranchs,oJumps,oALUCtrl,
oIR,oPC,oB,oResult,oRegDest,oBranch,oJump,oZero,enable);

// Nomenclature is 'i<name>' for input and 'o<name>' for output

input [31:0] iIR,iPC,iB,iResult,iBranch,iJump;
input iZero,clock,enable;
input iRegDests,iRegWrite,iALUSrc,iMemRead,iMemWrite,iMemToReg,iBranchs,iJumps;
input [3:0]iALUCtrl;
input [4:0] iRegDest;
output reg [31:0] oIR,oPC,oB,oResult,oBranch,oJump;
output reg oZero;
output reg oRegDests,oRegWrite,oALUSrc,oMemRead,oMemWrite,oMemToReg,oBranchs,oJumps;
output reg [3:0]oALUCtrl;
output reg [4:0]oRegDest;

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
    oB<=iB;
    oResult<=iResult;
    oRegDest<=iRegDest;
    oBranch<=iBranch;
    oJump<=iJump;
    oZero<=iZero;
end
end
endmodule