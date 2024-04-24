module adder32bit(in1,in2,out);
input [31:0]in1;
input [31:0]in2;
output [31:0]out;
reg [31:0]out;
always@(in1,in2)begin
out=in1+in2;
end
endmodule


// testbench for this module
// module adder32bit_tb();
// reg [31:0]in1;
// reg [31:0]in2;
// wire [31:0]out;
// adder32bit adder32bit1(in1,in2,out);
// initial begin
//     $dumpfile("adder32bit.vcd");
//     $dumpvars(0,adder32bit1);

// in1=32'd0;
// in2=32'd0;
// #10 in1=32'd5;
// #10 in2=32'd6;
// #10 in1=32'd10;
// $finish;

// end
// endmodule
