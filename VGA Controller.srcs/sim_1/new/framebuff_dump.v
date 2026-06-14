`timescale 1ns / 1ps

module framebuff_dump;

reg pixel_clk = 0;

wire we;
wire [15:0] write_address;
wire [11:0] write_data;

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

video_engine VE (
    .pixel_clk(pixel_clk),

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

    for(i = 0; i < 30; i = i + 1) begin
        #2000000;
        dump_fb(i);
    end

    $finish;

end

endmodule