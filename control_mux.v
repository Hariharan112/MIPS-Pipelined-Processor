module ControlMux(
    input sel,RegDests,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branchs,Jumps,ALUCtrl,
    output RegDests_nop,RegWrite_nop,ALUSrc_nop,MemRead_nop,MemWrite_nop,MemToReg_nop,Branchs_nop,Jumps_nop,ALUCtrl_nop

);

assign RegDests_nop = (sel == 1'b0) ? RegDests : 4'b0;
assign RegWrite_nop = (sel == 1'b0) ? RegWrite : 1'b0;
assign ALUSrc_nop = (sel == 1'b0) ? ALUSrc : 1'b0;
assign MemRead_nop = (sel == 1'b0) ? MemRead : 1'b0;
assign MemWrite_nop = (sel == 1'b0) ? MemWrite : 1'b0;
assign MemToReg_nop = (sel == 1'b0) ? MemToReg : 1'b0;
assign Branchs_nop = (sel == 1'b0) ? Branchs : 1'b0;
assign Jumps_nop = (sel == 1'b0) ? Jumps : 1'b0;
assign ALUCtrl_nop = (sel == 1'b0) ? ALUCtrl : 4'b0;

endmodule