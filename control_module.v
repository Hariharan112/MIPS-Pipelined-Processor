module ControlModule(
    input [5:0] opcode,
    input [5:0] funct,
    output reg RegDests,
    output reg RegWrite,
    output reg ALUSrc,
    output reg MemRead,
    output reg MemWrite,
    output reg MemToReg,
    output reg Branchs,
    output reg Jumps,
    output reg [3:0] ALUCtrl
);

always @(*) begin
    if (opcode == 6'b100011) begin
        RegDests = 1;
        RegWrite = 1;
        ALUSrc = 1;
        MemRead = 1;
        MemWrite = 0;
        MemToReg = 1;
        Branchs = 0;
        Jumps = 0;
        ALUCtrl = 4'b0010;
    end else if (opcode == 6'b001101) begin
        RegDests = 0;
        RegWrite = 0;
        ALUSrc = 1;
        MemRead = 0;
        MemWrite = 1;
        MemToReg = 0;
        Branchs = 0;
        Jumps = 0;
        ALUCtrl = 4'b0010;
    end else if (opcode == 6'b000000) begin
        if (funct == 6'b100010) begin
            RegDests = 1;
            RegWrite = 1;
            ALUSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            MemToReg = 0;
            Branchs = 0;
            Jumps = 0;
            ALUCtrl = 4'b0110;
        end else if (funct == 6'b100110) begin
            RegDests = 1;
            RegWrite = 1;
            ALUSrc = 0;
            MemRead = 0;
            MemWrite = 0;
            MemToReg = 0;
            Branchs = 0;
            Jumps = 0;
            ALUCtrl = 4'b0111;
        end
    end
end

endmodule