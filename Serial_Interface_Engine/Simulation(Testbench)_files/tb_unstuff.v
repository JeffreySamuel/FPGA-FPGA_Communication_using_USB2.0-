`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2021 15:50:19
// Design Name: 
// Module Name: tb_unstuff
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


//Finalised - Testbench for unstuffing 7 bits
//module tb_unstuff();
//    reg clk, rst, data_in, en_unstuff ;
//    wire data_out ;
//    bit_unstuff_block uut(clk, rst, data_in, en_unstuff,data_out) ;
//    always #10 clk = ~clk ;
//    initial
//    begin
//     clk <= 1'b0 ; rst <= 1'b0 ; en_unstuff <= 1'b1 ; //data_in <= 1'b1 ;
//     #5 rst <= 1'b1 ; #10 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ;
    
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ; //Stuffed zero1
     
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ;//Stuffed zero2
     
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ;//Stuffed zero3
     
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ; //Stuffed zero4
     
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ;//Stuffed zero5
     
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ;//Stuffed zero6
     
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ;//Stuffed zero7
     
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ;
//     #20 data_in <= 1'b1 ;
//     #20 data_in <= 1'b0 ;
//     #200 $finish ;
//     end 
//endmodule

//Testbench for unstuffing 3 bits
module tb_unstuff();
    reg clk, rst, data_in, en_unstuff ;
    wire data_out ;
    bit_unstuff_block uut(clk, rst, data_in, en_unstuff,data_out) ;
    always #10 clk = ~clk ;
    initial
    begin
     clk <= 1'b0 ; rst <= 1'b0 ; en_unstuff <= 1'b1 ; //data_in <= 1'b1 ;
     #5 rst <= 1'b1 ; #10 data_in <= 1'b1 ;
     #20 data_in <= 1'b0 ;
    
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b0 ; //Stuffed zero1
     
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b0 ;//Stuffed zero2
     
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b0 ;//Stuffed zero3
     
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b0 ;
     #20 data_in <= 1'b1 ;
     #20 data_in <= 1'b0 ;
     #200 $finish ;
     end 
endmodule

