module Multiplier_4x4(
    input [3:0] A,
    input [3:0] B,
    output[7:0] SUM    
    //output CARRY_OUT 
    );
    
    wire [5:0]S_i;
    wire [10:0]C;
    
    assign SUM[0] = (A[0] & B[0]);
    
    // 1st Column
    HalfAdder HA_0(
        .A(A[0]&B[1]),
        .B(A[1]&B[0]),    
        .SUM(SUM[1]),
        .CARRY(C[0])
    );
    
    FullAdder FA_0(
        .A(A[1] & B[1]),
        .B(B[0] & A[2]),
        .SUM(S_i[0]),
        .CARRY_IN(C[0]),
        .CARRY_OUT(C[4])
    );
    
    FullAdder FA_4(
        .A(A[3] & B[0]),
        .B(B[1] & A[2]),
        .SUM(S_i[3]),
        .CARRY_IN(C[4]),
        .CARRY_OUT(C[8])
    );
    
    //2nd column
    HalfAdder HA_1(
        .A(A[0]&B[2]),
        .B(S_i[0]),    
        .SUM(SUM[2]),
        .CARRY(C[1])
    );
    FullAdder FA_1(
        .A(A[1] & B[2]),
        .B(S_i[3]),
        .SUM(S_i[1]),
        .CARRY_IN(C[1]),
        .CARRY_OUT(C[5])
    );
    
    FullAdder FA_5(
        .A(A[3] & B[1]),
        .B(C[8]),
        .SUM(S_i[4]),
        .CARRY_IN(C[5]),
        .CARRY_OUT(C[9])
    );    
    
    //3rd Column
    
    HalfAdder HA_2(
        .A(A[0]&B[3]),
        .B(S_i[1]),    
        .SUM(SUM[3]),
        .CARRY(C[2])
    );
    FullAdder FA_2(
        .A(A[2] & B[2]),
        .B(S_i[4]),
        .SUM(S_i[2]),
        .CARRY_IN(C[2]),
        .CARRY_OUT(C[6])
    );
    
    FullAdder FA_6(
        .A(A[3] & B[2]),
        .B(C[9]),
        .SUM(S_i[5]),
        .CARRY_IN(C[6]),
        .CARRY_OUT(C[10])
    );    
    
    //4th column
    HalfAdder HA_3(
        .A(A[1]&B[3]),
        .B(S_i[2]),    
        .SUM(SUM[4]),
        .CARRY(C[3])
    );
    FullAdder FA_3(
        .A(A[2] & B[3]),
        .B(S_i[5]),
        .SUM(SUM[5]),
        .CARRY_IN(C[3]),
        .CARRY_OUT(C[7])
    );
    
    FullAdder FA_7(
        .A(A[3] & B[3]),
        .B(C[10]),
        .SUM(SUM[6]),
        .CARRY_IN(C[7]),
        .CARRY_OUT(SUM[7])
    ); 
    
    
    
endmodule
