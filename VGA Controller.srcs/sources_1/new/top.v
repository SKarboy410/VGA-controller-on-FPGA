`timescale 1ns / 1ps

module top(
    input sys_clk,

    output Hsync,
    output Vsync,

    output [3:0] red,
    output [3:0] green,
    output [3:0] blue 
);

wire [9:0] pixel_x;
wire [9:0] pixel_y;

// wire [9:0] sprite_x;
// wire [9:0] sprite_y;
// wire sprite_enable;

wire [9:0] cpu_sprite_x;
wire [9:0] cpu_sprite_y;
wire cpu_sprite_enable;

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

// sprite_reg REG(
//     .clk(pixel_clk),

//     .sprite_x(sprite_x),
//     .sprite_y(sprite_y)
// );

design_1_sv soc(
    .clk_in1_0(sys_clk),

    .reset_0(1'b0),
    .ext_reset_in_0(1'b0),

    .sprite_x_0(cpu_sprite_x),
    .sprite_y_0(cpu_sprite_y),
    .sprite_enable_0(cpu_sprite_enable)

);

video_engine VE(
    .pixel_clk(pixel_clk),

    .sprite_x(cpu_sprite_x),
    .sprite_y(cpu_sprite_y),
    .sprite_enable(cpu_sprite_enable),

    .we(fb_we),
    .write_address(fb_write_address),
    .write_data(fb_write_data)
);


endmodule
