`timescale 1ns / 1ps

module top(
    input clk,

    output Hsync,
    output Vsync,

    output [3:0] red,
    output [3:0] green,
    output [3:0] blue 
);

wire [9:0] pixel_x;
wire [9:0] pixel_y;

wire video_active;

wire [11:0] pixel_colour;

vga_core VGA(
    .clk(clk),
    .pixel_colour(pixel_colour),

    .Hsync(Hsync),
    .Vsync(Vsync),

    .pixel_x(pixel_x),
    .pixel_y(pixel_y),
    .video_active(video_active),

    .red(red),
    .green(green),
    .blue(blue)
);

framebuffer FB(
    .pixel_clock(clk),
    .pixel_x(pixel_x),
    .pixel_y(pixel_y),
    .video_active(video_active),

    .pixel_colour(pixel_colour)
);


endmodule
