/*--------------------------------------------------------------
 *  File Name 	: apb_master_driver.svh
 *  Title 		: APB master driver class 	
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

class apb_master_driver extends uvm_driver#(apb_master_seq_item);
	`uvm_component_utils(apb_master_driver)
	
	virtual apb_if 			vif;
	apb_master_seq_item 	m_apb_master_seq_item;
		
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------	
	extern function new(string name = "apb_master_driver", uvm_component parent = null);
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	extern virtual task wait_for_reset();
	extern virtual task get_and_drive();
	extern virtual task init_signals();
endclass

// Function: new
// Definition: class constructor
function apb_master_driver::new(string name = "apb_master_driver", uvm_component parent = null);
	super.new(name, parent);
endfunction: new	
	
// Function: build_phase
// Definition: standard uvm_phase
function void apb_master_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", vif)) begin
		`uvm_fatal(get_full_name(), "No virtual interface specified for apb_master_driver")
	end 
	
endfunction: build_phase	
	
// Task: run_phase
// Definition: standard uvm_phase	
task apb_master_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);
			
	init_signals();
	wait_for_reset();
	get_and_drive();
	
endtask
	
// Task: get_and_drive
// Definition: this task select the transfer type
task apb_master_driver::get_and_drive();
	
	forever begin
		m_apb_master_seq_item = apb_master_seq_item::type_id::create("m_apb_master_seq_item",this);
		
		seq_item_port.get_next_item(m_apb_master_seq_item);
		
		repeat(m_apb_master_seq_item.delay)
			@(posedge vif.PCLK);
		
		vif.master.PSEL    <= 1'b1;
		vif.master.PADDR   <= m_apb_master_seq_item.addr;
		vif.master.PWRITE  <= m_apb_master_seq_item.apb_tr;
		
		if(m_apb_master_seq_item.apb_tr == apb_master_seq_item::WRITE)
			vif.master.PWDATA  <= m_apb_master_seq_item.data;
		
		@ (posedge vif.PCLK);
		vif.master.PENABLE <= '1;
		
		wait(vif.master.PREADY);	
		
		@ (posedge vif.PCLK);
		vif.master.PSEL    <= '0;
		vif.master.PENABLE <= '0;		
		
		uvm_report_info("APB_MASTER_DRIVER ", $psprintf(" %s",m_apb_master_seq_item.convert2string()));
		seq_item_port.item_done();
	end		
		
endtask


// Task: wait_for_reset
// Description: This class is used to wait reset signal.
task apb_master_driver::wait_for_reset ();
	wait(!vif.PRESET_N);	
endtask

// Task: init_signals
// Description: This class is used give initial value to apb master signals.
task apb_master_driver::init_signals();
	vif.master.PSEL    	<= 1'b0;
	vif.master.PWRITE   <= 1'b0;
	vif.master.PENABLE  <= 1'b0;
endtask	



