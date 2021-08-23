`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2021 16:04:45
// Design Name: 
// Module Name: pid_block
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
