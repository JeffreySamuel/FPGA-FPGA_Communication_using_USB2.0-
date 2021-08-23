`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2021 12:25:32
// Design Name: 
// Module Name: top_block
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

//Top Block
module SIE_block(
    input clk,
    input rst,
    input [7:0] par_ip ,
    input load,
    output Token, Data, Handshake, Error,
    output out_to_nrzi,
    output DP , DM ,
    output out_to_unstuff,
    output valid_bit,
    output out_to_sipo,
    output [7:0] par_op_sipo
    );
    wire op_to_pid_tx ;
    //wire Token, Data, Handshake, Error ;
    wire OUT,SOF,IN,SETUP,DATA0,DATA2,DATA1,MDATA,ACK,NYET,NAK,STALL ;
    wire Token_rx, Data_rx, Handshake_rx, Error_rx ;
    wire op_to_crc ;
    wire crc_out5,out_stream5,crc_out16,out_stream16 ;
    wire out_to_stuff ;
    //wire out_to_nrzi ;
    //wire out_to_unstuff ;
    wire out_to_pid_rx, out_to_crc_rx ;
    wire enable_bitstuff,enable_nrziencoder,enable_bitunstuff,enable_sipo ;
    
    //Transmitter Side
    data_control m13(.clk(clk), .rst(rst),.en_bitstuff(enable_bitstuff),.en_nrziencoder(enable_nrziencoder),
                 .en_bitunstuff(enable_bitunstuff),.en_sipo(enable_sipo));
    
    piso_block m1(.parallel_ip(par_ip), .clk(clk),.load(load),
                 .reset(rst),.serial_op(op_to_pid_tx)); 
    
    pid_block m2(.clock(clk),.reset(rst),.data_in(op_to_pid_tx),.Token(Token), 
             .Data(Data),.Handshake(Handshake),.Error(Error),.data_out(op_to_crc),
             .OUT(OUT),.SOF(SOF),.IN(IN),.SETUP(SETUP),.DATA0(DATA0),
             .DATA2(DATA2),.DATA1(DATA1),.MDATA(MDATA),.ACK(ACK),.NYET(NYET),
             .NAK(NAK),.STALL(STALL)); 
             
    crc5_block m3(.clk(clk),.rst(rst),.data_in(op_to_crc),.put(Token),
                  .data_out(crc_out5),.data_stream_out(out_stream5)); 
    
    crc16_block m4(.clk(clk),.rst(rst),.din(op_to_crc),.put(Data),
                   .crc16_out(crc_out16),.data_stream_out(out_stream16));
                   
    mux_block m5(.clk(clk),.rst(rst),.Token_pkt(Token),.Data_pkt(Data),
                 .stream5(out_stream5),.stream16(out_stream16),.crc5(crc_out5),.crc16(crc_out16),
                 .out_to_stuff(out_to_stuff)); 
                 
    bitstuff_block m6(.clk(clk),.rst(rst),.enable_data(enable_bitstuff),
                   .data_in(out_to_stuff),.data_out(out_to_nrzi));
                   
    nrzi_block m7(.clk(clk),.rst(rst), .data_in(out_to_nrzi), .DP(DP), .DM(DM), .en_nrzi(enable_nrziencoder));                                          
    
    //Receiver Side                    
    nrzi_decoder m8(.clk(clk),.rst(rst),.DPin(DP),.DMin(DM),.dout(out_to_unstuff));
    
    bit_unstuff_block m9(.clk(clk),.rst(rst),.data_in(out_to_unstuff),.en_unstuff(enable_bitunstuff),.data_out(out_to_pid_rx));

    pid_block m10(.clock(clk),.reset(rst),.data_in(out_to_pid_rx),.Token(Token_rx), 
             .Data(Data_rx),.Handshake(Handshake_rx),.Error(Error_rx),.data_out(out_to_crc_rx),
             .OUT(OUT),.SOF(SOF),.IN(IN),.SETUP(SETUP),.DATA0(DATA0),
             .DATA2(DATA2),.DATA1(DATA1),.MDATA(MDATA),.ACK(ACK),.NYET(NYET),
             .NAK(NAK),.STALL(STALL));
             
    crc16r m11(.clk(clk),.rst(rst),.din(out_to_crc_rx),.put(Data_rx),.valid(valid_bit),.stream_out(out_to_sipo)); 
    
    sipo_block m12(.clk(clk),.rst(rst),.enable(enable_sipo),.ser_ip(out_to_sipo),.par_op(par_op_sipo));        

endmodule

