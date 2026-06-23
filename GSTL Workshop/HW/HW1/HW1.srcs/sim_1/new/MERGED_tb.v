`timescale 1ns / 1ps
module MERGED_tb();
    reg [7:0] X;
    reg s2,s1,s0;
    
    reg button;
    wire Out;
    
    
    reg clk;
    always #5 clk = !clk;    
    reg reset;
    
    MERGED uut(
    .I(X),
    .s2(s2),
    .s1(s1),
    .s0(s0),
    
    .button(button),
    .clk(clk),
    .reset(reset),
    .Out(Out)
        
     );
     
     initial begin
     
            
         clk = 0;
         reset = 1;
         button = 0;
         s2 = 0;
         s1 = 0;
         s0 = 0;
         #10;
         
         reset = 0;
         button = 1;
         X <= 8'd65;         
         #20;
         
         s2 = 1;
         s1 = 1;
         s0 = 1;
         #20;
        
         s0 = 0;
         #20;
         
         button = 0;
         #20;
         
         button = 1; 
         s2 = 0;         
         X <= 8'd18;

         #20;
         
         s2 = 1;
         s1 = 0;
         #20;
         
        end
    
     
     
     
endmodule
