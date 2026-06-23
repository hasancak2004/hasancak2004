`timescale 1ns / 1ps

module top(
    input  logic        clk, reset,
    output logic [31:0] WriteData, DataAdr,
    output logic        MemWrite
);

    logic [31:0] PC, Instr, ReadData;

    // 1. The Brain: Your RISC-V Processor Core
    riscvsingle rvsingle(
        .clk(clk), 
        .reset(reset), 
        .PC(PC), 
        .Instr(Instr),
        .MemWrite(MemWrite), 
        .ALUResult(DataAdr), 
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    // 2. The ROM: Instruction Memory
    imem imem(
        .a(PC), 
        .rd(Instr)
    );

    // 3. The RAM: Data Memory
    dmem dmem(
        .clk(clk), 
        .we(MemWrite), 
        .a(DataAdr), 
        .wd(WriteData), 
        .rd(ReadData)
    );

endmodule