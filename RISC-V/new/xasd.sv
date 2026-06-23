module regfile(
    input  logic        clk,
    input  logic        we3,
    input  logic [4:0]  a1, a2, a3, 
    input  logic [31:0] wd3,
    output logic [31:0] rd1, rd2
);

    logic [31:0] rf[31:0];

    // Inside module regfile
    integer i;
    initial begin
        for (i=0; i<32; i=i+1) rf[i] = 32'b0;
    end
    
    // Three ported register file
    // Write third port on rising edge of clock
    
    // note: for pipelined processor, write third por
    //on falling edge of cl
    
    always_ff @(posedge clk)
        if (we3 && (a3 != 5'b0)) rf[a3] <= wd3;

    // Read two ports combinationally
    // Register 0 hardwired to 0
    assign rd1 = (a1 != 5'b0) ? rf[a1] : 32'b0;
    assign rd2 = (a2 != 5'b0) ? rf[a2] : 32'b0;

endmodule