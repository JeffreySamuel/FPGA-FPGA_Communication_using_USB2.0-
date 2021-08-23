`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2021 10:04:04
// Design Name: 
// Module Name: sipo_block
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


//module sipo_block(
//    input clk,
//    input rst,
//    input ser_ip,
//    output reg [7:0] par_op
//    );
//    reg [7:0] temp ;
//    reg [3:0] count ;
//    always@ (posedge clk or negedge rst)
//    begin
//     if(!rst)
//      begin
//        temp = 8'b0 ;
//        par_op = 8'bz ;
//        count = 0 ;
//      end
//     else if(count==8)
//      begin
//        count = 1 ;
//        par_op = temp ;
//        temp[7] = ser_ip ;
//        temp = temp >> 1 ;
//      end 
//     else
//      begin
//        count = count + 1 ;
//        temp[7] = ser_ip ;
//        temp = temp >> 1 ;
//      end 
//    end
    
//endmodule

module sipo_block(
    input clk,
    input rst,
    input ser_ip,
    output reg [7:0] par_op
    );
    reg [7:0] temp ;
    reg [3:0] count ;
    always@ (posedge clk or negedge rst)
    begin
     if(!rst)
      begin
        temp = 8'b0 ;
        par_op = 8'bx ;
        count = 0 ;
      end
     else if(ser_ip==1'b1 || ser_ip==1'b0)
      begin
       if (count==8)
        begin
        count = 1 ;
        par_op = temp ;
        //temp[7] = ser_ip ;
        //temp = temp >> 1 ;
        temp = temp >> 1 ;
        temp[7] = ser_ip ;
        end 
       else
        begin
        count = count + 1 ;
        //temp[7] = ser_ip ;
        //temp = temp >> 1 ;
        temp = temp >> 1 ;
        temp[7] = ser_ip ;
        end 
      end 
    else
     begin
       par_op = 8'bx ;
     end
   end
    
endmodule