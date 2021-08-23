`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2021 10:45:41
// Design Name: 
// Module Name: tb_bitstuff
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


module tb_bitstuff();
  reg CLK,RST,Data_in,EnData ;
  //wire [2:0] Count ; 
  wire Stuffed ;
  wire Data_out ;
  bitstuff_block uut(CLK,RST,EnData,Data_in,Stuffed,Data_out);
  always #10 CLK=~CLK ;
  initial
  begin
   CLK <= 1'b0 ; RST <= 1'b0 ; Data_in <= 1'bx ; EnData <= 1'b1 ;
   #5 RST <= 1'b1 ;
   #5 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b0 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b0 ;
   #20 Data_in <= 1'b0 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b0 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b1 ;
   #20 Data_in <= 1'b0 ;
   #200 $finish ;
  end
endmodule
