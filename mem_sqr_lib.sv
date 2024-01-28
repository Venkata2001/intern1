class mem_wr_rd_seq extends uvm_sequencer#(mem_tx)
mem_tx tx;
`uvm_object_utlis(mem_wr_rd_seq)
`NEW_OBJ
task body();
	//write the data
	`uvm_do_with(req, {req.wr_rd==1;});
	//this line ==
	//assert(tx.randomize() with {tx.wr_rd==1});
	//mbox.put(tx)
	$cast(tx,req);
	`uvm_do_with(req, {req.wr_rd=0, req.addr_i=tx.addr_i;});
endtask
endclass
