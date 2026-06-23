module MUX_8X3(
   
//    input in0, in1, in2, in3, in4, in5, in6, in7,
    input [7:0]I,    
    input s2, s1, s0,
    //input [3:0]S
    output reg R
    );
    
    always@(*) begin
    case({s2,s1,s0})
    
//        3'd0 : R = in0;
//        3'd1 : R = in1;     
//        3'd2 : R = in2;
//        3'd3 : R = in3;  
//        3'd4 : R = in4;
//        3'd5 : R = in5;     
//        3'd6 : R = in6;
//        3'd7 : R = in7;  

        3'd0 : R = I[0];
        3'd1 : R = I[1];     
        3'd2 : R = I[2];
        3'd3 : R = I[3];  
        3'd4 : R = I[4];
        3'd5 : R = I[5];     
        3'd6 : R = I[6];
        3'd7 : R = I[7];  
                  
        default : $display("Invalid signals");
    endcase
    end
endmodule