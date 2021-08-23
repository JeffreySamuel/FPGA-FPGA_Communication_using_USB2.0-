`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2021 12:37:45
// Design Name: 
// Module Name: tb_sie_block
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
module tb_sie_block ;
   reg clk, rst, load ;
   reg [7:0] par_ip ;
   wire Token, Data, Handshake, Error ;
   //wire out_to_pid_tx ;
   //wire out_to_crc ;
   //wire out_stream16 ;
   //wire out_to_stuff ;
   wire out_to_nrzi ;
   wire DP , DM ;
   wire out_to_unstuff ;
   //wire out_to_pid_rx ;   
   //wire out_to_crc_rx ;
   wire valid_bit ;
   wire out_to_sipo ; 
   wire [7:0] par_op_sipo ;
    
   SIE_design_wrapper uut (.DM_line(DM),
       .DP_line(DP),
       .Data_flag(Data),
       .Error_flag(Error),
       .Handshake_flag(Handshake),
       .Token_flag(Token),
       .clock(clk),
       .load_SIE(load),
       .output_to_nrzi(out_to_nrzi),
       .output_to_sipo(out_to_sipo),
       .output_to_unstuff(out_to_unstuff),
       .parallel_ip(par_ip),
       .parallel_op(par_op_sipo),
       .reset(rst),
       .valid_flag(valid_bit)) ;
    
   always #19.23 clk=~clk;   //26 MHZ Clock
    
   initial
   begin
   clk<=1'b0; rst<=1'b0; load<=1'b1;par_ip<=8'b10000000;  //Sync packet
   #10 rst<=1'b1;
   #28.46 load<=1'b0; //load is high for 1 clock period (38.4 ns)
   #269.23 load<=1'b1; par_ip<=8'b01101001;  //PID packet - IN(Token)  //7*38.4=269.23
   #38.46 load<=1'b0;
   #269.23 load<=1'b1; par_ip<=8'b00010110;  //Address(0010110) + Endpoint(0110) + 5 zeros(CRC5 will be appended)   
   #38.46 load<=1'b0;
   #269.23 load<=1'b1; par_ip<=8'b00000011;
   #38.46 load<=1'b0;
   //End of Token Packet                      
   #269.23 load<=1'b1; par_ip<=8'b10000000;   //Sync packet
   #38.46 load<=1'b0;
   #269.23 load<=1'b1; par_ip<=8'b11000011;   //PID packet - DATA0 (DATA)
   #38.46 load<=1'b0;
   #269.23 load<=1'b1; par_ip<=8'b01100010;   //Data sent (01100010)
   #38.46 load<=1'b0;
   #269.23 load<=1'b1; par_ip<=8'b00000000;
   #38.46 load<=1'b0;
   #269.23 load<=1'b1; par_ip<=8'b00000000;   //16 zeros(CRC16 will be appended)
    #38.46 load<=1'b0;
    //End of Data Packet
    #269.23 load<=1'b1; par_ip<=8'b10000000;  //Sync packet  
    #38.46 load<=1'b0;
    #269.23 load<=1'b1; par_ip<=8'b11010010;  //PID packet - ACK (Handshake)  
    #38.46 load<=1'b0;
    #770 ;   //we extend for 20 clock cycles = 20*38.4=769.2 ~770  
    $finish;
    end
    
endmodule
