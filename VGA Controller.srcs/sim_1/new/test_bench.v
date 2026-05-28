`timescale 1ns / 1ps

module test_bench();

reg clk = 0;
wire Hsync;
wire Vsync;
wire [3:0] red;
wire [3:0] green;
wire [3:0] blue;


top UUT(clk, Hsync, Vsync, red, green, blue);

always #5 clk = ~clk;
 
endmodule
