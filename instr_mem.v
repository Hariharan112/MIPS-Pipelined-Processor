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
  always@(posedge clk)
  begin
    if(memread)begin
      temp = address>>2;
      readdata = mem_array[temp];
    end
  end
  endmodule

