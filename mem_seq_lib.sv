class mem_base_seq extends uvm_sequence#(mem_tx);

uvm_phase phase;
`uvm_object_utils(mem_base_seq)
`NEW_OBJ
task pre_body();
	phase = get_starting_phase();
	if (phase != null)begin
		phase.phase_done.set_drain_time(this,200);
		phase.raise_objection(this);
	end
endtask

task post_body();
	if (phase != null)
		phase.drop_objection(this);
endtask
endclass
class mem_wr_rd_seq extends mem_base_seq;
mem_tx tx;
uvm_phase phase;
`uvm_object_utils(mem_wr_rd_seq)
`NEW_OBJ

task body();
	//write the data
	//object con't have phase only components have phases
	//so we can use starting_phase
	`uvm_do_with(req, {req.wr_rd==1;});

	$cast(tx,req);
	//read data
	`uvm_do_with(req, {req.wr_rd==0; req.addr_i==tx.addr_i;});
endtask
endclass

class mem_n_wr_n_rd_seq extends mem_base_seq;
mem_tx tx;
mem_tx txq[$];
`uvm_object_utils(mem_n_wr_n_rd_seq)
`NEW_OBJ

task body();
	int count;
	uvm_resource_db#(int)::read_by_name("GLOBAL","COUNT",count,null);
	repeat(count)begin
		//write the data
		`uvm_do_with(req, {req.wr_rd==1;});
		$cast(tx,req);
		txq.push_back(tx);
	end

	repeat(count)begin
		//read data
		tx=txq.pop_front();
		`uvm_do_with(req, {req.wr_rd==0; req.addr_i==tx.addr_i;});
	end
endtask
endclass

