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
wire pixel_clk;

wire fb_we;
wire [15:0] fb_write_address;
wire [11:0] fb_write_data;

vga_core VGA(
    .sys_clk(sys_clk),
    .pixel_colour(pixel_colour),

    .Hsync(Hsync),
    .Vsync(Vsync),

    .pixel_x(pixel_x),
    .pixel_y(pixel_y),
    .video_active(video_active),

    .pixel_clk(pixel_clk),

    .red(red),
    .green(green),
    .blue(blue)
);

framebuffer FB(
    .pixel_clk(pixel_clk),
    .pixel_x(pixel_x),
    .pixel_y(pixel_y),
    .video_active(video_active),

    .we(fb_we),
    .write_address(fb_write_address),
    .write_data(fb_write_data),

    .pixel_colour(pixel_colour)
);

video_engine VE(
    .pixel_clk(pixel_clk),

    .we(fb_we),
    .write_address(fb_write_address),
    .write_data(fb_write_data)
);


endmodule
