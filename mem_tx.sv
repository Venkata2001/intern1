class mem_tx extends uvm_sequence_item;
rand bit wr_rd;
rand bit[`WIDTH-1:0]wdata_i;
 bit[`WIDTH-1:0]rdata_i;
rand bit[`ADDR_WIDTH-1:0]addr_i;

`uvm_object_utils_begin(mem_tx)  //==> registering mem_tx class to the factory // we can use mem_tx anywherein the testbench
	`uvm_field_int(addr_i,UVM_ALL_ON | UVM_NOPACK)
	`uvm_field_int(wdata_i,UVM_ALL_ON | UVM_NOPACK)
	`uvm_field_int(rdata_i,UVM_ALL_ON | UVM_NOPACK)
	`uvm_field_int(wr_rd,UVM_ALL_ON | UVM_NOPACK)
	//bec of this print, copy, compare, pack, unpack methods get updated automatically
	// these variables can be accessed by using uvm_config_db and can be used to update the component dehavior.
`uvm_object_utils_end

`NEW_OBJ

endclass

//`uvm_field_int(addr, UVM_DEFAULT) //==>addr field to factory
//`uvm_field_string() //==> string type of is register to factory
//`uvm_field_queue()
//`uvm_field_array()

//UVM_ALL_ON=> it will update all the methods
//UVM_NO_PACK=>it will not update the pack method
