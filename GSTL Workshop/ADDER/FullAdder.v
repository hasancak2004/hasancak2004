module FullAdder(
    input A,
    input B,
    input CARRY_IN,
    output SUM,
    output CARRY_OUT
);
    wire SUM_1;
    wire CARRY_1;
    wire CARRY_2;  
      
    HalfAdder HA_1(
    .A(A), 
    .B(B),
    .SUM(SUM_1),
    .CARRY(CARRY_1)
    );
    
    HalfAdder HA_2(
    .A(SUM_1), 
    .B(CARRY_IN),
    .SUM(SUM),
    .CARRY(CARRY_2)
    );
    
    assign CARRY_OUT = (CARRY_2 | CARRY_1);
    
    
endmodule
    