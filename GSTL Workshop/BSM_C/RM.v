module RM(
    input D,
    input rst,
    input clk,
    output reg Q
    );
    always@(posedge clk) begin
        if(rst) begin
            Q <= 1'b0;
        end
        else
            Q <= D;
        end
    endmodule