/*--------------------------------------------------------------
 *  File Name 	: apb_master_pkg.sv
 *  Title 		: This file contoins UVCs for APB master. 	 	
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

`ifndef _APB_MASTER_PKG_
`define _APB_MASTER_PKG_

package apb_master_pkg;
 
	import uvm_pkg::*;
	import apb_common_pkg::*;
	`include "uvm_macros.svh"
	`include "apb_defines.svh"
	`include "apb_master_config.svh"
	`include "apb_master_seq_item.svh"
	`include "apb_master_seq.svh"
	`include "apb_master_sequencer.svh"
	`include "apb_master_driver.svh"
	`include "apb_master_monitor.svh"
	`include "apb_master_agent.svh"
	

endpackage

`endif

