`timescale 1ns / 1ps

module sprite_renderer #(parameter SPRITE_W = 10'd8, parameter  SPRITE_H = 10'd8)(
    input  wire [9:0] fb_x,
    input  wire [9:0] fb_y,

    input  wire [9:0] sprite_x,
    input  wire [9:0] sprite_y,

    output wire sprite_active,
    output wire [2:0] local_x,
    output wire [2:0] local_y
    );

assign sprite_active =
    (fb_x >= sprite_x) &&
    (fb_x < (sprite_x + SPRITE_W)) &&
    (fb_y >= sprite_y) &&
    (fb_y < (sprite_y + SPRITE_H));

assign local_x = fb_x - sprite_x;
assign local_y = fb_y - sprite_y;

endmodule
