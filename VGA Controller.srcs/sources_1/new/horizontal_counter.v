`timescale 1ns / 1ps

module horizontal_counter(
    input pixel_clk,
    output reg line_done = 0,
    output reg[9:0] H_count_val = 0
    );

//constants
localparam H_VISIBLE = 640;
localparam  H_FRONT = 16;
localparam H_SYNC = 96;
localparam H_BACK = 48;
localparam H_TOTAL = H_VISIBLE + H_FRONT + H_SYNC + H_BACK;
    
    always@(posedge pixel_clk) begin
        if(H_count_val < H_TOTAL-1) begin
            H_count_val <= H_count_val + 1;
            line_done <= 0;
         end
         else begin
            H_count_val <= 0;
            line_done <= 1;
         end
    end
endmodule
