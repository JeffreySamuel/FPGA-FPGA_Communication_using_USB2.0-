`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2021 10:34:05
// Design Name: 
// Module Name: crc5_block
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
////////////////////////////////////////////////////////////////////////////


//Finalised
module crc5_block(
    input clk,
    input rst,
    input data_in,
    input put,
    output data_out
    );
    reg data_stream_out ;
    reg [4:0] crc_out;
    reg [4:0] crc_temp ;
    reg [10:0] temp ;
    reg feedback ;
    integer i ;
    reg [3:0] count ;
    reg trigger ;
    assign data_out = crc_out[0] ;
    //assign data_stream_out = data_in | data_out ;
    always@ (posedge clk or negedge rst)
    begin
      //data_stream_out = data_in ;
      if(!rst)
          begin
          //data_stream_out = 1'bz ;
          crc_temp = 5'b00000;
          temp = 11'b0;
          crc_out = 5'b0 ;
          count = 0 ;
          end
      else if(trigger==1'b1 && count != 11 && (data_in == 1'b1 || data_in == 1'b0)) 
        begin
          temp = temp >> 1 ;
          temp[10] = data_in ;
          count = count + 1;
        end    
      else if (trigger==1'b1 && count==11)
        begin
        count = 0 ;
        trigger <= 1'b0 ;
        for(i=10 ; i>=0 ; i=i-1)
        begin       
        feedback     = crc_temp[ 4 ] ^ temp[i];
        crc_temp[ 4 ] = crc_temp[ 3 ];
        crc_temp[ 3 ] = crc_temp[ 2 ];
        crc_temp[ 2 ] = crc_temp[ 1 ] ^ feedback;
        crc_temp[ 1 ] = crc_temp[ 0 ];
        crc_temp[ 0 ] = feedback;      
        end
        end   
     end 
     
     always@ (posedge clk or negedge rst)
     begin
       if(trigger==1'b1 && count==0)
         crc_out <= crc_temp ;
         crc_temp <= 5'b00000 ;
     end
     
     always@ (posedge clk)
     begin
       if(put==1'b1)
       begin
         trigger <= 1'b1 ;
       end
     end
     
     always@ (posedge clk)
     begin
       //data_out = crc_out[0] ;
       crc_out = crc_out >> 1 ;
     end
endmodule