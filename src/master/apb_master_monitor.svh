/*--------------------------------------------------------------
 *  File Name 	: apb_master_monitor.svh
 *  Title 		: APB master monitor class 
 *  Author		: sefaveske@gmail.com	
 *  Date		: 08/19/2018
 *  
 *
 *               ##     ####   #    #
 *              #  #   #       #    #
 *             #    #   ####   #    #
 *             ######       #  #    #
 *             #    #  #    #   #  #
 *             #    #   ####     ##
 * ------------------------------------------------------------*/

`ifndef _APB_MASTER_MONITOR_
`define _APB_MASTER_MONITOR_

class apb_master_monitor extends uvm_monitor;
	`uvm_component_utils(apb_master_monitor)

	virtual apb_if vif;
	uvm_analysis_port#(apb_master_seq_item) ap;
	
	apb_master_seq_item tr;
	
	//------------------------------------------
	// Cover Group(s)
	//------------------------------------------
	covergroup apb_cov;
		OPCODE: coverpoint tr.apb_tr {
			bins WRITE = {1};
			bins READ = {0};
		}
	endgroup	
	
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new(string name , uvm_component parent );
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
endclass


// Function: new
// Definition: class constructor
function apb_master_monitor::new(string name, uvm_component parent);
	super.new(name, parent);
	ap = new("ap", this);
	apb_cov = new();
endfunction: new

// Function: build_phase
// Definition: standard uvm_phase
function void apb_master_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", vif)) begin
		`uvm_fatal(get_full_name(), "No virtual interface specified for apb_master_driver")
	end 
		
endfunction: build_phase

// Task: run_phase
// Definition: standard uvm_phase	
task apb_master_monitor::run_phase(uvm_phase phase);
		
	forever begin
		wait (vif.master.PSEL === 1'b1);
		
		tr = apb_master_seq_item::type_id::create("tr", this);
        tr.apb_tr = (this.vif.master.PWRITE) ? apb_master_seq_item::WRITE : apb_master_seq_item::READ;
		tr.addr = this.vif.master.PADDR;
		
		@ (posedge vif.PCLK);
		wait (this.vif.master.PENABLE === 1'b1 && this.vif.master.PREADY === 1'b1);
		
		if(this.vif.master.PWRITE) 	
			tr.data = this.vif.master.PWDATA; 
		else 
			tr.data = this.vif.master.PRDATA;
		
		wait  (this.vif.master.PENABLE === 1'b0)
		uvm_report_info("APB_MASTER_MONITOR", $psprintf("%s",tr.convert2string()));
		
		apb_cov.sample();
		ap.write(tr);
		
	end
endtask	


`endif