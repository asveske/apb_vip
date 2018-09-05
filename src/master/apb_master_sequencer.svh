/*--------------------------------------------------------------
 *  File Name 	: apb_sequencer.svh
 *  Title 		: APB master sequencer class 	
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

class apb_master_sequencer extends uvm_sequencer#(apb_master_seq_item);

	`uvm_component_utils(apb_master_sequencer)

	function new(string name = "apb_master_sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction


endclass


