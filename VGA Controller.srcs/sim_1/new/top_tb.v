`timescale 1ns / 1ps

module top_tb;

    //====================================================
    // DUT signals
    //====================================================
    reg clk;

    wire Hsync;
    wire Vsync;

    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;

    //====================================================
    // Instantiate DUT
    //====================================================
    top DUT (
        .clk(clk),

        .Hsync(Hsync),
        .Vsync(Vsync),

        .red(red),
        .green(green),
        .blue(blue)
    );

    //====================================================
    // Clock generation
    // 100 MHz clock -> 10ns period
    //====================================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

endmodule