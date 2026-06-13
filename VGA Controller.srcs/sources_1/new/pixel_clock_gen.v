`timescale 1ns / 1ps

// Divides the incoming clock by 4
module pixel_clock_gen #(parameter prescaler_val = 1)(
    input wire sys_clk, //100Mhz
    output reg pixel_clk = 0
    );

//precaler value = (given_frequency/(2*desired_frequency)) - 1

reg [31:0] counter_value = 0;
always@(posedge sys_clk)
begin
    if(counter_value == prescaler_val)
    begin
        counter_value <= 0;
        pixel_clk <= ~pixel_clk;    
    end
    else
        counter_value <= counter_value + 1;
end
endmodule
