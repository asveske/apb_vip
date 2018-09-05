/*--------------------------------------------------------------
 *  File Name 	: apb_sequencer.svh
 *  Title 		: APB slave sequencer class 	
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

class apb_slave_sequencer extends uvm_sequencer#(apb_slave_seq_item);

	`uvm_component_utils(apb_slave_sequencer)

	function new(string name = "apb_slave_sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction


endclass


