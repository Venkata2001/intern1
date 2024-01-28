interface mem_intf(input reg clk_i, input reg rst_i);
logic [`ADDR_WIDTH-1:0]addr_i;
logic [`WIDTH-1:0]wdata_i;
logic [`WIDTH-1:0]rdata_o;
logic ready_o,wr_rd,valid_i;

clocking drv_cb@(posedge clk_i);
	default input #0 output #1;
		input rdata_o,ready_o;
		output addr_i,wdata_i,wr_rd,valid_i;
endclocking

clocking mon_cb@(posedge clk_i);
	default input #1;
		input rdata_o,wr_rd,wdata_i,valid_i,addr_i,ready_o;
endclocking
endinterface
