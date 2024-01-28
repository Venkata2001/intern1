class mem_cov extends uvm_subscriber#(mem_tx);
mem_tx tx;
`uvm_component_utils(mem_cov)

covergroup mem_cg();
	ADDR:coverpoint tx.addr_i{
		option.auto_bin_max=3;
	}
	WR_RD:coverpoint tx.wr_rd{
		bins WR={1'b1};
		bins RD={1'b0};
	}
	ADDR_CROSS_WR_RD: cross ADDR,WR_RD;
endgroup

function new(string name, uvm_component parent);
	super.new(name,parent);
	mem_cg=new();
endfunction

 
function void write(mem_tx t);
	this.tx=t;
	mem_cg.sample();
endfunction

endclass
