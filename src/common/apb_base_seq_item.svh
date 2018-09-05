/*--------------------------------------------------------------
 *  File Name 	: apb_base_seq_item.svh
 *  Title 		: This file contains basic transaciton for APB transfer.
 *  Author		: sefaveske@gmail.com	
 *  Date		: 08/20/2018
 *
 *               ##     ####   #    #
 *              #  #   #       #    #
 *             #    #   ####   #    #
 *             ######       #  #    #
 *             #    #  #    #   #  #
 *             #    #   ####     ##
 * ------------------------------------------------------------*/

`ifndef _APB_BASE_SEQ_ITEM_
`define _APB_BASE_SEQ_ITEM_

class apb_base_seq_item extends uvm_sequence_item;
	`uvm_object_utils(apb_base_seq_item)
	
	//typedef for READ/Write transaction type
	typedef enum {READ, WRITE} apb_transfer_direction_t;		
	
	//--------------------------------------------------------------------
	//	Data Members
	//--------------------------------------------------------------------	
	rand bit   [`ADDR_WIDTH-1:0] 	addr;      
 	rand logic [`DATA_WIDTH-1:0] 	data;     
	rand int 						delay;
	rand apb_transfer_direction_t  	apb_tr; 	
	
	// constraint
	constraint c_addr { addr[1:0] == 0; }
	constraint c_delay { delay inside {[1:2]}; }

 
	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------		
	extern function new(string name = "apb_base_seq_item");
endclass

// Function: new
// Definition: class constructor
function apb_base_seq_item::new (string name = "apb_base_seq_item");
	super.new(name);
endfunction

`endif