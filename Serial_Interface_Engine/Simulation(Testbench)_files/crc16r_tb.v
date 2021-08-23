`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2021 10:36:30
// Design Name: 
// Module Name: crc16r_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module crc16r_tb;
    reg clk,rst,din,put;
    wire stream_out ;
    wire valid ;
    crc16r m10(clk,rst,din,put,valid,stream_out);
    always #10 clk<=~clk;
    initial
    begin
        clk<=1'b0;rst<=1'b0;put<=1'b0;
        #5  rst<=1'b1;
        #5 put <= 1'b1 ;
        #20 put<= 1'b0 ;din<=1'b1;
        #20 din<=1'b1;
        #20 din<=1'b1;
        #20 din<=1'b1;
        #20 din<=1'b0;
        #20 din<=1'b0;
        #20 din<=1'b1;
        #20 din<=1'b0;
        #20 din<=1'b1;
        #20 din<=1'b0;
        #20 din<=1'b0;
        #20 din<=1'b0;
        #20 din<=1'b0; 
        #20 din<=1'b0;
        #20 din<=1'b0;
        #20 din<=1'b1;
        #20 din<=1'b0;
        #20 din<=1'b1;
        #20 din<=1'b0;
        #20 din<=1'b0;
        #20 din<=1'b0;
        #20 din<=1'b1;
        #20 din<=1'b1;
        #20 din<=1'b0;   //24bit data 62814F
//        #40 din<=1'b0;
        
//        #20 din<=1'b1;
//        #20 din<=1'b1;
//        #20 din<=1'b0;
//        #20 din<=1'b1;
//        #20 din<=1'b0;
//        #20 din<=1'b1;
//        #20 din<=1'b0;
//        #20 din<=1'b1;
//        #20 din<=1'b1;
//        #20 din<=1'b0;
//        #20 din<=1'b0;
//        #20 din<=1'b0; 
//        #20 din<=1'b0;
//        #20 din<=1'b0;
//        #20 din<=1'b0;
//        #20 din<=1'b1;
//        #20 din<=1'b0;
//        #20 din<=1'b0;
//        #20 din<=1'b1;
//        #20 din<=1'b1;
//        #20 din<=1'b0;
//        #20 din<=1'b0;
//        #20 din<=1'b1;  //24bit data 990356
        #40 $finish;
     end
endmodule
