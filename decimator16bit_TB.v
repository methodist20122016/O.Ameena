`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:06:51 03/15/2022
// Design Name:   decimator16bit
// Module Name:   F:/FPGA/decimator16bit/decimator16bit_TB.v
// Project Name:  decimator16bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: decimator16bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module decimator16bit_TB;

	// Inputs
	reg CLK;
	reg VMOD;
	reg MODE;

	// Outputs
	wire [15:0] Q;
	wire [15:0] timer;
	wire [15:0] count;

	// Instantiate the Unit Under Test (UUT)
	decimator16bit uut (
		.CLK(CLK), 
		.VMOD(VMOD), 
		.MODE(MODE), 
		.Q(Q), 
		.timer(timer), 
		.count(count)
	);

	initial 
	begin
	$monitor($time,"CLK=%b, VMOD=%b, MODE=%b, Q=%b, timer=%b, count=%b",CLK, VMOD, MODE, Q, timer, count);
		// Initialize Inputs
		CLK = 0;
		VMOD = 0;
		MODE = 0;
	end
   
always #5 CLK=~CLK;   
always #15 VMOD=VMOD+1;
always #30 MODE=MODE+1;
endmodule

