/*--------------------------------------------------------------
 *  File Name 	: apb_test.svh
 *  Title 		: Default APB test (rd, wr) 	
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


`ifndef _APB_TEST_
`define _APB_TEST_

import uvm_pkg::*;
`include "uvm_macros.svh"

import apb_master_pkg::*;
import apb_slave_pkg::*;
`include "apb_env.svh"

class apb_test extends uvm_test;

	//Register with factory
	`uvm_component_utils(apb_test)
  
	apb_env  env;
	
	// configuration object
	apb_master_config 	m_apb_master_config;
	apb_slave_config 	m_apb_slave_config;
	
	virtual apb_if vif;
		
	apb_master_seq master_seq;
	apb_slave_seq  slave_seq;	
  
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new(string name = "apb_test", uvm_component parent = null );
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);  


endclass

// Function: new
// Definition: class constructor
function apb_test::new(string name = "apb_test", uvm_component parent = null);
	super.new(name, parent);
endfunction

// Function: build_phase
// Definition: standard uvm_phase
function void apb_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	env = apb_env::type_id::create("env", this);
	
	m_apb_master_config = apb_master_config::type_id::create("m_apb_master_config"); 		
	m_apb_slave_config  = apb_slave_config::type_id::create("m_apb_slave_config"); 		
		
	uvm_config_db#(apb_master_config)::set(null, "","apb_master_config", m_apb_master_config);
	uvm_config_db#(apb_slave_config)::set(null, "" ,"apb_slave_config", m_apb_slave_config);
	
	if (!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", vif)) begin
		`uvm_fatal(get_full_name(), "No virtual interface specified for this test instance")
	end 
endfunction

// Task: run_phase
// Definition: standard uvm_phase	
task apb_test::run_phase( uvm_phase phase );
	super.run_phase(phase);
	
	master_seq = apb_master_seq::type_id::create("master_seq");
	slave_seq = apb_slave_seq::type_id::create("slave_seq");
		
	phase.raise_objection( this, "Starting apb_test run phase" );
	
	repeat(10) begin
		this.randomize();
		fork
			master_seq.start(env.master_agent.m_sequencer);
			slave_seq.start(env.slave_agent.m_sequencer);	
		join
	end
	
	#100ns;
	phase.drop_objection( this , "Finished apb_test in run phase" );
endtask: run_phase	

`endif
