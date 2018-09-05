/*--------------------------------------------------------------
 *  File Name 	: apb_slave_seq_item.sv
 *  Title 		: APB slave transaction item class	
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

`ifndef _APB_SLAVE_SEQ_ITEM_
`define _APB_SLAVE_SEQ_ITEM_

class apb_slave_seq_item extends apb_base_seq_item;
	`uvm_object_utils(apb_slave_seq_item)
	
	
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new (string name = "apb_slave_seq_item");	
	extern function string convert2string();
endclass

// Function: new
// Definition: class constructor
function apb_slave_seq_item::new (string name = "apb_slave_seq_item");
	super.new(name);
endfunction : new

// Function: convert2string
// Definition: this function is used to show apb_master transaction.
function string apb_slave_seq_item::convert2string();
	return $psprintf("\n \
-------------------------APB_SLAVE_TRANSFER------------------------- \n \
DIR.=%s \n \
ADDR=%0h \n \
DATA=%0h \n \
--------------------------------------------------------------",apb_tr,addr,data);
endfunction : convert2string

`endif