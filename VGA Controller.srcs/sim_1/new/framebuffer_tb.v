`timescale 1ns / 1ps

module framebuffer_tb;

//--------------------------------------------------
// INPUTS
//--------------------------------------------------
reg pixel_clk;
reg [9:0] pixel_x;
reg [9:0] pixel_y;
reg video_active;

// Write port
reg we;
reg [15:0] write_address;
reg [11:0] write_data;

//--------------------------------------------------
// OUTPUTS
//--------------------------------------------------
wire [11:0] pixel_colour;

//--------------------------------------------------
// DUT
//--------------------------------------------------
framebuffer DUT(
    .pixel_clk(pixel_clk),

    .pixel_x(pixel_x),
    .pixel_y(pixel_y),
    .video_active(video_active),

    .we(we),
    .write_address(write_address),
    .write_data(write_data),

    .pixel_colour(pixel_colour)
);

//--------------------------------------------------
// CLOCK
//--------------------------------------------------
initial begin
    pixel_clk = 0;
end

always begin
    #20 pixel_clk = ~pixel_clk;
end

//--------------------------------------------------
// MONITOR
//--------------------------------------------------
initial begin
    $monitor(
        "t=%0t x=%0d y=%0d active=%b colour=%h",
        $time,
        pixel_x,
        pixel_y,
        video_active,
        pixel_colour
    );
end

//--------------------------------------------------
// TEST
//--------------------------------------------------
initial begin

    //----------------------------------------------
    // initialize write port
    //----------------------------------------------
    we            = 0;
    write_address = 0;
    write_data    = 0;

    //----------------------------------------------
    // preload framebuffer memory
    //----------------------------------------------
    DUT.framebuffer[0]  = 12'hF00; // red
    DUT.framebuffer[1]  = 12'h0F0; // green
    DUT.framebuffer[2]  = 12'h00F; // blue
    DUT.framebuffer[10] = 12'hFFF; // white

    //----------------------------------------------
    // initial values
    //----------------------------------------------
    pixel_x = 0;
    pixel_y = 0;
    video_active = 0;

    #100;

    //----------------------------------------------
    // TEST 1 : address 0
    //----------------------------------------------
    video_active = 1;
    pixel_x = 0;
    pixel_y = 0;

    #80;

    //----------------------------------------------
    // TEST 2 : address 1
    //----------------------------------------------
    pixel_x = 4;
    pixel_y = 0;

    #80;

    //----------------------------------------------
    // TEST 3 : address 2
    //----------------------------------------------
    pixel_x = 8;
    pixel_y = 0;

    #80;

    //----------------------------------------------
    // TEST 4 : address 10
    //----------------------------------------------
    pixel_x = 40;
    pixel_y = 0;

    #80;

    //----------------------------------------------
    // TEST 5 : video inactive
    //----------------------------------------------
    video_active = 0;

    #80;

    //----------------------------------------------
    // finish
    //----------------------------------------------
    $finish;

end

endmodule