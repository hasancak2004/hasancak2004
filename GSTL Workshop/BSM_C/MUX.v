module MUX_behavioral(
    input in1,
    input in2,
    input S,
    
    output reg R    
    );
    
    always@(*) begin
        if(S)
            R <= in1;
        else
            R <= in2;
    end
    
endmodule

module MUX_combinational(
    input in1,
    input in2,
    input S,
    
    output R    
    );
    assign R = (S)? in2 : in1;
    
    
endmodule
