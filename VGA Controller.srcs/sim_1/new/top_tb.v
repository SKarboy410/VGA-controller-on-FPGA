`timescale 1ns / 1ps

module top_tb;

    //====================================================
    // DUT Signals
    //====================================================
    reg sys_clk;

    wire Hsync;
    wire Vsync;

    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;

    //====================================================
    // DUT
    //====================================================
    top DUT (
        .sys_clk(sys_clk),

        .Hsync(Hsync),
        .Vsync(Vsync),

        .red(red),
        .green(green),
        .blue(blue)
    );

    //====================================================
    // 100 MHz System Clock
    //====================================================
    initial begin
        sys_clk = 0;
        forever #5 sys_clk = ~sys_clk;
    end

    //====================================================
    // Simulation Control
    //====================================================
    initial begin

        $display("Starting simulation...");

        // Run for a while
        #5_000_000;

        $display("Finished simulation.");
        $finish;
    end

    //====================================================
    // Waveform Dump
    //====================================================
    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
    end

endmodule