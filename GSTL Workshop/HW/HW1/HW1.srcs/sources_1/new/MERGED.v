module MERGED(
    input [7:0]I,
    input s2, s1, s0,
    
    input button,
    input clk,
    input reset,
    
    output Out
    );
    
    wire OUT_MUX;
    
    MUX_8X3 MUX(
    .I(I),
    .s2(s2),
    .s1(s1),
    .s0(s0),
    .R(OUT_MUX)
    );
    
    D_FF dff(
    .D(OUT_MUX),
    .reset(reset|!button),
    .clk(clk),
    .Q(Q)
    );
    
    assign Out = Q;
endmodule
