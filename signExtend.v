module signExt(inData,outData);
    input[15:0] inData;
    output[31:0] outData;
    reg[31:0] outData;

    
    always@(*)
    begin
        outData[15:0]=inData[15:0];
        outData[31:16]={16{inData[15]}};
    end
endmodule

// testbench for this module   
// module testbench;
//     reg [15:0]inData;
//     wire [31:0]outData;

//     signExt uut(inData,outData);

//     initial begin

//         $dumpfile("signExt.vcd");
//         $dumpvars(0,testbench);

//         inData=16'b0010101010101010;
//         #10;

//     end
// endmodule
