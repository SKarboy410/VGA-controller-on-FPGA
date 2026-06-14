`timescale 1ns / 1ps

module video_engine(
    input pixel_clk,

    output reg        we,
    output reg [15:0] write_address,
    output reg [11:0] write_data
);

localparam FB_W = 160;
localparam FB_H = 120;

// Framebuffer scan coordinates
reg [9:0] fb_x = 0;
reg [9:0] fb_y = 0;

//--------------------------------------------------
// Sprite renderer
//--------------------------------------------------

wire sprite_active;
wire [2:0] local_x;
wire [2:0] local_y;
wire [11:0] sprite_colour;

reg [9:0] sprite_x = 50;
reg direction = 1'b1;

sprite_renderer SPR (
    .fb_x(fb_x),
    .fb_y(fb_y),

    .sprite_x(sprite_x),
    .sprite_y(10'd20),

    .sprite_active(sprite_active),
    .local_x(local_x),
    .local_y(local_y)
);


//--------------------------------------------------
// Sprite ROM
//--------------------------------------------------
sprite_rom ROM (
    .x(local_x),
    .y(local_y),
    .colour(sprite_colour   )
);

//--------------------------------------------------
// Framebuffer writer
//--------------------------------------------------

always @(posedge pixel_clk) begin

    we <= 1'b1;

    // Current framebuffer address
    write_address <= fb_y * FB_W + fb_x;

    //--------------------------------------------------
    // Draw sprite
    //--------------------------------------------------

    if (sprite_active && sprite_colour != 12'h000)
        write_data <= sprite_colour;
    else
        write_data <= 12'h000;

    //--------------------------------------------------
    // Framebuffer scan
    //--------------------------------------------------

    if (fb_x == FB_W - 1) begin

    fb_x <= 0;

    if (fb_y == FB_H - 1) begin

        fb_y <= 0;

        //----------------------------------
        // Move sprite once per frame
        //----------------------------------

        if (direction) begin
            if (sprite_x >= 152)   // 160 - sprite width
                direction <= 1'b0;
            else
                sprite_x <= sprite_x + 1;

        end
        else begin

            if (sprite_x <= 1)
                direction <= 1'b1;
            else
                sprite_x <= sprite_x - 1;

        end

    end
    else begin

        fb_y <= fb_y + 1;

    end

end
else begin

    fb_x <= fb_x + 1;

end

end

endmodule