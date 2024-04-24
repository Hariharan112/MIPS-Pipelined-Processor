`timescale 1ns / 1ps

module data_mem(
    output reg [31:0] out32, 
    input [31:0] address , 
    input [31:0] writeData ,
    input memwrite ,  memread ,clk
    );

    reg [7:0] mem [255:0];

    initial begin // Used from MIPS-Multicycle-Processor
        mem[0] = 8'h00;
        mem[1] = 8'h43;
        mem[2] = 8'h08;
        mem[3] = 8'h22;

        mem[4] = 8'h8C;
        mem[5] = 8'hA4;
        mem[6] = 8'h00;
        mem[7] = 8'h06;
        
        mem[252] = 8'h11;
        mem[253] = 8'h11;
        mem[254] = 8'h11;
        mem[255] = 8'h11;
        
    end

    always @(posedge clk ) begin
        if (memwrite) begin
            mem[address] <= writeData[31:24];
            mem[address+1] <= writeData[23:16];
            mem[address+2] <= writeData[15:8];
            mem[address+3] <= writeData[7:0];
        end
    end

     always @(* )  begin // Not negedge? I thought this was negedge?
        if (memread) begin
            out32[31:24] <= mem[address];
            out32[23:16] <= mem[address+1];
            out32[15:8] <= mem[address+2];
            out32[7:0] <= mem[address+3];
        end
    end

endmodule

// Testbench for this module
// module data_mem_tb();
//     reg [31:0] address;
//     reg [31:0] writeData;
//     reg memwrite, memread, clk;
//     wire [31:0] out32;

//     data_mem data_mem1(out32, address, writeData, memwrite, memread, clk);

//     initial begin
//         $dumpfile("data_mem.vcd");
//         $dumpvars(0,data_mem1);

//         address= 32'd252;
//         writeData=32'h11111111;
//         memwrite=1'b1;
//         clk=1'b0;
//         #10 clk=1'b1;
//         #10 clk=1'b0;
//         memwrite=1'b0;
//         memread=1'b1;
//         #10 clk=1'b1;
//         #10 clk=1'b0;
//         $finish;
//     end
// endmodule
