module alu(
    input  logic [31:0] a, b,
    input  logic [2:0]  alucontrol,
    output logic [31:0] result,
    output logic        zero
);

    logic [31:0] adder_sum;
    logic        adder_cout;
    logic [63:0] mul_full;
    logic        is_sub;

    // 1. Subtraction Control

    assign is_sub = (alucontrol == 3'b001);

    // 2. Instantiate Your Structural 32-bit Adder/Subtractor
    ADDER_32BIT #(32) main_adder (
        .C0(1'b0),        // Not used since you hardwired C[0] to CTR
        .CTR(is_sub),     // 0 for ADD, 1 for SUB
        .A(a),
        .B(b),
        .S(adder_sum),
        .Cout(adder_cout)
    );

    // 3. Instantiate Your 32-bit Multiplier
    multiplier main_mul (
        .A(a),
        .B(b),
        .product(mul_full)
    );

    // 4. Operation Selection
    always_comb
        case (alucontrol)
            3'b000:  result = adder_sum;        // Add
            3'b001:  result = adder_sum;        // Subtract
            3'b010:  result = a & b;            // AND
            3'b011:  result = a | b;            // OR
            3'b110:  result = mul_full[31:0];   // Multiply (Lower 32 bits)
            3'b101:  result = (a < b) ? 32'b1 : 32'b0; // SLT
            default: result = 32'bx;
        endcase

    // 5. Zero Flag
    assign zero = (result == 32'b0);

endmodule