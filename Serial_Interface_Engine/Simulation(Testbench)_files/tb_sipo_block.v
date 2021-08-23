`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2021 10:13:11
// Design Name: 
// Module Name: tb_sipo_block
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


module tb_sipo_block();
  reg CLK, RST, SER_IP ;
  wire [7:0] PAR_OP ;
  //wire [7:0] temp ;
  //wire [3:0] count ;
  sipo_block a1 (CLK, RST, SER_IP, PAR_OP);
  always #10 CLK=~CLK;
  initial
  begin
    CLK<=1'b0 ; RST<=1'b0 ; SER_IP <= 1'bx ;
    #5 RST<=1'b1 ;
    #25 SER_IP<= 1'bx ;
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b0 ;  //LSB is received first
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b0 ;
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b0 ;  
    //Data sent is 8'b01110101(75_hex)
    
    #20 SER_IP<=1'b1 ;
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b0 ;
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b0 ;
    #20 SER_IP<= 1'b1 ;
    #20 SER_IP<= 1'b0 ; 
    //Data sent is 8'b01011011(5B_hex)
    #60 $finish ;
  end
endmodule
