`timescale 1ns / 1ps

module top_tb;

    // 100 MHz system clock
    reg clk = 0;

    // VGA outputs
    wire Hsync;
    wire Vsync;

    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;

    // Instantiate DUT
    top DUT (
        .clk(clk),

        .Hsync(Hsync),
        .Vsync(Vsync),

        .red(red),
        .green(green),
        .blue(blue)
    );

    // Generate 100 MHz clock
    always #5 clk = ~clk;

    // Simulation runtime
    initial begin

        // Run long enough for several frames
        #20000000;

        $finish;
    end

endmodule