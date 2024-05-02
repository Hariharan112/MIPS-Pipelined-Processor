// Stalling unit to detect Hazards

`timescale 1 ps / 100 fs

module StallControl(PC_WriteEn,IFID_WriteEn,IDEX_WriteEn,EXMEM_WriteEN,MEMWB_WriteEn,Stall_flush,EX_MemRead,EX_rt,ID_rs,ID_rt,ID_Op);
output PC_WriteEn,IFID_WriteEn,Stall_flush,IDEX_WriteEn,EXMEM_WriteEN,MEMWB_WriteEn;
reg PC_WriteEn,IFID_WriteEn,Stall_flush,IDEX_WriteEn,EXMEM_WriteEN,MEMWB_WriteEn;
input EX_MemRead,EX_rt,ID_rs,ID_rt;
input [5:0] ID_Op;
wire [4:0] EX_rt,ID_rs,ID_rt,xorRsRt,xorRtRt;
wire [5:0] xoropcodelw,xoropcodexori;
wire EX_MemRead;

always @(EX_MemRead or EX_rt or ID_rs or ID_rt)
begin
 if ((EX_MemRead==1)&&((EX_rt==ID_rs)||(EX_rt==ID_rt)))
  begin
  PC_WriteEn = 1'b0;
  IFID_WriteEn = 1'b0;
  IDEX_WriteEn = 1'b0;
  EXMEM_WriteEN = 1'b0;
  MEMWB_WriteEn = 1'b0;
  Stall_flush = 1'b1;
  end
  else
  begin
  PC_WriteEn = 1'b1;
  IFID_WriteEn = 1'b1;
  IDEX_WriteEn = 1'b1;
  EXMEM_WriteEN = 1'b1;
  MEMWB_WriteEn = 1'b1;
  Stall_flush = 1'b0;
  end
end
endmodule
