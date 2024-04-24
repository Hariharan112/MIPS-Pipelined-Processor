module shiftLeft(inData,outData);
input[31:0] inData;
output[31:0] outData;

assign outData=inData<<2;

endmodule

module shiftLeftForJump(inData,outData);
input[25:0] inData;
output [27:0] outData;

assign outData={inData,2'b0};

endmodule

// testbench for this modules
// module testbench;
//     reg [31:0]inData;
//     wire [31:0]outData;
//     reg [25:0]inDataForJump;
//     wire [27:0]outDataForJump;

//     shiftLeft uut(inData,outData);
//     shiftLeftForJump uut1(inDataForJump,outDataForJump);

//     initial begin

//         $dumpfile("shiftLeft.vcd");
//         $dumpvars(0,testbench);

//         inData=32'b10101010101010101010101010101010;
//         inDataForJump=26'b10101010101010101010101010;
//         #10;

//     end
// endmodule
