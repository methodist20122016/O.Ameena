`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:19:07 03/22/2022 
// Design Name: 
// Module Name:    pdm_audio 
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
module pdm_audio
(
    input   wire                clk     ,// FREQ
    input   wire                rst_n   ,
    // connect to FIFO
    input   wire                rdaccess,// The FIFO data is ready,FIFO not empty
    input   wire                rdclk   ,// FREQ/32=48Khz
    output  reg                 rden    ,
    input   wire        [31:0]  rddat   ,// {L[31:16],R[15:0]},signed
    // microphone
    output  wire                pdm_r   ,    
    output  wire                pdm_l       
);
reg  [1:0]bf0;
wire rdaccess_b = bf0[1];
always@(posedge rdclk or negedge rst_n)begin if(!rst_n)bf0<='b0;else bf0<={bf0,rdaccess};end
always@(posedge rdclk or negedge rst_n)begin
    if ( !rst_n ) begin
        rden<=1'd0;
    end else begin
        if(rdaccess_b)
            rden<=1'd1;
    end
end
delta_sigma_adc #(.W ( 16 ))
delta_sigma_adc_r (
    .clk                     ( clk            ),
    .rst_n                   ( rst_n          ),
    .din                     ( rddat   [15:0] ),
    .dout                    ( pdm_r          )
);
delta_sigma_adc #(.W ( 16 ))
delta_sigma_adc_l (
    .clk                     ( clk            ),
    .rst_n                   ( rst_n          ),
    .din                     ( rddat  [31:16] ),
    .dout                    ( pdm_l          )
);
endmodule


