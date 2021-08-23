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

//Data Control Block
 module data_control(
    input clk,
    input rst,
    output reg en_bitstuff,
    output reg en_nrziencoder,
    output reg en_bitunstuff,
    output reg en_sipo
    );
    reg [9:0] count ;
     always@ (posedge clk, negedge rst)
     begin
      count = count + 1 ; 
      if(!rst)
        begin
          count <= 0 ;
          en_bitstuff <= 1'b0 ;
          en_nrziencoder <= 1'b0 ;
          en_bitunstuff <= 1'b0 ;
          en_sipo <= 1'b0 ;
        end
       if (count >= 2)
         begin
          en_bitstuff <= 1'b1 ;
          en_nrziencoder <= 1'b1 ;
         end
       if (count >= 3)
          en_bitunstuff <= 1'b1 ; 
       if (count >= 9)
          en_sipo <= 1'b1 ;        
     end
endmodule
  
//PISO Block
module piso_block(
    input [7:0] parallel_ip,
    input clk,
    input load,
    input reset,
    output serial_op
    );
    reg [7:0] temp;
    reg clk_count;
    assign serial_op = (clk_count==1'b1)? temp[0] : 1'bx ;
    always@ (posedge clk,negedge reset)
    begin
      if(!reset)
      begin
        temp <= 8'b00000000;
        clk_count <= 1'b0;    
      end
      else if(load)
      begin
        temp <= parallel_ip;
        clk_count <= 1'b1;
      end
      else
      begin
        temp <= {1'b0,temp[7:1]}; 
      end    
    end
endmodule

//PID Block
module pid_block(
    input clock,
    input reset,
    input data_in,
    output reg Token, Data, Handshake, Error,  //Token - crc5_put  ;  Data - crc16_put
    output reg data_out,
    output OUT,SOF,IN,SETUP,DATA0,DATA2,DATA1,MDATA,ACK,NYET,NAK,STALL
    );
    
 reg [3:0] Token_pid_name;
 reg [3:0] Data_pid_name;
 reg [3:0] Handshake_pid_name;
 // Token pid name
 assign OUT = Token_pid_name[0];
 assign SOF = Token_pid_name[1];
 assign IN = Token_pid_name[2];
 assign SETUP = Token_pid_name[3];
 // Data pid name
 assign DATA0 = Data_pid_name[0]; 
 assign DATA2 = Data_pid_name[1];
 assign DATA1 = Data_pid_name[2];
 assign MDATA = Data_pid_name[3];
 // Handshake pid name
 assign ACK = Handshake_pid_name[0]; 
 assign NYET = Handshake_pid_name[1];
 assign NAK = Handshake_pid_name[2];
 assign STALL = Handshake_pid_name[3];
 
 reg [3:0] pid_p , pid_n ;
 reg [3:0] count;
 reg [7:0] temp;
 
 //assign data_out = data_in ;
 always@ (posedge clock, negedge reset)
 begin
  if(!reset)
    begin
      count <= 0;
      temp <= 8'b00000000;
      Token <= 1'b0 ; Data <= 1'b0; Handshake <= 1'b0 ; Error <= 1'b0 ;
      Token_pid_name = 4'b0;
      Data_pid_name = 4'b0;
	  Handshake_pid_name = 4'b0;
	  //data_out = 1'bz;
	  data_out = 1'bx;
    end
   else if(data_in == 1'b1 || data_in == 1'b0)
    begin
      count <= (count==8)? 1 : count + 1;
      temp <= temp >> 1;
      temp[7] <= data_in ;
      data_out <= data_in ; 
    end 
 end
 
 always@ (count)
 begin
   if(count==8)
     begin
       pid_p = temp[3:0] ; pid_n = temp[7:4] ;   // Never use non-blocking statements here
        if(pid_p == ~pid_n)
          begin
            Error = 1'b0; 
            case(pid_p[1:0])
               2'b01 : begin  //Token Packet
                         Token = 1'b1 ; Data = 1'b0 ; Handshake = 1'b0 ;
                         Data_pid_name = 4'b0;
                         Handshake_pid_name = 4'b0 ;
                            case(pid_p[3:2])
                             2'b00 : Token_pid_name = 4'b0001;
							 2'b01 : Token_pid_name = 4'b0010;
							 2'b10 : Token_pid_name = 4'b0100;
							 2'b11 : Token_pid_name = 4'b1000;
						     default : Token_pid_name = 4'b0000;
                            endcase
                       end
               2'b11 : begin  //Data Packet
                         Token = 1'b0 ; Data = 1'b1 ; Handshake = 1'b0 ;
                         Token_pid_name = 4'b0;
                         Handshake_pid_name = 4'b0 ;
                           case (pid_p[3:2])
					         2'b00 : Data_pid_name = 4'b0001;
							 2'b01 : Data_pid_name = 4'b0010;
							 2'b10 : Data_pid_name = 4'b0100;
							 2'b11 : Data_pid_name = 4'b1000;
						     default : Data_pid_name = 4'b0000;
					       endcase
                       end
               2'b10 :  begin //Handshake Packet
                         Token = 1'b0 ; Data = 1'b0 ; Handshake = 1'b1 ;
                         Token_pid_name = 4'b0;
                         Data_pid_name = 4'b0 ;
                           case (pid_p[3:2])
					         2'b00 : Handshake_pid_name = 4'b0001;
							 2'b01 : Handshake_pid_name = 4'b0010;
							 2'b10 : Handshake_pid_name = 4'b0100;
							 2'b11 : Handshake_pid_name = 4'b1000;
						     default : Handshake_pid_name = 4'b0000;
					       endcase
                        end
               default :begin 
                         Token = 1'b0 ; Data = 1'b0 ; Handshake = 1'b0 ;
                         Error = 1'b1; 
			             Token_pid_name = 4'b0;
			             Data_pid_name = 4'b0;
						 Handshake_pid_name = 4'b0;
                        end 
            endcase         
          end
        else
          begin
            Error = 1'b1; 
            Token_pid_name = 4'b0 ; Token = 1'b0 ;
            Data_pid_name = 4'b0 ;  Data = 1'b0 ;
            Handshake_pid_name = 4'b0 ; Handshake = 1'b0 ;
          end  
     end
   else
    begin
     Error <= 1'b0 ;
     Token_pid_name = 4'b0 ; Token = 1'b0 ;
     Data_pid_name = 4'b0 ;  Data = 1'b0 ;
     Handshake_pid_name = 4'b0 ; Handshake = 1'b0 ;
    end  
 end
 
endmodule

//CRC5 Block
module crc5_block(
    input clk,
    input rst,
    input data_in,
    input put,
    output data_out,
    output reg data_stream_out
    );
    reg [4:0] crc_out;
    reg [4:0] crc_temp ;
    reg [10:0] temp ;
    reg feedback ;
    integer i ;
    reg [3:0] count ;
    reg trigger ;
    assign data_out = crc_out[0] ;
    //assign data_stream_out = data_in | data_out ;
    always@ (posedge clk or negedge rst)
    begin
      data_stream_out = data_in ;
      if(!rst)
          begin
          data_stream_out = 1'bz ;
          crc_temp = 5'b00000;
          temp = 11'b0;
          crc_out = 5'b0 ;
          count = 0 ;
          end
      else if(trigger==1'b1 && count != 11 && (data_in == 1'b1 || data_in == 1'b0)) 
        begin
          temp = temp >> 1 ;
          temp[10] = data_in ;
          count = count + 1;
        end    
      else if (trigger==1'b1 && count==11)
        begin
        count = 0 ;
        trigger <= 1'b0 ;
        for(i=10 ; i>=0 ; i=i-1)
        begin       
        feedback     = crc_temp[ 4 ] ^ temp[i];
        crc_temp[ 4 ] = crc_temp[ 3 ];
        crc_temp[ 3 ] = crc_temp[ 2 ];
        crc_temp[ 2 ] = crc_temp[ 1 ] ^ feedback;
        crc_temp[ 1 ] = crc_temp[ 0 ];
        crc_temp[ 0 ] = feedback;      
        end
        end   
     end 
     
     always@ (posedge clk or negedge rst)
     begin
       if(trigger==1'b1 && count==0)
         crc_out <= crc_temp ;
         crc_temp <= 5'b00000 ;
     end
     
     always@ (posedge clk)
     begin
       if(put==1'b1)
       begin
         trigger <= 1'b1 ;
       end
     end
     
     always@ (posedge clk)
     begin
       //data_out = crc_out[0] ;
       crc_out = crc_out >> 1 ;
     end
endmodule

//CRC16 Block
module crc16_block(input clk,rst,din,put, output crc16_out,output reg data_stream_out);
   
    reg [7:0]store;
    reg [3:0]count;
    reg fb; integer i;
    reg trigger ;
    reg [15:0]tmp, outcrc ;
    assign crc16_out = outcrc[0] ;
    always@(posedge clk or negedge rst)
    begin
        data_stream_out = din ;
        if(!rst)
            begin
            tmp=16'b0000000000000000;
            store=8'b00000000;
            count=0;
            outcrc=16'b0;
            data_stream_out = 1'bz ;
            end
        else if(trigger==1'b1 && count!=8 &&(din == 1'b1 || din == 1'b0))
            begin
            store = store >> 1;
            store[7] = din;
            count=count+1;
            end
        else if(trigger==1'b1 && count==8)
            begin 
            count=0;
            //trigger = 1'b0 ;
            for (i= 7 ; i>= 0 ; i=i-1 )
                begin 
                fb=tmp[15]^store[i];
                tmp[15]=tmp[14]^fb;
                tmp[14]=tmp[13];
                tmp[13]=tmp[12];
                tmp[12]=tmp[11];
                tmp[11]=tmp[10];
                tmp[10]=tmp[9];
                tmp[9]=tmp[8];
                tmp[8]=tmp[7];
                tmp[7]=tmp[6];
                tmp[6]=tmp[5];
                tmp[5]=tmp[4];
                tmp[4]=tmp[3];
                tmp[3]=tmp[2];
                tmp[2]=tmp[1]^fb;
                tmp[1]=tmp[0];
                tmp[0]=fb;
                end
            end
    end
   
   always@(posedge clk or negedge rst)
    begin
    if(trigger==1'b1 && count==0)
        begin
           trigger = 1'b0 ;
           outcrc<=tmp;
           tmp<=16'b0000000000000000; 
        end
    end
    
   always@(posedge clk)
   begin
    if(put==1'b1)
      trigger <= 1'b1 ;
   end
   
   always@ (posedge clk)
     outcrc = outcrc >> 1 ;
     
endmodule

//MUX Block
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
        end
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

//Bit Stuffing Block
module bitstuff_block(
    input clk,
    input rst,
    input enable_data,
    input data_in,
    output data_out
    );
    reg [2:0] count ;
    reg [7:0] temp_reg ;
    reg [2:0] state ;
    reg [2:0] i ;
    wire en_ok ;
    assign data_out = (count==6)? ( 1'b0 ) : ((state==0)? data_in:temp_reg[0]) ;
    assign en_ok = (count==6)? 1'b1 : 1'b0 ;
    
    always@ (posedge clk or negedge rst)
    begin
     if(!rst)
      begin
        count <= 0 ;
        i <= 0 ;
        temp_reg <= 8'b0 ;
        state <= 0 ;
        //en_ok <= 1'b0 ;
      end
     else if(enable_data)
      begin
         if(count<6)
         begin
         //en_ok <= 1'b0 ;
         case(state)
              0 :begin
                   if(data_in)
                     count <= count + 1 ;
                   else
                     count <= 0 ;
                   //data_out <= data_in ;
                 end
              1 :begin
                   if(temp_reg[0])
                     count <= count + 1 ;
                   else
                     count <= 0 ;
                   i = 1 ;
                   //data_out <= temp_reg[0] ;
                   temp_reg[0] <= data_in ;
                 end
              2 :begin
                   if(temp_reg[1])
                     count <= count + 1 ;
                   else
                     count <= 0 ;
                   i = 2;
                   //data_out <= temp_reg[0] ;
                   temp_reg <= temp_reg >> 1 ;
                   temp_reg[1] <= data_in ;
                 end
              3 :begin
                   if(temp_reg[2])
                     count <= count + 1 ;
                   else
                     count <= 0 ;
                   i = 3;
                   //data_out <= temp_reg[0] ;
                   temp_reg <= temp_reg >> 1 ;
                   temp_reg[2] <= data_in ;
                 end
              4 :begin
                   if(temp_reg[3])
                     count <= count + 1 ;
                   else
                     count <= 0 ;
                   i = 4;
                   //data_out <= temp_reg[0] ;
                   temp_reg <= temp_reg >> 1 ;
                   temp_reg[3] <= data_in ;
                 end
              5 :begin
                   if(temp_reg[4])
                     count <= count + 1 ;
                   else
                     count <= 0 ;
                   i = 5;
                  // data_out <= temp_reg[0] ;
                   temp_reg <= temp_reg >> 1 ; 
                   temp_reg[4] <= data_in ;
                 end 
               6 :begin
                   if(temp_reg[5])
                     count <= count + 1 ;
                   else
                     count <= 0 ;
                   i = 6;
                   //data_out <= temp_reg[0] ;
                   temp_reg <= temp_reg >> 1 ; 
                   temp_reg[5] <= data_in ;
                 end   
               7 :begin
                   if(temp_reg[6])
                     count <= count + 1 ;
                   else
                     count <= 0 ;
                   i = 7;
                   //data_out <= temp_reg[0] ;
                   temp_reg <= temp_reg >> 1 ; 
                   temp_reg[6] <= data_in ;
                 end     
          endcase 
        end                
      end 
    end
    
    always@ (posedge clk)
    begin
     if(count==6)
      begin
       //data_out <= 1'b0 ; //Stuffing a zero 
       //en_ok <= 1'b1 ;
       temp_reg[i] <= data_in ;
       count <= 0 ;
       state <= state + 1 ;
      end
    end
endmodule

//NRZI Encoder Block
module nrzi_block(clk, rst, data_in, DP, DM, en_nrzi);
    
    input clk, rst, data_in, en_nrzi;
    output reg DP, DM;
    reg prev_data;

always @(posedge clk, negedge rst)
 begin
   if(!rst)
      begin
        DP = 1'bx;
        DM = 1'bx;
        prev_data = 1'bx;
      end  
        else 
          begin
           if(en_nrzi && (data_in==1'b0 || data_in==1'b1))
            begin
              DP = ~(data_in ^ prev_data);  //This shud be blocking
              DM = ~DP;
              //prev_data = data_in ; 
            end
           else if(!en_nrzi)
           begin
             DP = 1'bx ;
             DM = 1'bx ;
             prev_data = 1'bx ;
           end
           else
             begin
			   DP = 1'b0;
               DM = 1'b0;
             end
          end
 end
 
 always@(posedge clk, negedge rst)
 begin
    prev_data  <= DP;  //This shud be nonblocking
 end
endmodule

//NRZI Decoder
module nrzi_decoder(input clk,rst,DPin,DMin, output dout);
    reg prev_DP;
    assign dout = (DPin == 1'b0 || DPin == 1'b1)? ((prev_DP ^ DPin == 1'b1)? 1'b0 : 1'b1 ) : 1'bx ;
    always@(posedge clk,negedge rst)
      begin
        if(!rst)
          begin
           prev_DP <= 1'b0;
          end
        else
           prev_DP <= DPin ;  
      end   
endmodule

//Bit Unstuffing Block
module bit_unstuff_block(
    input clk,
    input rst,
    input data_in,
    input en_unstuff,
    output reg data_out
    );
    reg [3:0] temp ;
    reg [2:0] count ;
    reg [2:0] i ;
    reg [7:0] clock_count;
    
    always@ (posedge clk, negedge rst)
    begin
       clock_count = clock_count + 1 ;
       if(!rst)
         begin
           i = 0 ;
           count = 0 ;
           temp = 4'b0 ;
           clock_count = 0 ;
           data_out = 1'bx ;
         end
       else if (clock_count < 5)
       begin
         temp = temp >> 1 ;
         temp[3] = data_in ;
       end 
       else if(count==6)
        begin
          i = i + 1;
          count = 1 ;
          temp = temp >> 1 ;
          temp[3] = data_in ;
        end 
       else if (en_unstuff && count<6 && clock_count >= 5)
        begin
          data_out = temp[i] ;
          temp = temp >> 1 ;
          temp[3] = data_in ;
          if (data_out)
             count = count + 1 ;
          else
             count = 0 ;      
        end 
    end
endmodule

//CRC16 Decoder
module crc16r(input clk,rst,din,put,output reg valid,output stream_out);
    
    reg [4:0]count ;
    reg [23:0]store ;
    reg [15:0]outcrc ;
    reg fb; integer i;
    reg [15:0]tmp;
    reg trigger ;
   // reg valid ;
    assign stream_out = (!rst)? 1'bx : din ;
    always@(posedge clk or negedge rst)
    begin
        //stream_out = din ; 
        if(!rst)
            begin
            valid = 1'b0 ;
            //stream_out = 1'bx ;
            tmp=16'b0;
            store=24'b0;
            count=0;
            outcrc=16'b0;
            end
        else if(trigger==1'b1 && count!=24 &&(din == 1'b1 || din == 1'b0))
            begin
            store = store >> 1;
            store[23] = din;
            count=count+1;
            end
        else if(trigger==1'b1 && count==24)
            begin 
            count=0;
            for (i= 23 ; i>= 0 ; i=i-1 )
                begin 
                fb=tmp[15]^store[i];
                tmp[15]=tmp[14]^fb;
                tmp[14]=tmp[13];
                tmp[13]=tmp[12];
                tmp[12]=tmp[11];
                tmp[11]=tmp[10];
                tmp[10]=tmp[9];
                tmp[9]=tmp[8];
                tmp[8]=tmp[7];
                tmp[7]=tmp[6];
                tmp[6]=tmp[5];
                tmp[5]=tmp[4];
                tmp[4]=tmp[3];
                tmp[3]=tmp[2];
                tmp[2]=tmp[1]^fb;
                tmp[1]=tmp[0];
                tmp[0]=fb;
                end
            end
    end
   
   always@(posedge clk or negedge rst)
    begin
    if(trigger==1'b1 && count==0)
        begin
           trigger = 1'b0 ;
           outcrc<=tmp;
           tmp<=16'b0;
           if(outcrc==16'b0)
             valid<=1'b1 ;
        end
    end
    
    always@(negedge clk)
      valid <= 1'b0 ;
    always@ (posedge clk)
    begin
      if(put==1'b1)
        trigger <= 1'b1 ;
    end
endmodule

//SIPO Block
module sipo_block(
    input clk,
    input rst,
    input ser_ip,
    input enable,
    output reg [7:0] par_op
    );
    reg [7:0] temp ;
    reg [3:0] count ;
    always@ (posedge clk or negedge rst)
    begin
     if(!rst)
      begin
        temp = 8'b0 ;
        par_op = 8'bx ;
        count = 0 ;
      end
     else if(enable==1'b1 && (ser_ip==1'b1 || ser_ip==1'b0))
      begin
       if (count==8)
        begin
        count = 1 ;
        par_op = temp ;
        //temp[7] = ser_ip ;
        //temp = temp >> 1 ;
        temp = temp >> 1 ;
        temp[7] = ser_ip ;
        end 
       else
        begin
        count = count + 1 ;
        //temp[7] = ser_ip ;
        //temp = temp >> 1 ;
        temp = temp >> 1 ;
        temp[7] = ser_ip ;
        end 
      end 
    else
     begin
       par_op = 8'bx ;
     end
   end
endmodule

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

