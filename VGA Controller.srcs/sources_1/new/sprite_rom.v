`timescale 1ns / 1ps

module sprite_rom(
    input [2:0] x,
    input [2:0] y,

    output reg [11:0] colour
    );

always @(*) begin
    colour = 12'h000;

    case(y)
        3'd0: if(x >= 2 && x <= 5) colour = 12'hFF0;

        3'd1: if(x >= 1 && x <= 6) colour = 12'hFF0;

        3'd2: begin
            if(x >= 1 && x <= 6) colour = 12'hFF0;
            if(x == 2 || x == 5) colour = 12'h000; // eyes
        end

        3'd3: begin
            if(x >= 1 && x <= 6) colour = 12'hFF0;
        end

        3'd4: begin
            if(x >= 1 && x <= 6) colour = 12'hFF0;
        end

        3'd5: begin
            if(x >= 1 && x <= 6) colour = 12'hFF0;
            if(x == 2 || x == 5) colour = 12'h000; // mouth corners
        end

        3'd6: begin
            if(x >= 2 && x <= 5) colour = 12'hFF0;
            if(x >= 3 && x <= 4) colour = 12'h000; // smile
        end

        3'd7: if(x >= 2 && x <= 5) colour = 12'hFF0;
    endcase
end

endmodule
