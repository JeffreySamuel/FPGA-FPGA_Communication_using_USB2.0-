`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2021 10:30:43
// Design Name: 
// Module Name: crc16r
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


module crc16r(input clk,rst,din,put,output reg valid,output reg stream_out, output reg invalid);
    
    reg [4:0]count ;
    reg [23:0]store ;
    reg [15:0]outcrc ;
    reg fb; integer i;
    reg [15:0]tmp;
    reg trigger ;
   // reg valid ;
   //reg invalid ;
    always@(posedge clk or negedge rst)
    begin
        stream_out = din ; 
        if(!rst)
            begin
            valid = 1'b0 ;
            stream_out = 1'bx ;
            tmp=16'b0;
            store=24'b0;
            count=0;
            outcrc=16'b0;
            end
        else if(trigger==1'b1 && count!=24 &&(din == 1'b1 || din == 1'b0))
            begin
            store = store >> 1;
            store[23] = din;
            count=count+1;
            end
        else if(trigger==1'b1 && count==24)
            begin 
            count=0;
            for (i= 23 ; i>= 0 ; i=i-1 )
                begin 
                fb=tmp[15]^store[i];
                tmp[15]=tmp[14]^fb;
                tmp[14]=tmp[13];
                tmp[13]=tmp[12];
                tmp[12]=tmp[11];
                tmp[11]=tmp[10];
                tmp[10]=tmp[9];
                tmp[9]=tmp[8];
                tmp[8]=tmp[7];
                tmp[7]=tmp[6];
                tmp[6]=tmp[5];
                tmp[5]=tmp[4];
                tmp[4]=tmp[3];
                tmp[3]=tmp[2];
                tmp[2]=tmp[1]^fb;
                tmp[1]=tmp[0];
                tmp[0]=fb;
                end
            end
    end
   
   always@(posedge clk or negedge rst)
    begin
    if(trigger==1'b1 && count==0)
        begin
           trigger = 1'b0 ;
           outcrc<=tmp;
           tmp<=16'b0;
           if(outcrc==16'b0)
             valid<=1'b1 ;
        end
    end
    
    always@(negedge clk)
      begin
      valid <= 1'b0 ;
      end
    always@ (posedge clk)
    begin
      if(put==1'b1)
        trigger <= 1'b1 ;
    end
    
       
endmodule
