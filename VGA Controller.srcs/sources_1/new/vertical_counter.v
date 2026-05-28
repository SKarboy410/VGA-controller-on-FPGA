`timescale 1ns / 1ps

module vertical_counter(
       input clk_25Mhz,
       input enable_V_counter,
       output reg[15:0] V_count_val = 0
    );
    
 always@(posedge clk_25Mhz) begin
      if(enable_V_counter == 1'b1) begin
        if(V_count_val < 524)
            V_count_val <= V_count_val + 1;         
         else 
            V_count_val <= 0;
         end
     end
endmodule
