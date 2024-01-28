class mem_sbd extends uvm_scoreboard;
uvm_analysis_imp#(mem_tx,mem_sbd) imp_mem;
bit [`WIDTH-1:0] mem[int];
`uvm_component_utils(mem_sbd)
`NEW_COM
function void build_phase(uvm_phase phase);
	imp_mem=new("imp_mem",this);
endfunction

function void write(mem_tx tx);
	if(tx.wr_rd==1)begin
		mem[tx.addr_i] = tx.wdata_i; //storing the data in to memeory
	end
	else begin
		if(tx.wdata_i== mem[tx.addr_i])begin//comparing during the read operation
		$display("in sda write address=%h, data=%h", tx.addr_i,tx.wdata_i);
		$display("mem=%p",mem);
			mem_com::num_matches++;
		$display("data matched");
		end
		else begin
			$display("in sbd write mem data=%h",mem[tx.addr_i]);
			$display("in sda write address=%h, data=%h", tx.addr_i,tx.wdata_i);
			$display("mem=%p",mem);
			mem_com::num_mis_matches++;
			//`uvm_info("mem",$psprintf("mem=%p",mem),UVM_HIGH)
			`uvm_error("SBD",$psprintf("sbd data doesn't match read data, sbd data=%h, mem data=%h",mem[tx.addr_i],tx.wdata_i));
		end
	end
endfunction
endclass
