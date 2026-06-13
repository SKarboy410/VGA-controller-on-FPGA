`timescale 1ns / 1ps

module video_engine(
    input pixel_clk,

    output reg we,
    output reg [15:0] write_address,
    output reg [11:0] write_data
);

localparam FB_W = 160;
localparam FB_H = 120;

reg [7:0] x = 0;
reg [6:0] y = 0;

// Start near right edge so bounce is visible quickly
reg [7:0] rect_x = 135;

// 1 = moving right, 0 = moving left
reg direction = 1;

always @(posedge pixel_clk) begin

    // Always writing
    we <= 1'b1;

    // Current framebuffer address
    write_address <= y * FB_W + x;

    // Draw rectangle
    if ((x >= rect_x) && (x < rect_x + 20) &&
        (y >= 20)     && (y < 60))
    begin
        if(direction)
            write_data <= 12'hF00; // red
        else
            write_data <= 12'h00F; // blue
    end
    else
        write_data <= 12'h000;

    //--------------------------------------------------
    // Framebuffer scan
    //--------------------------------------------------
    if (x == FB_W - 1) begin
        x <= 0;

        if (y == FB_H - 1) begin
            y <= 0;

            //--------------------------------------------------
            // Move rectangle once per framebuffer update
            //--------------------------------------------------
            if (direction) begin
                write_data <= 12'hF00;
                if (rect_x >= 140)
                    direction <= 0;
                else
                    rect_x <= rect_x + 1;
            end
            else begin
                if (rect_x <= 2)
                    direction <= 1;
                else
                    rect_x <= rect_x - 1;
            end     

        end
        else begin
            y <= y + 1;
        end
    end
    else begin
        x <= x + 1;
    end

end

endmodule