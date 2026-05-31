`timescale 1ns / 1ps

module top(
       input clk,
       output Hsync,
       output Vsync,
       output [3:0] red,
       output [3:0] green,
       output [3:0] blue
    );

//constants
localparam H_VISIBLE = 640;
localparam  H_FRONT = 16;
localparam H_SYNC = 96;
localparam H_BACK = 48;
localparam H_TOTAL = H_VISIBLE + H_FRONT + H_SYNC + H_BACK;

localparam V_VISIBLE = 480;
localparam  V_FRONT = 10;
localparam V_SYNC = 2;
localparam V_BACK = 33;
localparam V_TOTAL = V_VISIBLE + V_FRONT + V_SYNC + V_BACK;


wire clk_25M;
wire enable_V_counter;
wire [9:0] H_count_val;
wire [9:0] V_count_val;

wire video_active;
wire [9:0] pixel_x;
wire [9:0] pixel_y;


clock_divider VGA_clk(clk,clk_25M);
horizontal_counter VGA_horizontal(clk_25M, enable_V_counter, H_count_val);
vertical_counter VGA_vertical(clk_25M, enable_V_counter, V_count_val);

//sync regions
assign Hsync = (H_count_val >= H_VISIBLE + H_FRONT && H_count_val < H_VISIBLE + H_FRONT + H_VISIBLE) ? 1'b0:1'b1; 
assign Vsync = (V_count_val >= V_VISIBLE + V_FRONT && V_count_val < V_VISIBLE + V_FRONT +  V_VISIBLE) ? 1'b0:1'b1;

// pixels
assign pixel_x = H_count_val;
assign pixel_y = V_count_val;

//active video region
assign video_active = (pixel_x < H_VISIBLE && pixel_y < V_VISIBLE);

//define pretty colours and patterns
//checker board experiment

wire checker;

assign checker = pixel_x[5] ^ pixel_y[5];

assign red = checker ? 4'b1111 : 4'b0000;
assign green = checker ? 4'b1111 : 4'b0000;
assign blue = checker ? 4'b1111 : 4'b0000;

endmodule
