`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:18:05 03/22/2022 
// Design Name: 
// Module Name:    delta_sigma_adc 
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
module delta_sigma_adc
#(
    parameter W = 16//????
)
(
    input   wire                clk     ,
    input   wire                rst_n   ,

    input   wire signed [W-1:0] din     ,//signed analog signal
    output  reg                 dout     //PDM signal
);
wire signed [W-1:0]adc1b_max = {1'b0,{(W-1){1'b1}}};
wire signed [W-1:0]adc1b_min = {1'b1,{(W-1){1'b0}}};
wire signed [W-1:0]adc1b_out = (dout == 1'b1)?adc1b_max:
                               (dout == 1'b0)?adc1b_min:
                               'bx;                    
reg  signed   [W*2-1:0]inte0,inte1;
wire signed   [W*2-1:0]diff0  =   din     -   adc1b_out;
wire signed   [W*2-1:0]rd0    =   diff0   +   inte0;
wire signed   [W*2-1:0]diff1  =   rd0     -   adc1b_out;
wire signed   [W*2-1:0]rd1    =   diff1   +   inte1;
wire          comp            =   (rd1 > 0)?1'b1:1'b0;
always@(posedge clk or negedge rst_n)begin
    if ( !rst_n ) begin
        dout    <= 1'b0;
        inte0   <=  'b0;
        inte1   <=  'b0;
    end else begin
        dout    <= comp;
        inte0   <= rd0;
        inte1   <= rd1;
    end
end
endmodule


