`timescale 1ns / 1ps

module testbench();

    logic        clk;
    logic        reset;
    logic [31:0] WriteData, DataAdr;
    logic        MemWrite;

    // 1. Instantiate the Top-Level System
    top dut(clk, reset, WriteData, DataAdr, MemWrite);

    // 2. Generate the Clock Signal (Every 5ns, toggle the clock)
    always begin
        clk <= 1; #5; 
        clk <= 0; #5;
    end

    // 3. Initial Reset Pulse
    initial begin
        reset <= 1; #22; 
        reset <= 0;
    end

    // 4. Check results
    // This part monitors memory writes to see if the program finished.
    always @(negedge clk) begin
        if (MemWrite) begin
            // In the textbook program, writing 25 to address 100 means SUCCESS
            if (DataAdr === 100 & WriteData === 25) begin
                $display("Simulation Succeeded");
                $stop;
            end else if (DataAdr !== 96) begin
                $display("Simulation Failed");
                $stop;
            end
        end
    end

endmodule