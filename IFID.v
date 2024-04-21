module IFID( clk, instruction, enable, PCp4, instruction_out, PCp4_out);
    
    input clk,
    input [31:0] instruction,
    input [31:0] PCp4,
    input enable,
    output reg [31:0] instruction_out,
    output reg [31:0] PCp4_out
    
    initial begin
        instruction_out <= 32'b0;
        PCp4 <= 32'b0;
    end
    
    always @(posedge clk) begin
        if (enable) begin
            instruction_out <= instruction;
            PCp4_out <= PCp4;
        end
    end
endmodule
