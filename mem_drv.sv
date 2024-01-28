class mem_drv extends uvm_driver#(mem_tx);
mem_tx tx;
virtual mem_intf vif;
`uvm_component_utils(mem_drv) // component no need to print, copy allthe methods 
`NEW_COM
function void build_phase(uvm_phase phase);
	
	uvm_resource_db#(virtual mem_intf)::read_by_name("GLOBAL","APB_VIF",vif,this);
endfunction

task run_phase(uvm_phase phase);
forever begin
	seq_item_port.get_next_item(req);
	drive_tx(req);
	req.print();
	seq_item_port.item_done();
end
endtask

task drive_tx(mem_tx tx);
	@(vif.drv_cb);
	vif.drv_cb.addr_i<=tx.addr_i;
	if(tx.wr_rd==1) vif.drv_cb.wdata_i<=tx.wdata_i;
	else vif.drv_cb.wr_rd<=0;
	vif.drv_cb.wr_rd<=tx.wr_rd;
	vif.drv_cb.valid_i<=1;
	wait(vif.drv_cb.ready_o==1);
	
	@(vif.drv_cb);
	if(tx.wr_rd==0) begin
		tx.rdata_i=vif.drv_cb.rdata_o;
		tx.wdata_i=vif.drv_cb.wdata_i;
	end
	vif.drv_cb.addr_i<=0;
	vif.drv_cb.wr_rd<=0;
	vif.drv_cb.wdata_i<=0;
	vif.drv_cb.valid_i<=0;
endtask


endclass
