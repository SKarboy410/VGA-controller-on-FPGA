`timescale 1ns / 1ps

module framebuffer(
    input pixel_clock,
    input [9:0] pixel_x,
    input [9:0] pixel_y,
    input video_active,

    output [11:0] pixel_colour
);


//====================================================
// Framebuffer Configuration
//====================================================
localparam FB_W        = 160;
localparam FB_H        = 120;
localparam BUFFER_SIZE = FB_W * FB_H;


//====================================================
// Internal Signals
//====================================================
wire [9:0]  fb_x;
wire [9:0]  fb_y;
wire [15:0] fb_address;

wire fb_visible;
wire fb_read_enable;

reg [11:0] pixel_data;


//====================================================
// Coordinate Scaling
//
// Scale 640x480 VGA coordinates to a 160x120
// framebuffer to reduce BRAM usage.
//====================================================
assign fb_x = pixel_x >> 2;
assign fb_y = pixel_y >> 2;



//====================================================
// Framebuffer Visibility
//====================================================
assign fb_visible =
    (fb_x < FB_W) &&
    (fb_y < FB_H);



//====================================================
// Framebuffer Address Generation
//====================================================
assign fb_address = (fb_y * FB_W) + fb_x;



//====================================================
// Framebuffer Read Control
//====================================================
assign fb_read_enable =
    video_active &&
    fb_visible;



//====================================================
// Framebuffer Memory
//====================================================
reg [11:0] framebuffer [0:BUFFER_SIZE-1];



// Initialize framebuffer to black
integer i;
initial begin
    for(i = 0; i < BUFFER_SIZE; i = i + 1)
        framebuffer[i] = 12'h000;
end


//====================================================
// Pixel Read Pipeline
//
// Matches BRAM behaviour
//====================================================
always @(posedge pixel_clock) begin
    if(fb_read_enable)
        pixel_data <= framebuffer[fb_address];
    else
        pixel_data <= 12'h000;
end

//====================================================
// Pixel Output
//====================================================
assign pixel_colour = pixel_data;

endmodule