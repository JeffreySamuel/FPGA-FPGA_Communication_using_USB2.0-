`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2021 09:41:34
// Design Name: 
// Module Name: crc16_tb
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


module crc16_tb();
    reg clk,rst,din,put;
    wire crc16 ;
    //wire [3:0] count ;
    //wire trigger ;
    //wire [15:0] temp ;
    crc16_block m4(clk,rst,din,put,crc16);
    always #10 clk<=~clk;
    initial
    begin
        clk<=1'b0 ; rst<=1'b0 ; put<=1'b0 ;
        #5  rst<=1'b1 ; #5 put<=1'b1 ;
        #20 put<=1'b0 ; din<=1'b0 ;
        #20 din<=1'b1 ;
        #20 din<=1'b0 ;
        #20 din<=1'b0 ;
        #20 din<=1'b0 ;
        #20 din<=1'b1 ;
        #20 din<=1'b1 ;
        #20 din<=1'b0 ;   //8bit data 8'b01100010(62 hexa)
                          //CRC 16 shud be 814F(hexa) - 1000_0001_0100_1111
        #400 $finish;
     end
endmodule
