`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2021 12:41:28
// Design Name: 
// Module Name: tb_nrzi_en
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


//module tb_nrzi_en();
//  reg clk, rst, data_in, en_nrzi;
//  wire DP, DM;
//  nrzi_block uut(clk,rst,data_in,DP,DM,en_nrzi);
//  always #10 clk = ~ clk ;
//  initial
//  begin
//    clk <= 1'b1 ; rst <= 1'b0 ; en_nrzi <= 1'b1 ; data_in <= 1'b1 ;
//    #5 rst <= 1'b1 ;
//    #15 data_in <= 1'b0 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b0 ;
//    #20 data_in <= 1'b0 ;
//    #20 data_in <= 1'b0 ;
//    #20 data_in <= 1'b0 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b0 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b0 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b0 ;
//    #20 data_in <= 1'b0 ;
//    #20 data_in <= 1'b1 ;
//    #20 data_in <= 1'b0 ;
//    #40 $finish ;
//  end
//endmodule

module tb_nrzi_en();
  reg clk, rst, data_in, en_nrzi;
  wire DP, DM;
  nrzi_block uut(clk,rst,data_in,DP,DM,en_nrzi);
  always #10 clk = ~ clk ;
  initial
  begin
    clk <= 1'b1 ; rst <= 1'b0 ; en_nrzi <= 1'b0 ; data_in <= 1'bx ;
    #5 rst <= 1'b1 ;
    #15 data_in <= 1'bx ;
    #20 en_nrzi <= 1'b1 ; data_in <= 1'bx ;
    #20 en_nrzi <= 1'b0 ; data_in <= 1'b1 ;
    #20 data_in <= 1'b0 ;
    #20 data_in <= 1'b0 ;
    #20 data_in <= 1'b0 ;
    #20 data_in <= 1'b1 ;
    #20 data_in <= 1'b1 ;
    #20 data_in <= 1'b1 ;
    #20 data_in <= 1'b1 ;
    #20 data_in <= 1'b0 ;
    #20 data_in <= 1'b1 ;
    #20 data_in <= 1'b0 ;
    #20 data_in <= 1'b1 ;
    #20 data_in <= 1'b1 ;
    #20 data_in <= 1'b0 ;
    #20 data_in <= 1'b0 ;
    #20 data_in <= 1'b1 ;
    #20 data_in <= 1'b0 ;
    #40 $finish ;
  end
endmodule