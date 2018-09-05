/*--------------------------------------------------------------
 *  File Name 	: apb_slave_monitor.svh
 *  Title 		: APB slave monitor class 	
 *  Author		: sefaveske@gmail.com	
 *  Date		: 08/19/2018
 *
 *               ##     ####   #    #
 *              #  #   #       #    #
 *             #    #   ####   #    #
 *             ######       #  #    #
 *             #    #  #    #   #  #
 *             #    #   ####     ##
 * ------------------------------------------------------------*/

`ifndef _APB_SLAVE_MONITOR_
`define _APB_SLAVE_MONITOR_

class apb_slave_monitor extends uvm_monitor;
	`uvm_component_utils(apb_slave_monitor)

	virtual apb_if vif;
	uvm_analysis_port#(apb_slave_seq_item) ap;

	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new(string name , uvm_component parent );
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
endclass

// Function: new
// Definition: class constructor
function apb_slave_monitor::new(string name, uvm_component parent);
	super.new(name, parent);
	ap = new("ap", this);
endfunction: new

// Function: build_phase
// Definition: standard uvm_phase	
function void apb_slave_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
		
	if (!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", vif)) begin
		`uvm_fatal(get_full_name(), "No virtual interface specified for apb_slave_driver")
	end 
endfunction: build_phase

// Task: run_phase
// Definition: standard uvm_phase
task apb_slave_monitor::run_phase(uvm_phase phase);
		
	forever begin
		apb_slave_seq_item tr;
	
		wait (vif.slave.PSEL === 1'b1);
		
		tr = apb_slave_seq_item::type_id::create("tr", this);
    	tr.apb_tr = (this.vif.slave.PWRITE) ? apb_slave_seq_item::WRITE : apb_slave_seq_item::READ;
		tr.addr = this.vif.slave.PADDR;

		@ (posedge vif.PCLK);
		wait (this.vif.slave.PENABLE === 1'b1 && this.vif.slave.PREADY === 1'b1);
			
		if(this.vif.master.PWRITE)
			tr.data = this.vif.master.PWDATA; 
		else 
			tr.data = this.vif.master.PRDATA;			
			
		wait  (this.vif.slave.PENABLE === 1'b0)
		uvm_report_info("APB_SLAVE_MONITOR", $psprintf("%s",tr.convert2string()));
		
		ap.write(tr);
	end
endtask	

`endif
