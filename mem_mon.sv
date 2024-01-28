class mem_mon extends uvm_monitor;
uvm_analysis_port#(mem_tx) ap_port;
mem_tx tx;
virtual mem_intf vif;

`uvm_component_utils(mem_mon)

`NEW_COM

function void build_phase(uvm_phase phase);
	uvm_resource_db#(virtual mem_intf)::read_by_name("GLOBAL","APB_VIF",vif,this);
	ap_port=new("ap_port", this);
endfunction

task run_phase(uvm_phase phase);
	forever begin
		@(vif.mon_cb)
 		if(vif.mon_cb.valid_i && vif.mon_cb.ready_o) begin
			tx=new();
			tx.addr_i=vif.mon_cb.addr_i;
			tx.wr_rd=vif.mon_cb.wr_rd;
			tx.wdata_i=vif.mon_cb.wr_rd ? vif.mon_cb.wdata_i : vif.mon_cb.rdata_o;
			ap_port.write(tx);
		end
			
	end
endtask

endclass
