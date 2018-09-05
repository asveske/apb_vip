/*--------------------------------------------------------------
 *  File Name 	: apb_slave_pkg.sv
 *  Title 		: This file contoins UVCs for APB slave. 	  	
 *  Author		: sefaveske@gmail.com	
 *  Date		: 08/19/2018
 *  
 *
 * CO - Confidential and Proprietary of ASV.
 * Copyright (C) 2017 by ASV. All Rights Reserved.
 *
 *               ##     ####   #    #
 *              #  #   #       #    #
 *             #    #   ####   #    #
 *             ######       #  #    #
 *             #    #  #    #   #  #
 *             #    #   ####     ##
 *
 *
 * ------------------------------------------------------------*/

`ifndef _APB_SLAVE_PKG_
`define _APN_SLAVE_PKG_
	
package apb_slave_pkg;

	import uvm_pkg::*;
	import apb_common_pkg::*;
	`include "uvm_macros.svh"
	`include "apb_defines.svh"
	`include "apb_slave_config.svh"
	`include "apb_slave_seq_item.svh"
	`include "apb_slave_seq.svh"
	`include "apb_slave_sequencer.svh"
	`include "apb_slave_driver.svh"
	`include "apb_slave_monitor.svh"
	`include "apb_slave_agent.svh"
endpackage

`endif
