module D_FF(
    input D,
    input reset,
    input clk,
    output reg Q 
    );
    
    always@(posedge clk) begin
        if(reset) begin
            Q <= 1'b0;
        end
        else
            Q <= D;        
        end
endmodule