`timescale 1ns / 1ps

module dmem(
    input  logic        clk, we,
    input  logic [31:0] a, wd,
    output logic [31:0] rd
);

    logic [31:0] RAM[63:0];

    // Read logic: The output always shows the data at address 'a'
    // Dividing the byte-address by 4 to get the word-index
    assign rd = RAM[a[31:2]]; 

    // Write logic: Data is saved only on the rising edge of the clock
    always_ff @(posedge clk)
        if (we) RAM[a[31:2]] <= wd;

endmodule