/*--------------------------------------------------------------
 *  File Name 	: apb_common_pkg.sv
 *  Title 		: This file contains common UVCs for APB master and slave 	
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

`ifndef _APB_COMMON_PKG_
`define _APB_COMMON_PKG_
	
package apb_common_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "apb_defines.svh"
	`include "apb_base_seq_item.svh"
endpackage

`endif

