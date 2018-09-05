/*--------------------------------------------------------------
 *  File Name 	: apb_master_config.svh
 *  Title 		: Cofiguration class for APB master. 	
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
`ifndef _APB_MASTER_CONFIG_
`define _APB_MASTER_CONFIG_
	
class apb_master_config extends uvm_object;
	`uvm_object_utils(apb_master_config)
	
	
	//--------------------------------------------------------------------
	//	Data Members
	//--------------------------------------------------------------------	
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	bit has_coverage = 0;
	bit has_scoreboard = 0;	
	
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new (string name = "apb_master_config");
endclass

// Function: new
// Definition: class constructor
function apb_master_config::new (string name = "apb_master_config");
	super.new(name);
endfunction	

`endif
