`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2021 20:27:30
// Design Name: 
// Module Name: tb_pid_block
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
module tb_pid_block();
  reg CLOCK,RST,DATA_IN ;
  wire TOKEN,DATA,HANDSHAKE,ERROR ;
  wire DATA_OUT;
  wire OUT,SOF,IN,SETUP,DATA0,DATA2,DATA1,MDATA,ACK,NYET,NAK,STALL;
  pid_block a1(CLOCK,RST,DATA_IN,TOKEN,DATA,HANDSHAKE,ERROR,DATA_OUT,OUT,SOF,IN,SETUP,DATA0,DATA2,DATA1,MDATA,ACK,NYET,NAK,STALL);
  always #10 CLOCK=~CLOCK;
  
  initial
  begin
   RST <= 1'b0 ; CLOCK <= 1'b0 ; DATA_IN <= 1'bx ;
   #5 RST <= 1'b1;#5 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b0 ;
   //End of 1st PID packet - Token : IN
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b1 ;
   //End of 2nd PID packet - Data : DATA0
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b1 ;
   //End of 3rd PID packet - Handshake : ACK
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b0 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b1 ;
   #20 DATA_IN <= 1'b1 ;
   //Not a PID packet - Error
   #100 $finish;
   end
   
endmodule

//module tb_pid_block();
//  reg CLOCK,RST,DATA_IN ;
//  wire TOKEN,DATA,HANDSHAKE,ERROR ;
//  wire DATA_OUT;
//  wire OUT,SOF,IN,SETUP,DATA0,DATA2,DATA1,MDATA,ACK,NYET,NAK,STALL;
//  pid_block a1(CLOCK,RST,DATA_IN,TOKEN,DATA,HANDSHAKE,ERROR,DATA_OUT,OUT,SOF,IN,SETUP,DATA0,DATA2,DATA1,MDATA,ACK,NYET,NAK,STALL);
//  always #10 CLOCK=~CLOCK;
  
//  initial
//  begin
//   RST <= 1'b0 ; CLOCK <= 1'b0 ; DATA_IN <= 1'bx ;
//   #5 RST <= 1'b1;#5 DATA_IN <= 1'bx ;
//   #20 DATA_IN <= 1'bx ;
//   #20 DATA_IN <= 1'b1 ;
//   #20 DATA_IN <= 1'b0 ;
//   #20 DATA_IN <= 1'b0 ;
//   #20 DATA_IN <= 1'b1 ;
//   #20 DATA_IN <= 1'b0 ;
//   #20 DATA_IN <= 1'b1 ;
//   #20 DATA_IN <= 1'b1 ;
//   #20 DATA_IN <= 1'b0 ;
//   //End of 1st PID packet - Token : IN
//   #20 DATA_IN <= 1'b1 ;
//   #20 DATA_IN <= 1'b1 ;
//   #20 DATA_IN <= 1'b0 ;
//   #20 DATA_IN <= 1'b0 ;
//   #20 DATA_IN <= 1'b0 ;
//   #20 DATA_IN <= 1'b0 ;
//   #20 DATA_IN <= 1'b1 ;
//   #20 DATA_IN <= 1'b1 ;
//   //End of 2nd PID packet - Data : DATA0
//   #100 $finish;
//   end
   
//endmodule