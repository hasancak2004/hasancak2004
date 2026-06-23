
//EXTEND UNIT
module extend(
    input logic [31:7] instr,
     input logic [1:0] immsrc,
     output logic [31:0] immext
 );
 always_comb
     case(immsrc)
         // I-type
         2'b00: immext = {{20{instr[31]}}, instr[31:20]};
         // S-type (stores)
         2'b01: immext = {{20{instr[31]}}, instr[31:25],
        instr[11:7]};
         // B-type (branches)
         2'b10: immext = {{20{instr[31]}}, instr[7],
        instr[30:25], instr[11:8], 1'b0};
         // J-type (jal)
         2'b11: immext = {{12{instr[31]}}, instr[19:12],
        instr[20], instr[30:21], 1'b0};
         default: immext = 32'bx; // undefined
     endcase
endmodule


//RESETTABLE FLIP-FLOP
module flopr #(parameter WIDTH = 8)(
     input logic clk, reset,
     input logic [WIDTH-1:0] d,
     output logic [WIDTH-1:0] q)
     ;
     always_ff @(posedge clk, posedge reset)
         if (reset) q <= 0;
         else q <= d;
         
endmodule

//RESETTABLE FLIP-FLOP WITH ENABLE
module flopenr #(parameter WIDTH = 8)(
     input logic clk, reset, en,
     input logic [WIDTH-1:0] d,
     output logic [WIDTH-1:0] q
     );
     always_ff @(posedge clk, posedge reset)
         if (reset) q <= 0;
         else if (en) q <= d;
         
endmodule

//2:1 MULTIPLEXER
module mux2 #(parameter WIDTH = 8)(
    input logic [WIDTH-1:0] d0, d1,
    input logic s,
    output logic [WIDTH-1:0] y
 );
 
 assign y = s ? d1 : d0;
 
endmodule


//3:1 MULTIPLEXER
module mux3 #(parameter WIDTH = 8)(
    input logic [WIDTH-1:0] d0, d1, d2,
    input logic [1:0] s,
    output logic [WIDTH-1:0] y
 );
 
 assign y = s[1] ? d2 :(s[0] ? d1 : d0);
 
endmodule


























