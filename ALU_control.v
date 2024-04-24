module ALUcontrol(clk,funct,ALUOp,ALUsignal);
input clk;
input[5:0] funct;
input[2:0] ALUOp;
output reg[3:0] ALUsignal;

always@(funct , ALUOp ,posedge clk)
begin 
	case(ALUOp)
        3'b010:case(funct)
            6'b100000:ALUsignal=4'b00; //add
            6'b100010:ALUsignal=4'b01; //sub
            6'b100100:ALUsignal=4'b10; //and
            6'b100101:ALUsignal=4'b11; //or
            6'b101010:ALUsignal=4'b101; //stl
        endcase 

        3'b001:ALUsignal=4'b0001; //branch
        3'b000:ALUsignal=4'b0000; //Lw and sw
        3'b011:ALUsignal=4'b0010; //andi
        3'b100:ALUsignal=4'b0011; //ori
        3'b111:ALUsignal=4'b0101; //slti
    endcase
end
endmodule

// testbench for this module
// module ALUcontrol_tb();
// reg clk;
// reg[5:0] funct;
// reg[2:0] ALUOp;
// wire[3:0] ALUsignal;
// ALUcontrol ALUcontrol1(clk,funct,ALUOp,ALUsignal);

// initial begin
//     $dumpfile("ALUcontrol.vcd");
//     $dumpvars(0,ALUcontrol1);

//     clk=1'b0;
//     funct=6'b100000;
//     ALUOp=3'b010;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 funct=6'b100010;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 funct=6'b100100;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 funct=6'b100101;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 funct=6'b101010;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 ALUOp=3'b001;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 ALUOp=3'b000;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 ALUOp=3'b011;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 ALUOp=3'b100;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     #10 ALUOp=3'b111;
//     #10 clk=1'b1;
//     #10 clk=1'b0;
//     $finish;

// end
// endmodule
