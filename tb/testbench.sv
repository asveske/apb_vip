/*--------------------------------------------------------------
 *  File Name 	: testbench.sv
 *  Title 		: APB testbench 	
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
 `timescale 1ns/1ns
 
import uvm_pkg::*;
`include "uvm_macros.svh"

 import apb_master_pkg::*;
 import apb_slave_pkg::*;
 `include "apb_test.svh"
 
module testbench;
	logic pclk;
	logic presetn;
	
  
	logic [31:0] paddr;
	logic        psel;
	logic        penable;
	logic        pwrite;
	logic [31:0] prdata;
	logic [31:0] pwdata;

	initial begin
		pclk=0;
	end
	
	initial begin
		presetn=1; 
		#40; 
		presetn=0;
	end	

	//Generate a clock
	always begin
		#10 pclk = ~pclk;
	end	
	
	// apb interface
	apb_if  apb_if(pclk,presetn);
  
	initial begin
		uvm_config_db#(virtual apb_if)::set( null, "", "apb_vif", apb_if);
		run_test("apb_test");
	end
	
endmodule


