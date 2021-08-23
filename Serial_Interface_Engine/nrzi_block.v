`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2021 12:31:09
// Design Name: 
// Module Name: nrzi_block
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

//Refer SIE Block for correct code
//Finalised
//module nrzi_block(clk, rst, data_in, DP, DM, en_nrzi);
    
//    input clk, rst, data_in, en_nrzi;
//    output reg DP, DM;
//    reg prev_data;

//always @(posedge clk, negedge rst)
// begin
//   if(!rst)
//      begin
//        DP = 1'bx;
//        DM = 1'bx;
//        prev_data = 1'bx;
//      end  
//        else 
//          begin
//           if(en_nrzi && (data_in==1'b0 || data_in==1'b1))
//            begin
//              DP = ~(data_in ^ prev_data);  //This shud be blocking
//              DM = ~DP;
//              //prev_data = data_in ; 
//            end
//           else if(!en_nrzi)
//           begin
//             DP = 1'bx ;
//             DM = 1'bx ;
//             prev_data = 1'bx ;
//           end
//           else
//             begin
//			   DP = 1'b0;
//               DM = 1'b0;
//             end
//          end
// end
 
// always@(posedge clk, negedge rst)
// begin
//    prev_data  <= DP;  //This shud be nonblocking
// end
//endmodule

//Trial - This also works
module nrzi_block(clk, rst, data_in, DP, DM, en_nrzi);
    
    input clk, rst, data_in, en_nrzi;
    output reg DP, DM;
    reg prev_data;
    reg start ;

always @(posedge clk, negedge rst)
 begin
   if(!rst && !en_nrzi)
      begin
        DP = 1'bx;
        DM = 1'bx;
        prev_data = 1'bx;
        start = 1'b0 ;
      end    
   else if(en_nrzi)
      begin
        DP = 1'b0;
        DM = 1'b1;
        start = 1'b1 ;
        prev_data = 1'b0; //same as DP
      end       
   else if(start)
      begin
        if(data_in==1'b1)       // If it is a 1, we don't need a transition
          begin
            DP = prev_data ;
            DM = ~DP ;
            prev_data = DP ;  
          end
        else
          begin
            DP = ~prev_data ;
            DM = ~DP ;
            prev_data = DP ;  
          end  
      end
   //else 
   //   begin
   //     DP = 1'b0;
   //     DM = 1'b1;
   //   end      
 end
 
endmodule