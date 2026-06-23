module pc_adder(
    input [31:0] a, b,
    output [31:0] y);
    assign y = a + b;
endmodule

module multiplier(
    input [31:0] A,
    input [31:0] B,
    output [63:0] product
);
assign product = A * B;

endmodule

