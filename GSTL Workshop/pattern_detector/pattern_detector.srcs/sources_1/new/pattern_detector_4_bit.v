module pattern_detector_4_bit(
    input X,
    input clk,
    input rst_ni,
    
    output reg y
    );
    
    parameter IDLE = 3'd0;
    parameter S0 = 3'd1;
    parameter S1 = 3'd2;
    parameter S2 = 3'd3;
    parameter S3 = 3'd4;
    parameter S4 = 3'd5;
    parameter S5 = 3'd6;
    
    reg [2:0]State;


 always@(posedge clk or negedge rst_ni) begin
        if(!rst_ni) begin
            State <= IDLE;
            y <= 1'd0;

        end

        else begin
            y <= 1'd0;
            case(State)
            
            IDLE:begin
                State <= (X) ? S0 : S1;
                end
            S0:begin
                State <= (X) ? S2 : S1;
                end                
            S1:begin
                State <= (X) ? S0 : S3;
                 end
            S2:begin
                State <= (X) ? S4 : S1;
                end
            S3:begin
                State <= (X) ? S0 : S5;
                end
            S4:begin
                if(X) begin
                    State <= S4;
                    y <= 1'd1;
                end 
                else begin          
                    State <= S1;
                end
                end
                
            S5:begin
                if(!X) begin
                    State <= S5;
                    y <= 1'd1;
                end 
                else begin          
                    State <= S0;
                end
                end
            endcase
        end
        end
endmodule