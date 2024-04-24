module concatForJump(part1, part2,result);
    input [3:0]part1;
    input [27:0]part2;
    output reg [31:0]result;


    always @(part1,part2)begin
        result={part1,part2};
    end
endmodule

// testbench for this module
module testbench;
    reg [3:0]part1;
    reg [27:0]part2;
    wire [31:0]result;

    concatForJump uut(part1,part2,result);

    initial begin

        $dumpfile("concatForJump.vcd");
        $dumpvars(0,testbench);

        part1=4'b0000;
        part2=28'b1010101010101010101010101010;
        #10;
        $display("result=%b",result);
    end
endmodule
