//Memory of 1Kb having a width of 16bits
//Size=1Kb=1*1024=1024
//Width=16
//Depth=64
//Addr_width=$clog2(Depth)=6
//Input: clk,reset,valid,addr,wdata,wr_rd
//output:ready,rdata

module memory(clk_i,rst_i,valid_i,addr_i,wdata_i,wr_rd_en_i,ready_o,rdata_o);

parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WIDTH=$clog2(DEPTH);

input clk_i;
input rst_i;
input valid_i;
input [ADDR_WIDTH-1:0]addr_i;
input [WIDTH-1:0]wdata_i;
input wr_rd_en_i;

output reg ready_o;
output reg [WIDTH-1:0]rdata_o;

integer i;

reg [WIDTH-1:0]mem[DEPTH-1:0];

always@(posedge clk_i)begin
	if(rst_i==1)begin	//Here we are using active high reset ,so we are making all my register to zero.(deassering) at reset=1
		ready_o=0;	//Deasserting ready register
		rdata_o=0; //Deasserting rdata register
		for(i=0;i<DEPTH;i=i+1) mem[i]=0; //Deasserting Memory
	end
	else begin
		if(valid_i==1)begin	//Master is doing valid transaction
			ready_o=1;	//slave is ready to do valid transaction
			if(wr_rd_en_i==1)	mem[addr_i]=wdata_i;	// writing to the memory
			else 			rdata_o=mem[addr_i];	// read from the memory
		end
		else ready_o=0;	// master is not doing valid transaction so slave will won't shakehand.
	end
end
endmodule
