`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2021 15:25:36
// Design Name: 
// Module Name: tb_mux
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


module tb_mux();
  reg clk,rst,Token_pkt,Data_pkt,stream5,stream16,crc5,crc16 ;
  wire out_to_stuff ;
  mux_block uut(clk,rst,Token_pkt,Data_pkt,stream5,stream16,crc5,crc16,out_to_stuff) ;
  always #10 clk=~clk ;
  initial
  begin
    clk <= 1'b0 ; rst <= 1'b0 ; stream5<=1'b0; stream16<=1'b0; crc5 <= 1'b0; crc16 <= 1'b0 ; Token_pkt <= 1'b0 ; Data_pkt <= 1'b0 ;
    #5 rst <= 1'b1 ;
    #20 stream5 <= 1'b1 ; stream16 <= 1'b1 ;
    #20 stream5 <= 1'b0 ; stream16 <= 1'b0 ;
    #20 stream5 <= 1'b1 ; stream16 <= 1'b1 ;
    #20 stream5 <= 1'b1 ; stream16 <= 1'b1 ;
    #20 stream5 <= 1'b0 ; stream16 <= 1'b0 ;Token_pkt <= 1'b1 ;
    #20 Token_pkt <= 1'b0 ; stream5 <= 1'b0 ; stream16 <= 1'b0 ;crc5 <= 1'b1 ;
    #20 crc5 <= 1'b0 ;
    #20 crc5 <= 1'b1 ;
    #20 crc5 <= 1'b1 ;
    #20 crc5 <= 1'b1 ;
    #20 stream5 <= 1'b1 ; stream16 <= 1'b1 ; crc5<= 1'b0 ;
    #20 stream5 <= 1'b0 ; stream16 <= 1'b0 ;
    #20 stream5 <= 1'b1 ; stream16 <= 1'b1 ;
    #20 stream5 <= 1'b0 ; stream16 <= 1'b0 ;
    #20 stream5 <= 1'b1 ; stream16 <= 1'b1 ;
    #20 stream5 <= 1'b0 ; stream16 <= 1'b0 ; Data_pkt <= 1'b1 ;
    #20 stream5 <= 1'b0 ; stream16 <= 1'b0 ; Data_pkt <= 1'b0 ; crc16 <= 1'b1 ;
    #20 crc16 <= 1'b1 ;
    #20 crc16 <= 1'b0 ;
    #20 crc16 <= 1'b0 ;
    #20 crc16 <= 1'b1 ;
    #20 crc16 <= 1'b1 ;
    #20 crc16 <= 1'b0 ;
    #100 $finish ;
  end
endmodule
