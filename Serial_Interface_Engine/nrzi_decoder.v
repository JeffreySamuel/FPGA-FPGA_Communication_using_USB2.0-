`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2021 11:24:57
// Design Name: 
// Module Name: nrzi_decoder
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

//Finalised
module nrzi_decoder(input clk,rst,DPin,DMin, output dout);
    reg prev_DP;
    assign dout = (DPin == 1'b0 || DPin == 1'b1)? ((prev_DP ^ DPin == 1'b1)? 1'b0 : 1'b1 ) : 1'bx ;
//    assign prev_DP = (!rst)? 1'b0 : DPin ;
//    always@(posedge clk,negedge rst)
//      begin
//        if(!rst)
//            begin
//            prev_DP<=1'b0;
//            //dout = 1'b0 ;
//            //prev_DM<=1'b1;
//            end
//        else if (DPin == 1'b0 || DPin == 1'b1)
//            begin
//              if (prev_DP ^ DPin == 1'b1) //If transition has occured
//                dout = 1'b0;
//              else
//                dout = 1'b1;   
//              prev_DP=DPin ;
//            end
//        else
//           dout = 1'bx ;       
//      end
      
      always@(posedge clk,negedge rst)
      begin
        if(!rst)
          begin
           prev_DP <= 1'b0;
          end
        else
           prev_DP <= DPin ;  
      end   
endmodule