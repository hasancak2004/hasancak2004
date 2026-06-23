`timescale 1ns / 1ps



module Mutiplier_4x4_tb();
    reg [3:0] in1;
    reg [3:0] in2;
    
    wire [7:0] SUM;
    

    
    Multiplier_4x4 uut(
    .A(in1),
    .B(in2),
    .SUM(SUM)
    );
    
    initial begin       
    
        in1 = 4'b0000;
        in2 = 4'b0001;
        #5;
        in1 = 4'b0001;
        in2 = 4'b0000;
        #5;    
        in1 = 4'b0110;
        in2 = 4'b1100;
        #5;
        in1 = 4'b1110;
        in2 = 4'b1111;
        #5;     
        $finish();     
    
    end

endmodule
