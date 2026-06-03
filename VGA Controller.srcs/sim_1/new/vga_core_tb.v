`timescale 1ns / 1ps

module vga_core_tb;

//inputs
reg clk;

//outputs
wire Hsync;
wire Vsync;
wire pixel_clock;

wire [9:0] pixel_x;
wire [9:0] pixel_y;
wire video_active;

wire [3:0] red;
wire [3:0] green;
wire [3:0] blue;

//test pixel colour input
reg [11:0] pixel_colour;

//instantiate DUT
vga_core DUT(
    .clk(clk),

    .pixel_colour(pixel_colour),

    .Hsync(Hsync),
    .Vsync(Vsync),

    .pixel_clock(pixel_clock),

    .pixel_x(pixel_x),
    .pixel_y(pixel_y),
    .video_active(video_active),

    .red(red),
    .green(green),
    .blue(blue)
);

//100 MHz clock
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    //default colour
    pixel_colour = 12'h000;

    //wait a little
    #100;

    //red
    pixel_colour = 12'hF00;

    #50000;

    //green
    pixel_colour = 12'h0F0;

    #50000;

    //blue
    pixel_colour = 12'h00F;

    #50000;

    //white
    pixel_colour = 12'hFFF;

    #50000;

    //finish simulation
    $finish;
end

endmodule
