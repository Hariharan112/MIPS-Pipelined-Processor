`timescale 1 ps / 100 fs 
// Forwarding Unit
module ForwardingUnit(
    input [4:0] EX_MEM_rd,
    input [4:0] MEM_WB_rd,
    input [4:0] ID_EX_rs,
    input [4:0] ID_EX_rt,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,
    input[1:0] EX_ALUSrcA,
    input[1:0] MEM_ALUSrcB,

    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);

always(*) 
    begin
        forwardA <= EX_ALUSrcA;
        forwardB <= MEM_ALUSrcB;
        // EX hazard
        if(EX_MEM_RegWrite) begin
            if(EX_MEM_rd == ID_EX_rs) begin
                forwardA <= 2'b10;
            end
            else if(EX_MEM_rd == ID_EX_rt) begin
                forwardB <= 2'b10;
            end
        end

        // MEM Hazard
        else if(MEM_WB_RegWrite) begin
            if(MEM_WB_rd == ID_EX_rs) begin
                forwardA <= 2'b01;
            end
            else if(MEM_WB_rd == ID_EX_rt) begin
                forwardB <= 2'b01;
            end
        end
    end



endmodule