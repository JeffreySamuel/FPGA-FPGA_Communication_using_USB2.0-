`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2021 11:08:26
// Design Name: 
// Module Name: mux_block
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


module mux_block(
    input clk,rst,Token_pkt,Data_pkt,stream5,stream16,crc5,crc16,
    output out_to_stuff
    );
    reg Trigger5 , Trigger16 ;
    assign out_to_stuff = (({Trigger5,Trigger16})==2'b10)? (stream5 | crc5) : (stream16 | crc16) ;
    always@ (posedge clk, negedge rst)
    begin
      if(!rst)
        begin
         Trigger5=1'b0 ;
         Trigger16=1'b0 ;
         //out_to_stuff = 1'b0 ;
        end
//      case({Trigger5,Trigger16})
//         2'b00 : out_to_stuff = stream5 ; //can be stream16 too
//         2'b10 : out_to_stuff = stream5 | crc5 ;
//         2'b01 : out_to_stuff = stream16 | crc16  ; 
//         default : out_to_stuff = 1'b0 ;
//      endcase   
    end
    
    always@ (posedge clk)
    begin
      if(Token_pkt==1'b1)
         begin
         Trigger5 <= 1'b1 ;
         Trigger16 <= 1'b0 ;
         end
      if (Data_pkt==1'b1)
         begin
         Trigger16 <= 1'b1 ;
         Trigger5 <= 1'b0 ;
         end
    end
endmodule