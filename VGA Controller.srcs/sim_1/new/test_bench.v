`timescale 1ns / 1ps

module test_bench();

    // Inputs
    reg clk = 0;

    // Outputs
    wire Hsync;
    wire Vsync;
    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;

    // Instantiate Unit Under Test
    top UUT (
        .clk(clk),
        .Hsync(Hsync),
        .Vsync(Vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );

    // 100 MHz clock generation
    // Period = 10ns
    always #5 clk = ~clk;

    // Simulation control
    initial begin

        $display("Starting VGA Simulation...");

        // Run simulation
        #2000000;

        $display("Simulation Finished.");
        $finish;
    end

    // Debug monitor
    initial begin
        $monitor(
            "TIME=%0t | X=%d | Y=%d | HS=%b | VS=%b | R=%b G=%b B=%b",
            $time,
            UUT.pixel_x,
            UUT.pixel_y,
            Hsync,
            Vsync,
            red,
            green,
            blue
        );
    end

endmodule