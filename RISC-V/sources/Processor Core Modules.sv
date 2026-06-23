//SINGLE-CYCLE PROCESSOR

module riscvsingle(
    input logic clk,reset,
    output logic [31:0] PC,
    input logic [31:0] Instr,
    output logic MemWrite,
    output logic [31:0] ALUResult, WriteData,
    input logic [31:0] ReadData
    );
    
logic ALUSrc, RegWrite, Jump, Zero, PCSrc;
logic[1:0] ResultSrc, ImmSrc;
logic [2:0] ALUControl;

//looks at optocod, funct3, funct7 from Instruction
//controller c(Instr[6:0], Instr[14:12], Instr [30],funct7b0(Instr[25]), Zero,
//             ResultSrc, MemWrite, PCSrc, 
//             ALUSrc, RegWrite, Jump,
//             ImmSrc, ALUControl);
             
controller c(
    .op(Instr[6:0]), 
    .funct3(Instr[14:12]), 
    .funct7b5(Instr[30]), 
    .funct7b0(Instr[25]), // Now correctly connected
    .Zero(Zero),
    .ResultSrc(ResultSrc), 
    .MemWrite(MemWrite), 
    .PCSrc(PCSrc),
    .ALUSrc(ALUSrc), 
    .RegWrite(RegWrite), 
    .Jump(Jump),
    .ImmSrc(ImmSrc), 
    .ALUControl(ALUControl)
);

datapath dp(clk, reset, ResultSrc, PCSrc,           
            ALUSrc, RegWrite, 
            ImmSrc, ALUControl,
            Zero, PC, Instr,
            ALUResult, WriteData, ReadData);
    

endmodule 

module controller(
    input logic [6:0] op,
    input logic [2:0] funct3,  
    input logic funct7b5,
    input logic funct7b0,
    input logic Zero,
    output logic [1:0] ResultSrc,
    output logic MemWrite,  
    output logic PCSrc, ALUSrc,  
    output logic RegWrite,Jump,  
    output logic [1:0] ImmSrc,  
    output logic [2:0] ALUControl      
    );

logic [1:0] ALUOp;  
logic Branch;

maindec md(op, ResultSrc, MemWrite, Branch,
           ALUSrc, RegWrite, Jump, ImmSrc, ALUOp);
aludec ad(op[5], funct3, funct7b5, funct7b0, ALUOp, ALUControl);

assign PCSrc = (Branch & Zero) | Jump;    
        
    
endmodule
    
// MAIN DECODER
module maindec (
    input logic[6:0] op,
    output logic[1:0] ResultSrc,
    output logic    MemWrite,
    output logic    Branch, ALUSrc,
    output logic    RegWrite, Jump,
    output logic[1:0] ImmSrc,    
    output logic[1:0] ALUOp

);

logic [10:0] controls;

assign{RegWrite, ImmSrc, ALUSrc, MemWrite,
       ResultSrc, Branch, ALUOp, Jump} = controls;

always_comb
    case(op)
// RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump

7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // lw
7'b0100011: controls = 11'b0_01_1_1_00_0_00_0; // sw
7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0; // R–type
7'b1100011: controls = 11'b0_10_0_0_00_1_01_0; // beq
7'b0010011: controls = 11'b1_00_1_0_00_0_10_0; // I–type ALU
7'b1101111: controls = 11'b1_11_0_0_10_0_00_1; // jal
default: controls = 11'bx_xx_x_x_xx_x_xx_x; // ???
    
    endcase
endmodule

//ALU DECODER
module aludec(
    input logic opb5,
    input logic [2:0] funct3,
    input logic funct7b5,
    input  logic       funct7b0, // New input: Bit 0 of funct7 (usually Instr[25])
    input logic[1:0] ALUOp,
    output logic[2:0] ALUControl
);


logic RtypeSub;
logic RtypeMul;

assign RtypeSub = funct7b5 &opb5;

// RtypeMul: funct7 bit 0 is 1 AND opb5 is 1 (for M-extension/mul)
assign RtypeMul = funct7b0 & opb5;

always_comb
    case(ALUOp)
        2'b00: ALUControl = 3'b000; // addition
        2'b01: ALUControl = 3'b001; // subtraction
    
default: case(funct3) // R-type or I-type ALU
                3'b000: if (RtypeMul)
                            ALUControl = 3'b110; // MUL (our new case!)
                        else if (RtypeSub)
                            ALUControl = 3'b001; // SUB
                        else    
                            ALUControl = 3'b000; // ADD, ADDI
                3'b010: ALUControl = 3'b101; // SLT, SLTI
                3'b110: ALUControl = 3'b011; // OR, ORI
                3'b111: ALUControl = 3'b010; // AND, ANDI
                default: ALUControl = 3'bxxx; // Unknown

        endcase
    endcase
endmodule    
    
    
//DATAPATH
module datapath(
    input logic clk, reset,
    input logic [1:0] ResultSrc,
    input logic PCSrc, ALUSrc,
    input logic RegWrite,
    input logic [1:0] ImmSrc,
    input logic [2:0] ALUControl,
    output logic Zero,
    output logic [31:0] PC,
    input logic [31:0] Instr,
    output logic [31:0] ALUResult, WriteData,
    input logic [31:0] ReadData
);  
   
logic [31:0] PCNext, PCPlus4, PCTarget;
logic [31:0] ImmExt;
logic [31:0] SrcA, SrcB;
logic [31:0] Result;

//next PC
flopr #(32) pcreg(clk, reset, PCNext, PC);
pc_adder pcadd4(PC, 32'd4, PCPlus4);
pc_adder pcaddbranch(PC, ImmExt, PCTarget);
mux2 #(32) pcmux(PCPlus4, PCTarget, PCSrc, PCNext);

    
//register fiie
 regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20],
 Instr[11:7], Result, SrcA, WriteData);
 extend ext(Instr[31:7], ImmSrc, ImmExt);
 
//ALU
mux2 #(32) srcbmux(WriteData, ImmExt, ALUSrc, SrcB);    
alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
mux3 #(32) resultmux(ALUResult, ReadData, PCPlus4,ResultSrc, Result);
    
    
endmodule
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    