`timescale 1ns / 1ps

module D_FF_tb();
    reg D;
    reg clk;
    reg reset;
    wire Q;
    
    D_FF DFF(
    .D(D),
    .clk(clk),
    .reset(reset),
    .Q(Q)
    );
    
    initial begin
        clk = 0;
            forever #5 clk = ~clk;
    end
    
    initial begin
       
    reset = 1;
    D <= 0;
    #20
    D <= 1;
    #20
    reset = 0;
    D <= 0;
    #20
    D <= 1;
    #20
    D <= 0;
    end
endmodule
