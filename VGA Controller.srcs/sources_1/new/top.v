`timescale 1ns / 1ps

module top(
       input clk,
       output Hsync,
       output Vsync,
       output [3:0] red,
       output [3:0] green,
       output [3:0] blue
    );
    
wire clk_25M;
wire enable_V_counter;
wire [15:0] H_count_val;
wire [15:0] V_count_val;


clock_divider VGA_clk(clk,clk_25M);
horizontal_counter VGA_horizontal(clk_25M, enable_V_counter, H_count_val);
vertical_counter VGA_vertical(clk_25M, enable_V_counter, V_count_val);

//output
assign Hsync = (H_count_val < 96) ? 1'b1:1'b0;
assign Vsync = (V_count_val < 2) ? 1'b1:1'b0;

//colours
assign red = (H_count_val > 143 && H_count_val < 784 && V_count_val > 34 && V_count_val < 515) ? 4'hF:4'h0;
assign green = (H_count_val > 143 && H_count_val < 784 && V_count_val > 34 && V_count_val < 515) ? 4'hF:4'h0;
assign blue = (H_count_val > 143 && H_count_val < 784 && V_count_val > 34 && V_count_val < 515) ? 4'hF:4'h0;

endmodule
