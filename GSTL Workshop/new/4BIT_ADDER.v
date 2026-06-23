module ADDER_4BIT(    
    input [3:0]A,
    input [3:0]B,
    input CARRY_IN,		
    output [3:0]SUM,
    output CARRY_OUT
    );
    

    wire C1;
    wire C2;    
    wire C3;

            
    FullAdder FA_0(
    .A(A[0]),
    .B(B[0]),
    .SUM(SUM[0]),
    .CARRY_IN(CARRY_IN),
    .CARRY_OUT(C1)
    );
    
    FullAdder FA_1(
    .A(A[1]),
    .B(B[1]),
    .SUM(SUM[1]),
    .CARRY_IN(C1),
    .CARRY_OUT(C2)
    );
    
    FullAdder FA_2(
    .A(A[2]),
    .B(B[2]),
    .SUM(SUM[2]),
    .CARRY_IN(C2),
    .CARRY_OUT(C3)
    );
    
    
    FullAdder FA_3(
    .A(A[3]),
    .B(B[3]),
    .SUM(SUM[3]),
    .CARRY_IN(C3),
    .CARRY_OUT(CARRY_OUT)
    );
    
    
    
endmodule
