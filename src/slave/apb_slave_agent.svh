/*--------------------------------------------------------------
 *  File Name 	: apb_slave_agent.svh
 *  Title 		: APB slave agent class 	
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

`ifndef _APB_SLAVE_AGENT_
`define _APB_SLAVE_AGENT_

class apb_slave_agent extends uvm_agent;
	`uvm_component_utils(apb_slave_agent)

	
	// Configuration member
	apb_slave_config m_cfg;		
	
	//--------------------------------------------------------------------
	//	Component Members
	//--------------------------------------------------------------------	
	apb_slave_seq_item 							m_apb_slave_seq_item;
	apb_slave_driver  							m_apb_slave_driver;
	apb_slave_seq								m_apb_slave_seq;
	apb_slave_sequencer							m_sequencer;
	apb_slave_monitor							m_apb_slave_monitor;
	
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new(string name = "apb_slave_agent", uvm_component parent );
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);
endclass

// Function: new
// Definition: class constructor
function apb_slave_agent::new(string name = "apb_slave_agent", uvm_component parent);
	super.new(name, parent);
endfunction: new

// Function: build_phase
// Definition: standard uvm_phase
function void apb_slave_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	// get configuration object
	if (m_cfg == null) begin
		if (!uvm_config_db#(apb_slave_config)::get(this, "", "apb_slave_config", m_cfg))
			`uvm_warning(get_full_name(), "Config not set for slave agent, using default is_active field")
	end	
	
	m_apb_slave_seq_item		= apb_slave_seq_item::type_id::create("m_apb_slave_seq_item");
	m_apb_slave_seq				= apb_slave_seq::type_id::create("m_apb_slave_seq");	
	m_apb_slave_monitor			= apb_slave_monitor::type_id::create("m_apb_slave_monitor",this);

	if(m_cfg.is_active == UVM_ACTIVE) begin
		m_apb_slave_driver		= apb_slave_driver::type_id::create("m_apb_slave_driver",this);
		m_sequencer 			= apb_slave_sequencer::type_id::create("m_sequencer",this); 
	end	
	
endfunction: build_phase

// Function: connect_phase
// Definition: standard uvm_phase
function void apb_slave_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	
	if(m_cfg.is_active == UVM_ACTIVE) begin
		m_apb_slave_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	end	
	
endfunction	

`endif
