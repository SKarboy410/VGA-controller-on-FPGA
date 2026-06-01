`timescale 1ns / 1ps

module framebuffer(
        input pixel_clock,
        input [9:0] pixel_x,
        input [9:0] pixel_y,
        input video_active,

        output [11:0] pixel_colour
    );

//constants
localparam FB_W = 160;
localparam FB_H = 120;
localparam BUFFER_SIZE = FB_W * FB_H;

wire [7:0] fb_x;
wire [6:0] fb_y;
wire [15:0] address;

//since 640*480 is too large for the BRAM, we scale it down to 160*120
assign fb_x = pixel_x >> 2;
assign fb_y = pixel_y >> 2;

//address formula
assign address = fb_y * FB_W + fb_x;

reg [11:0] framebuffer [0:BUFFER_SIZE-1]; 
reg [11:0] pixel_data;

//initialize framebuffer
integer i;
initial begin
    for(i = 0; i < BUFFER_SIZE; i = i + 1)
        framebuffer[i] = 12'h000;
end

wire valid_pixel;
assign valid_pixel = (fb_x < FB_W && fb_y < FB_H);

always@(posedge pixel_clock) begin
    if(video_active && valid_pixel)
        pixel_data <= framebuffer[address];
    else
        pixel_data <= 12'h000;
end

assign pixel_colour = pixel_data;

endmodule
