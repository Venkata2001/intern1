`define WIDTH 16
`define DEPTH 64
`define ADDR_WIDTH $clog2(`DEPTH)


`define NEW_COM \
function new(string name, uvm_component parent); \
	super.new(name,parent); \
endfunction

`define NEW_OBJ \
function new(string name=""); \
	super.new(name); \
endfunction

class mem_com;
	static int num_mis_matches;
	static int num_matches;
	static int total_tx_count=1;
endclass
