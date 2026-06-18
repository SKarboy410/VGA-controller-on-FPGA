`timescale 1ns / 1ps

module vertical_counter(
       input pixel_clk,
       input line_done,
       output reg[9:0] V_count_val = 0
    );

//constants
localparam V_VISIBLE = 480;
localparam  V_FRONT = 10;
localparam V_SYNC = 2;
localparam V_BACK = 33;
localparam V_TOTAL = V_VISIBLE + V_FRONT + V_SYNC + V_BACK;
    
 always@(posedge pixel_clk) begin
      if(line_done) begin
        if(V_count_val < V_TOTAL-1)
            V_count_val <= V_count_val + 1;         
         else 
            V_count_val <= 0;
         end
     end
endmodule
