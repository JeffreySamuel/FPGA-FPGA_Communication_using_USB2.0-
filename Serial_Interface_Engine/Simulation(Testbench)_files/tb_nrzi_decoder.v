`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2021 10:49:54
// Design Name: 
// Module Name: tb_nrzi_decoder
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
//module tb_nrzi_decoder;
//reg clk,rst,DPin,DMin;
//wire dout;
//nrzi_decoder m7(clk,rst,DPin,DMin,dout);
//always #10 clk=~clk;
//initial
//    begin
//    clk<=1'b0;rst<=1'b0;DPin<=1'bx;DMin<=1'bx;
//    #5 rst<=1'b1;
//    #25 DPin<=1'bx;DMin<=1'bx;
//    #20 DPin<=1'b1;DMin<=1'b0;
//    #20 DPin<=1'b0;DMin<=1'b1;
//    #20 DPin<=1'b1;DMin<=1'b0;
//    #20 DPin<=1'b0;DMin<=1'b1;
//    #20 DPin<=1'b1;DMin<=1'b0;
//    #20 DPin<=1'b0;DMin<=1'b1;
//    #20 DPin<=1'b1;DMin<=1'b0;
//    #20 DPin<=1'b0;DMin<=1'b1;
//    #20 DPin<=1'b0;DMin<=1'b1;
//    #20 DPin<=1'b0;DMin<=1'b1;
//    #20 DPin<=1'b1;DMin<=1'b0;
//    #20 DPin<=1'b1;DMin<=1'b0;
//    #50 $finish;
//    end
//endmodule

//Trial
module tb_nrzi_decoder;
reg clk,rst,DPin,DMin;
wire dout;
nrzi_decoder m7(clk,rst,DPin,DMin,dout);
always #10 clk=~clk;
initial
    begin
    clk<=1'b0;rst<=1'b0;DPin<=1'b0;DMin<=1'b1;
    #5 rst<=1'b1;
    #25 DPin<=1'b1;DMin<=1'b0;
    #20 DPin<=1'b1;DMin<=1'b0;
    #20 DPin<=1'b0;DMin<=1'b1;
    #20 DPin<=1'b1;DMin<=1'b0;
    #20 DPin<=1'b0;DMin<=1'b1;
    #20 DPin<=1'b1;DMin<=1'b0;
    #20 DPin<=1'b0;DMin<=1'b1;
    #20 DPin<=1'b1;DMin<=1'b0;
    #20 DPin<=1'b0;DMin<=1'b1;
    #20 DPin<=1'b0;DMin<=1'b1;
    #20 DPin<=1'b0;DMin<=1'b1;
    #20 DPin<=1'b1;DMin<=1'b0;
    #20 DPin<=1'b1;DMin<=1'b0;
    #50 $finish;
    end
endmodule