`timescale 1ns / 1ps

//Unused and replaced by AXI and microblaze

module sprite_reg(
    input clk,

    input reg_we,
    input [2:0] reg_addr,
    input [31:0] reg_wdata,

    output reg [31:0] reg_rdata,

    output reg sprite_enable = 1'b1,

    output reg[9:0] sprite_x = 50,
    output reg[9:0] sprite_y = 20

);

always @(posedge clk) begin
    if(reg_we) begin
        case(reg_addr)
            3'd0: sprite_x <= reg_wdata[9:0];
            3'd1: sprite_y <= reg_wdata[9:0];
            3'd2: sprite_enable <= reg_wdata[0];
        endcase
    end
end

always @(*) begin
    case(reg_addr)
        3'd0: reg_rdata = {22'd0, sprite_x};
        3'd1: reg_rdata = {22'd0, sprite_y};
        3'd2: reg_rdata = {31'd0, sprite_enable};
        default: reg_rdata = 32'd0;
    endcase
end


endmodule
