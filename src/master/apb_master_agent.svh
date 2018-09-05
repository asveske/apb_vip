/*--------------------------------------------------------------
 *  File Name 	: apb_master_agent.svh
 *  Title 		: APB master agent class 	
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

`ifndef _APB_MASTER_AGENT_
`define _APB_MASTER_AGENT_

class apb_master_agent extends uvm_agent;
	`uvm_component_utils(apb_master_agent)
	
	// Configuration member
	apb_master_config m_cfg;	

	//--------------------------------------------------------------------
	//	Component Members
	//--------------------------------------------------------------------
	apb_master_seq_item 						m_apb_master_seq_item;
	apb_master_driver  							m_apb_master_driver;
	apb_master_seq								m_apb_master_seq;
	apb_master_sequencer 						m_sequencer;
	apb_master_monitor							m_apb_master_monitor;

	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new(string name = "apb_master_agent", uvm_component parent );
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);	
endclass

// Function: new
// Definition: class constructor
function apb_master_agent::new(string name = "apb_master_agent", uvm_component parent);
	super.new(name, parent);
endfunction: new

// Function: build_phase
// Definition: standard uvm_phase
function void apb_master_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	// get configuration object
	if (m_cfg == null) begin
		if (!uvm_config_db#(apb_master_config)::get(this, "*", "apb_master_config", m_cfg))
			`uvm_warning(get_full_name(), "Config not set for master agent, using default is_active field")
	end	
	
	m_apb_master_seq_item		= apb_master_seq_item::type_id::create("m_apb_master_seq_item");
	m_apb_master_seq			= apb_master_seq::type_id::create("m_apb_master_seq");	
	m_apb_master_monitor		= apb_master_monitor::type_id::create("m_apb_master_monitor",this);
	
	if(m_cfg.is_active == UVM_ACTIVE) begin
		m_apb_master_driver		= apb_master_driver::type_id::create("m_apb_master_driver",this);
		m_sequencer 			= apb_master_sequencer::type_id::create("m_sequencer",this); 
	end
endfunction: build_phase

	
// Function: connect_phase
// Definition: standard uvm_phase	
function void apb_master_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	
	if(m_cfg.is_active == UVM_ACTIVE) begin
		m_apb_master_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	end
endfunction	

`endif
