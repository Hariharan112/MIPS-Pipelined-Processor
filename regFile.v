`timescale 1ns / 1ps
module RegFile (
    output reg [31:0] regA,regB , input [4:0] readRegA, readRegB, writeReg, input [31:0] writeData, input RegWrite , input clk
    );

    reg [31:0] regFile [31:0];

    //intialize the register file. Used from old code
    initial begin
        regFile[0] = 32'h0;
        regFile[1] = 32'h0;
        regFile[2] = 6;
        regFile[3] = 0;
        regFile[4] = 32'h0E311;
        regFile[5] = 32'h944EB;
        regFile[6] = 32'h0;
        regFile[7] = 32'h964EA;
        regFile[8] = 32'h113D4;
        regFile[9] = 32'h0;
        regFile[10] = 32'h1230B;

    end

    always @(posedge clk) begin
        if (RegWrite) begin
            regFile[writeReg] <= writeData;
        end
    end

    always @(negedge clk) begin
            regA <= regFile[readRegA];
            regB <= regFile[readRegB];
    end
    
endmodule