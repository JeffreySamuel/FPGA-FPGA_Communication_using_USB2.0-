`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2021 11:29:55
// Design Name: 
// Module Name: tb_data_control
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


module tb_data_control();
    reg clk, rst ;
    wire en_bitstuff,en_nrziencoder,en_bitunstuff,en_sipo ;
    //wire [9:0] count ;
    data_control uut(clk,rst,en_bitstuff,en_nrziencoder,en_bitunstuff,en_sipo);
    always #10 clk=~clk ;
    initial
    begin
     clk<=1'b0 ; rst<=1'b0 ;
     #5 rst <=1'b1 ;
     #200 $finish ; 
    end
endmodule
