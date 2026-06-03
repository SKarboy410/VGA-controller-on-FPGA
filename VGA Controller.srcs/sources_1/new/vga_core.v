`timescale 1ns / 1ps

module vga_core(
    input clk,

    input [11:0] pixel_colour,

    output Hsync,
    output Vsync,

    output pixel_clock,

    output [9:0] pixel_x,
    output [9:0] pixel_y,
    output video_active,

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


wire line_done;
wire [9:0] H_count_val;
wire [9:0] V_count_val;


pixel_clock_gen VGA_clk(.clk(clk),.divided_clk(pixel_clock));
horizontal_counter VGA_horizontal(.pixel_clock(pixel_clock), .line_done(line_done), .H_count_val(H_count_val));
vertical_counter VGA_vertical(.pixel_clock(pixel_clock), .line_done(line_done), .V_count_val(V_count_val));

//sync regions
assign Hsync = (H_count_val >= H_VISIBLE + H_FRONT && H_count_val < H_VISIBLE + H_FRONT + H_SYNC) ? 1'b0:1'b1; 
assign Vsync = (V_count_val >= V_VISIBLE + V_FRONT && V_count_val < V_VISIBLE + V_FRONT +  V_SYNC) ? 1'b0:1'b1;

// pixels
assign pixel_x = H_count_val;
assign pixel_y = V_count_val;

//active video region
assign video_active = (pixel_x < H_VISIBLE && pixel_y < V_VISIBLE);

// address and pixel clocks will be synced by introducing a delay in the vga core
reg [9:0] pixel_x_d = 0;
reg [9:0] pixel_y_d = 0;
reg video_active_d = 0;

always @(posedge pixel_clock) begin
    pixel_x_d <= pixel_x;
    pixel_y_d <= pixel_y;
    video_active_d <= video_active;
end

//colours
assign red   = video_active_d ? pixel_colour[11:8] : 4'b0000;
assign green = video_active_d ? pixel_colour[7:4]  : 4'b0000;
assign blue  = video_active_d ? pixel_colour[3:0]  : 4'b0000;


endmodule
