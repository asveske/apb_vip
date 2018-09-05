/*--------------------------------------------------------------
 *  File Name 	: apb_if.sv
 *  Title 		: APB interface
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
`ifndef _APB_IF_
`define _APB_IF_
	
`include "apb_defines.svh"
interface apb_if(input bit PCLK, PRESET_N);
	
	logic [`ADDR_WIDTH-1:0] PADDR;
	logic [`DATA_WIDTH-1:0] PWDATA;
	logic [`DATA_WIDTH-1:0] PRDATA;
	
	logic 		PSEL;
	logic 		PENABLE;
	logic 		PWRITE;
	logic 		PREADY;
	
	
	clocking master_cb @(posedge PCLK);
		output PADDR, PSEL, PENABLE, PWRITE, PWDATA;
		input  PRDATA, PREADY;
	endclocking: master_cb
	
	
	clocking slave_cb @(posedge PCLK);
		input  PADDR, PSEL, PENABLE, PWRITE, PWDATA;
		output PRDATA, PREADY;
	endclocking: slave_cb
	
	modport master(	input  PRDATA, PREADY,PRESET_N,
					output PADDR, PSEL, PENABLE, PWRITE, PWDATA	);
	
	modport slave(	input  PADDR, PSEL, PENABLE, PWRITE, PWDATA,PRESET_N,
					output PRDATA, PREADY);
	
	
	`define IDLE   (!PSEL & !PENABLE)
	`define SETUP  ( PSEL & !PENABLE)
	`define ACCESS ( PSEL &  PENABLE)
	
	
	//----------------------------------------------------
	// Check protocol properties
	//----------------------------------------------------	
	
	sequence idle_phase;
		(!PSEL & !PENABLE);
	endsequence
	
	sequence setup_phase;
		( PSEL & !PENABLE);
	endsequence
	
	sequence access_phase;
		( PSEL &  PENABLE);
	endsequence	
		
	property psel_valid;
		@(posedge PCLK) disable iff (PRESET_N == 1'b0)
			 !$isunknown(PSEL);
	endproperty: psel_valid

	assert property(psel_valid);
	cover property(psel_valid);
		
		 
	property setup_to_stable_1;
		@(posedge PCLK) disable iff (PRESET_N)
			setup_phase |=> $stable(PADDR);
	endproperty
	
	assert property (setup_to_stable_1)
	else $display("setup_to_stable_1", "Assertion failed");		
	
	property setup_to_stable_2;
		@(posedge PCLK) disable iff (PRESET_N)
			setup_phase |=> $stable(PWDATA);
	endproperty
	
	assert property (setup_to_stable_2)
	else $display("setup_to_stable_2", "Assertion failed");		
	
	
	property setup_to_stable_3;
		@(posedge PCLK) disable iff (PRESET_N)
			setup_phase |=> $stable(PSEL);
	endproperty
	
	assert property (setup_to_stable_3)
	else $display("setup_to_stable_3", "Assertion failed");	
		
	
	property write_transfer;
		@(posedge PCLK) disable iff (PRESET_N)
			(PSEL & PWRITE & PENABLE) |-> ($stable(PWDATA) and ##[1: $] $fell(PENABLE));
	endproperty	
	
	assert property (write_transfer)
	else $display("write_transfer", "Assertion failed");		
	
	
	property read_transfer;
		@( PCLK) disable iff (PRESET_N)
			PSEL & !PWRITE & PENABLE & PREADY & $changed(PRDATA) |-> $rose(PCLK)
	endproperty
	
	assert property (read_transfer)
	else $display("read_transfer", "Assertion failed");			
	
	
endinterface

`endif


