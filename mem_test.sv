class mem_base_test extends uvm_test;//1

mem_env env;//2 //it is common for all test so keep it in base test

`uvm_component_utils(mem_base_test)//3

`NEW_COM //4
//function new(string name,uvm_component parent);//4
//	super.new(name,parent);
//endfunction

function void build_phase(uvm_phase phase);
	env=mem_env::type_id::create("env",this);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
	//prints the test bench topology
endfunction

function void report_phase(uvm_phase phase);
	if(mem_com::num_matches== mem_com::total_tx_count && mem_com::num_mis_matches==0)begin
		`uvm_info("STATUS", "Test passed", UVM_NONE)
	end
	else begin
		`uvm_error("STATUS", "Test failed")
	end
endfunction

endclass

class mem_wr_rd_test extends mem_base_test;
`uvm_component_utils(mem_wr_rd_test)
`NEW_COM
task run_phase(uvm_phase phase);
	mem_wr_rd_seq wr_rd_seq;
	wr_rd_seq=mem_wr_rd_seq::type_id::create("wr_rd_seq");
	phase.raise_objection(this);
	wr_rd_seq.start(env.agent.sqr);
	//#100;
	phase.drop_objection(this);
endtask

endclass


class mem_n_wr_n_rd_test extends mem_base_test;
`uvm_component_utils(mem_n_wr_n_rd_test)
`NEW_COM
task run_phase(uvm_phase phase);
	mem_n_wr_n_rd_seq wr_rd_seq;
	wr_rd_seq=mem_n_wr_n_rd_seq::type_id::create("wr_rd_seq");
	phase.raise_objection(this);
	wr_rd_seq.start(env.agent.sqr);
	//#100;
	phase.drop_objection(this);
endtask

endclass

class mem_n_wr_n_rd_build_test extends mem_base_test;
`uvm_component_utils(mem_n_wr_n_rd_build_test);
`NEW_COM

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_db#(uvm_object_wrapper)::set(this,"env.agent.sqr.run_phase", "default_sequence",mem_n_wr_n_rd_seq::get_type());
	//it won't work on the keys
	//default_sequence---> when use doesn't call seq.start(sqr_path), the uvm by default run default_sequence
	//
endfunction
endclass
