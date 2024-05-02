module IMemBank(input memread, input [31:0] address, output reg [31:0] readdata, input clk);
 
  reg [31:0] mem_array [255:0];
  reg [31:0]temp;
  integer i;
  initial begin
    for (i=11; i<255; i=i+1)   
	begin
       	mem_array[i]=32'b0;
	end
  end

  initial begin
    mem_array[0] = 32'h88C220002;
    mem_array[4] = 32'h8C810004;
    mem_array[8] = 32'h00653022;
    mem_array[12] = 32'h00E64026;
    mem_array[16] = 32'h35490016;

  end
  always@(posedge clk)
  begin
    if(memread)begin
    readdata=mem_array[address];
    end
  end
  endmodule

