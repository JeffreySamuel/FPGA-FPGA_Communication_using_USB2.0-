`timescale 1ns / 1ps

//Finalised
module bitstuff_block(
    input clk,
    input rst,
    input enable_data,
    input data_in,
    output en_ok,  //Indicates that we have stuffed
    output data_out
    );
    reg [2:0] count ;
    reg [7:0] temp_reg ;
    reg [2:0] state ;
    reg [2:0] i ;
    //reg en_ok ;
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


