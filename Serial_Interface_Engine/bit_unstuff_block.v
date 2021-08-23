`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2021 13:47:41
// Design Name: 
// Module Name: bit_unstuff_block
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

//Finalised - Can unstuff a maximum of 7 stuffed zeros
//module bit_unstuff_block(
//    input clk,
//    input rst,
//    input data_in,
//    input en_unstuff,
//    output reg data_out
//    );
//    reg [7:0] temp ;
//    reg [2:0] count ;
//    reg [2:0] i ;
//    reg [7:0] clock_count;
    
//    always@ (posedge clk, negedge rst)
//    begin
//       clock_count = clock_count + 1 ;
//       if(!rst)
//         begin
//           i = 0 ;
//           count = 0 ;
//           temp = 8'b0 ;
//           clock_count = 0 ;
//           data_out = 1'bx ;
//         end
//       else if (clock_count < 9)
//       begin
//         temp = temp >> 1 ;
//         temp[7] = data_in ;
////           temp[7] = data_in ;
////           temp = temp >> 1 ;
//       end 
//       else if(count==6)
//        begin
//          i = i + 1;
//          count = 1 ;
//          temp = temp >> 1 ;
//          temp[7] = data_in ;
//        end 
//       else if (en_unstuff && count<6 && clock_count >= 9)
//        begin
//          data_out = temp[i] ;
//          temp = temp >> 1 ;
//          temp[7] = data_in ;
//          if (data_out)
//             count = count + 1 ;
//          else
//             count = 0 ;      
//        end 
//    end
        
//endmodule

//This can unstuff max of 3 stuffed zeros
module bit_unstuff_block(
    input clk,
    input rst,
    input data_in,
    input en_unstuff,
    output reg data_out
    );
    reg [3:0] temp ;
    reg [2:0] count ;
    reg [2:0] i ;
    reg [7:0] clock_count;
    
    always@ (posedge clk, negedge rst)
    begin
       clock_count = clock_count + 1 ;
       if(!rst)
         begin
           i = 0 ;
           count = 0 ;
           temp = 4'b0 ;
           clock_count = 0 ;
           data_out = 1'bx ;
         end
       else if (clock_count < 5)
       begin
         temp = temp >> 1 ;
         temp[3] = data_in ;
       end 
       else if(count==6)
        begin
          i = i + 1;
          count = 1 ;
          temp = temp >> 1 ;
          temp[3] = data_in ;
        end 
       else if (en_unstuff && count<6 && clock_count >= 5)
        begin
          data_out = temp[i] ;
          temp = temp >> 1 ;
          temp[3] = data_in ;
          if (data_out)
             count = count + 1 ;
          else
             count = 0 ;      
        end 
    end
        
endmodule