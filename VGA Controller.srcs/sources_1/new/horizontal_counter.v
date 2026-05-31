`timescale 1ns / 1ps

module horizontal_counter(
    input clk_25Mhz,
    output reg enable_V_counter = 0,
    output reg[9:0] H_count_val = 0
    );
    
    always@(posedge clk_25Mhz) begin
        if(H_count_val < 799) begin
            H_count_val <= H_count_val + 1;
            enable_V_counter <= 0;
         end
         else begin
            H_count_val <= 0;
            enable_V_counter <= 1;
         end
    end
endmodule
