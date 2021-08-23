`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2021 11:12:12
// Design Name: 
// Module Name: data_control
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


module data_control(
    input clk,
    input rst,
    output reg en_bitstuff,
    output reg en_nrziencoder,
    output reg en_bitunstuff,
    output reg en_sipo
    );
    reg [9:0] count ;
     always@ (posedge clk, negedge rst)
     begin
      count = count + 1 ; 
      if(!rst)
        begin
          count <= 0 ;
          en_bitstuff <= 1'b0 ;
          en_nrziencoder <= 1'b0 ;
          en_bitunstuff <= 1'b0 ;
          en_sipo <= 1'b0 ;
        end
       if (count >= 2)
         begin
          en_bitstuff <= 1'b1 ;
          en_nrziencoder <= 1'b1 ;
         end
       if (count >= 3)
          en_bitunstuff <= 1'b1 ; 
       if (count >= 9)
          en_sipo <= 1'b1 ;        
     end
endmodule
