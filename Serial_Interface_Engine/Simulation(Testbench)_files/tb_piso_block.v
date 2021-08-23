`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2021 11:50:55
// Design Name: 
// Module Name: tb_piso_block
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

//Trial
//module tb_piso_block();
//  reg CLOCK,RST,LOAD;
//  reg [7:0] P_IP;
//  wire S_OP;
//  piso_block a1(P_IP,CLOCK,LOAD,RST,S_OP);
//  always #10 CLOCK=~CLOCK;
//  initial
//  begin
//    CLOCK<=1'b0; RST<=1'b0; LOAD<=1'b0;P_IP<=8'b00000000;
//    #5 RST<=1'b1;
//    #5 LOAD<=1'b1; P_IP<=8'b10001111;
//    #20 LOAD<=1'b0;   //Always give one full clock period to LOAD
//    #160 LOAD<=1'b1; P_IP<=8'b10100111;  //160ns is for conversion of 8 bits(8*20=160)
//    #20 LOAD<=1'b0;
//    #160 ;
//    $finish;
//   end
//endmodule

//Finalised
module tb_piso_block();
  reg CLOCK,RST,LOAD;
  reg [7:0] Parallel_ip;
  wire Serial_op;
  piso_block a1(Parallel_ip,CLOCK,LOAD,RST,Serial_op);
  always #10 CLOCK=~CLOCK;
  initial
  begin
    CLOCK<=1'b0; RST<=1'b0; LOAD<=1'b1;Parallel_ip<=8'b10001011;
    #5 RST<=1'b1; 
    #15 LOAD<=1'b0; //Give enough time(1 clock period ~ 20 ns) for LOAD to remain high
    #140 LOAD<=1'b1; Parallel_ip<=8'b10101010;  //160ns(140+5+15) is for conversion of 8 bits(8*20=160)
    #20 LOAD<=1'b0;
    #140 ;  //160 ns (140+20)
    $finish;
   end
endmodule
