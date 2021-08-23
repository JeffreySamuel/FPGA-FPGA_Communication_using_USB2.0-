`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2021 11:36:42
// Design Name: 
// Module Name: tb_crc5_block
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
//module tb_crc5_block();
//  reg CLK,RST,DATA_IN,PUT ;
//  wire Data_out ;
//  crc5_block uut(CLK,RST,DATA_IN,PUT,Data_out);
//  always #10 CLK<=~CLK;
//  initial
//  begin
//    CLK <= 1'b0 ; RST <= 1'b0 ;PUT <= 1'b0 ; 
//    #5 RST <= 1'b1 ; #5 PUT <= 1'b1 ; 
//    #20 PUT <= 1'b0 ; DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;  // Data sent is 11'b011_0001_0110(316)  ;  CRC_out shud be 5'b00101(05)
    
//    //#20 PUT <= 1'b1 ; DATA_IN <= 1'bx ;
//    #20 DATA_IN <= 1'bx ;
//    #100 PUT <= 1'b1 ;
//    #20 PUT <= 1'b0 ; DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;  // Data sent is 11'b101_1001_0110(596)  ;  CRC_out shud be 5'b01001(hexa_09)
    
//    //#20 PUT <= 1'b1 ; DATA_IN <= 1'bx ;
//    #20 DATA_IN <= 1'bx ;
//    #100 PUT <= 1'b1 ;
//    #20 PUT <= 1'b0 ; DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;  // Data sent is 11'b101_1001_0001(591) ; CRC_out shud be 5'b10010(hexa_12)
//    #200 $finish ;
//  end
//endmodule

//Trial
//module tb_crc5_block();
//  reg CLK,RST,DATA_IN,PUT ;
//  wire Data_out ;
//  crc5_block uut(CLK,RST,DATA_IN,PUT,Data_out);
//  always #10 CLK<=~CLK;
//  initial
//  begin
//    CLK <= 1'b0 ; RST <= 1'b0 ;PUT <= 1'b0 ;  DATA_IN <= 1'b0 ; 
//    #5 RST <= 1'b1 ; 
//    #165 DATA_IN <= 1'b1 ;
//    #40 DATA_IN <= 1'b0 ;
//    #40 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #40 DATA_IN <= 1'b0 ; PUT <= 1'b1 ;
//    #20 PUT <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #40 DATA_IN <= 1'b0 ;
//    #20 DATA_IN <= 1'b1 ;
//    #20 DATA_IN <= 1'b0 ;
//    #60 DATA_IN <= 1'b1 ;
//    #40 DATA_IN <= 1'b0 ;    
//    #100 $finish ;
//  end
//endmodule

//Trial - for screenshot
module tb_crc5_block();
  reg CLK,RST,DATA_IN,PUT ;
  wire CRC ;
  //wire Data_out ;
  crc5_block uut(CLK,RST,DATA_IN,PUT,CRC);
  always #10 CLK<=~CLK;
  initial
  begin
    CLK <= 1'b0 ; RST <= 1'b0 ;PUT <= 1'b0 ; 
    #5 RST <= 1'b1 ; #5 PUT <= 1'b1 ; 
    #20 PUT <= 1'b0 ; DATA_IN <= 1'b0 ;
    #20 DATA_IN <= 1'b1 ;
    #20 DATA_IN <= 1'b1 ;
    #20 DATA_IN <= 1'b0 ;
    #20 DATA_IN <= 1'b1 ;
    #20 DATA_IN <= 1'b0 ;
    #20 DATA_IN <= 1'b0 ;
    #20 DATA_IN <= 1'b0 ;
    #20 DATA_IN <= 1'b1 ;
    #20 DATA_IN <= 1'b1 ;
    #20 DATA_IN <= 1'b0 ;  // Data sent is 11'b011_0001_0110(316)  ;  CRC_out shud be 5'b00101(05)
    #200 $finish ;
  end
endmodule    
    