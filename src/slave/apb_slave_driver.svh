/*--------------------------------------------------------------
 *  File Name 	: apb_slave_driver.svh
 *  Title 		: APB slave drive class 	
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

class apb_slave_driver extends uvm_driver#(apb_slave_seq_item);
	`uvm_component_utils(apb_slave_driver)
	
	virtual apb_if 			vif;
	apb_slave_seq_item 		m_apb_slave_seq_item;
		
	
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------	
	extern function new(string name = "apb_slave_driver", uvm_component parent = null);
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	extern virtual task wait_for_reset();
	extern virtual task get_and_drive();
	extern virtual task init_signals();
endclass

// Function: new
// Definition: class constructor
function apb_slave_driver::new(string name = "apb_slave_driver", uvm_component parent = null);
	super.new(name, parent);
endfunction: new	

// Function: build_phase
// Definition: standard uvm_phase
function void apb_slave_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", vif)) begin
		`uvm_fatal(get_full_name(), "No virtual interface specified for apb_slave_driver")
	end 
endfunction: build_phase	
	
// Task: run_phase
// Definition: standard uvm_phase		
task apb_slave_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);
	
	init_signals();
	wait_for_reset();
	get_and_drive();
			
endtask
	
// Task: get_and_drive
// Definition:	this task call drive signals.
task apb_slave_driver::get_and_drive();
	forever begin
		m_apb_slave_seq_item = apb_slave_seq_item::type_id::create("m_apb_slave_seq_item",this);
		
		seq_item_port.get_next_item(m_apb_slave_seq_item);
		
		wait(vif.slave.PSEL)
		
		vif.slave.PREADY <= 1;
		
		repeat(m_apb_slave_seq_item.delay)
			@(posedge vif.PCLK);		
		
		if(!vif.slave.PWRITE)
			vif.slave.PRDATA <= m_apb_slave_seq_item.data;
		
		@ (posedge vif.PCLK);
		vif.slave.PREADY <= 0;		
		
		seq_item_port.item_done();
		`uvm_info("apb_slave_driver", "finish drive", UVM_LOW)
	end				
endtask
	


// Task: wait_for_reset
// Description: This class is used to wait reset signal.
task apb_slave_driver::wait_for_reset ();
	wait(!vif.PRESET_N);	
endtask
	
// Task: init_signals
// Description: This class is used give initial value to apb slave signals.	
task apb_slave_driver::init_signals();
	vif.slave.PREADY  <= 0;	
endtask		