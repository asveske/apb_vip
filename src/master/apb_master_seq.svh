/*--------------------------------------------------------------
 *  File Name 	: apb_master_seq.svh
 *  Title 		: APB master default sequence (write and read tr.) 	
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

`ifndef _APB_MASTER_SEQ_
`define _APB_MASTER_SEQ_

class apb_master_seq extends uvm_sequence#(apb_master_seq_item);

	`uvm_object_utils(apb_master_seq)

	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new (string name = "apb_master_seq");
	extern task body();
endclass

// Function: new
// Definition: class constructor	
function apb_master_seq::new(string name ="apb_master_seq");
	super.new(name);
endfunction

// Function: body
// Definition: body method that gets executed once sequence is started 
task apb_master_seq::body();
	apb_master_seq_item m_apb_master_seq_item;
	
	repeat(1) begin
		m_apb_master_seq_item = apb_master_seq_item::type_id::create("m_apb_master_seq_item");
		start_item(m_apb_master_seq_item);
		assert (m_apb_master_seq_item.randomize());
		finish_item(m_apb_master_seq_item);
	end
endtask
	
`endif
