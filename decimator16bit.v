`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:06:25 03/15/2022 
// Design Name: 
// Module Name:    decimator16bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decimator16bit(CLK, VMOD, MODE, Q, timer, count);
input CLK, VMOD, MODE;
output reg [15:0]Q=1'b0;
output reg[15:0] count=1'b0, timer=1'b0;
always @(posedge CLK)
begin
timer = timer + 1'b1;
if(timer == 16'hffff && MODE == 1'b0)
Q <= count;
if(timer == 16'h8000 && MODE == 1'b1)
Q <= count;
end
always @(negedge CLK)
begin
if (timer == 16'hffff && MODE == 1'b0)
count = 16'h0000;
else if(timer == 16'h8000 && MODE == 1'b1)
count = 16'h0000;
else if(VMOD)
count = count + 1'b1;
end
endmodule
