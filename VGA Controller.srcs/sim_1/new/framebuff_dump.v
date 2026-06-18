`timescale 1ns / 1ps

module framebuff_dump;

reg pixel_clk = 0;

wire we;
wire [15:0] write_address;
wire [11:0] write_data;

wire [9:0] sprite_x;
wire [9:0] sprite_y;

reg reg_we;
reg [1:0] reg_addr;
reg [31:0] reg_wdata;

// framebuffer read side not needed
wire [11:0] pixel_colour;

framebuffer FB (
    .pixel_clk(pixel_clk),

    .pixel_x(10'd0),
    .pixel_y(10'd0),
    .video_active(1'b0),

    .we(we),
    .write_address(write_address),
    .write_data(write_data),

    .pixel_colour(pixel_colour)
);

sprite_reg REG(
    .clk(pixel_clk),

    .reg_we(reg_we),
    .reg_addr(reg_addr),
    .reg_wdata(reg_wdata),

    .reg_rdata(reg_rdata),

    .sprite_x(sprite_x),
    .sprite_y(sprite_y)
);

video_engine VE (
    .pixel_clk(pixel_clk),

    .sprite_x(sprite_x),
    .sprite_y(sprite_y),

    .we(we),
    .write_address(write_address),
    .write_data(write_data)
);

always #20 pixel_clk = ~pixel_clk;

task dump_fb;
    input integer frame_num;

    integer file;
    integer addr;
    reg [255:0] filename;

    begin
        $sformat(filename, "frame_%0d.txt", frame_num);

        file = $fopen(filename, "w");

        for(addr = 0; addr < 19200; addr = addr + 1)
            $fdisplay(file, "%03h", FB.framebuffer[addr]);

        $fclose(file);
    end
endtask

integer i;

initial begin

    // write x
    reg_addr  = 0;
    reg_wdata = 80;
    reg_we    = 1;
    #40;
    reg_we    = 0;

    // write y
    reg_addr  = 1;
    reg_wdata = 60;
    reg_we    = 1;
    #40;
    reg_we    = 0;

    // read x
    reg_addr = 0;
    #1;
    $display("x = %0d", reg_rdata);

    // read y
    reg_addr = 1;
    
    for(i = 0; i < 30; i = i + 1) begin
        #2000000;
        dump_fb(i);
    end

    for(i = 0; i < 30; i = i + 1) begin
        #2000000;
        dump_fb(i);
    end

    $finish;

end

endmodule