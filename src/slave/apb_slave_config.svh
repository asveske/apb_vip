/*--------------------------------------------------------------
 *  File Name 	: apb_slave_config.svh
 *  Title 		: Configuration class for APB slave 	
 *  Author		: sefaveske@gmail.com	
 *  Date		: 08/29/2018
 *
 *               ##     ####   #    #
 *              #  #   #       #    #
 *             #    #   ####   #    #
 *             ######       #  #    #
 *             #    #  #    #   #  #
 *             #    #   ####     ##
 * ------------------------------------------------------------*/
`ifndef _APB_SLAVE_CONFIG_
`define _APB_SLAVE_CONFIG_
	
class apb_slave_config extends uvm_object;
	`uvm_object_utils(apb_slave_config)
	
	//--------------------------------------------------------------------
	//	Data Members
	//--------------------------------------------------------------------	
	rand uvm_active_passive_enum is_active = UVM_ACTIVE;
	bit has_functional_coverage = 0;
	bit has_scoreboard = 0;	
	
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------x
	extern function new (string name = "apb_slave_config");
endclass
`endif

// Function: new
// Definition: class constructor
function apb_slave_config::new (string name = "apb_slave_config");
	super.new(name);
endfunction	