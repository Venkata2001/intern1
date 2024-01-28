`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "memory.v"
`include "mem_com.sv"
`include "mem_tx.sv"
`include "mem_seq_lib.sv"
`include "mem_drv.sv"
`include "mem_sqr.sv"
`include "mem_mon.sv"
`include "mem_cov.sv"
`include "mem_agent.sv"
`include "mem_sbd.sv"
`include "mem_env.sv"
`include "mem_intf.sv"
`include "mem_test.sv"


module top;
reg clk_i,rst_i;

mem_intf pif(.clk_i(clk_i),.rst_i(rst_i));

memory dut(.clk_i(pif.clk_i),
			.rst_i(pif.rst_i),
			.valid_i(pif.valid_i),
			.addr_i(pif.addr_i),
			.wdata_i(pif.wdata_i),
			.wr_rd_en_i(pif.wr_rd),
			.ready_o(pif.ready_o),
			.rdata_o(pif.rdata_o)
			);


initial begin
	clk_i=0;
	forever #5 clk_i=~clk_i;
end

initial begin
	rst_i=1;
	repeat(2)@(posedge clk_i);
	rst_i=0;
end
initial begin
	run_test("mem_test");// it will the test in class mem_test
end

initial begin
	//virtual intf
	uvm_resource_db#(virtual mem_intf)::set("GLOBAL","APB_VIF",pif,null);
	//count
	uvm_resource_db#(int)::set("GLOBAL","COUNT",mem_com::total_tx_count,null);
end
//initial begin
//	#700 $finish;
//end

endmodule
