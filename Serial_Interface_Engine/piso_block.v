`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2021 11:33:57
// Design Name: 
// Module Name: piso_block
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
module piso_block(
    input [7:0] parallel_ip,
    input clk,
    input load,
    input reset,
    output serial_op
    );
    reg [7:0] temp;
    reg clk_count;
    assign serial_op = (clk_count==1'b1)? temp[0] : 1'bx;
    //assign serial_op = temp[0] ;
    always@ (posedge clk,negedge reset)
    begin
      if(!reset)
      begin
        temp <= 8'b00000000;
        clk_count <= 1'b0 ;
      end
      else if(load)
      begin
        temp <= parallel_ip;
        clk_count <= 1'b1 ;
      end
      else
      begin
        temp <= {1'b0,temp[7:1]};
      end    
    end
endmodule