`timescale 1ns / 1ps
module pattern_detector_4_bit_tb();
    reg clk;
    always #5 clk=!clk;
    reg rst_ni;
    reg X;
    wire y;
    
    reg[11:0] test_data = 12'b100_1111_00000; //goes right to left
  
    integer i;  
    pattern_detector_4_bit uut(
    .X(X),
    .clk(clk),
    .rst_ni(rst_ni),
    .y(y)
    );
        
    initial begin
        clk = 0;
        rst_ni = 0;
        X = 0;
        
        #15 rst_ni = 1;
        
        for(i = 0; i < 12; i = i+1) begin
            @(posedge clk);
            X = test_data[i];
        end
        

            
    
    end
endmodule
