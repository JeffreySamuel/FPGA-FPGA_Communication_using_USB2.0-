`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2021 09:39:11
// Design Name: 
// Module Name: crc16_block
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


module crc16_block(input clk,rst,din,put,output crc16_out);
   
    reg [7:0]store;
    reg [3:0]count;
    reg fb; integer i;
    reg trigger ;
    reg [15:0]tmp;
    reg [15:0]outcrc ;
    assign crc16_out = outcrc[0] ;
    always@(posedge clk or negedge rst)
    begin
        if(!rst)
            begin
            tmp=16'b0000000000000000;
            store=8'b00000000;
            count=0;
            outcrc=16'b0;
            end
        else if(trigger==1'b1 && count!=8 &&(din == 1'b1 || din == 1'b0))
            begin
            store = store >> 1;
            store[7] = din;
            count=count+1;
            end
        else if(trigger==1'b1 && count==8)
            begin 
            count=0;
            //trigger = 1'b0 ;
            for (i= 7 ; i>= 0 ; i=i-1 )
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
           tmp<=16'b0000000000000000; 
        end
    end
    
   always@(posedge clk)
   begin
    if(put==1'b1)
      trigger <= 1'b1 ;
   end
   
   always@ (posedge clk)
     outcrc = outcrc >> 1 ;
     
endmodule
