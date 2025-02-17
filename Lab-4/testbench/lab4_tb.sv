`timescale 1ns / 1ps

module lab4_tb;
    // Testbench signals
    logic a1, a2, b1, b2;
    logic red, green, blue;

    // Instantiate the DUT (Device Under Test)
    lab4 dut (
        .a1(a1), .a2(a2),
        .b1(b1), .b2(b2),
        .red(red), .green(green), .blue(blue)
    );

    // Driver: Applies stimulus to DUT
    task driver(input int i);
        {a1, a2, b1, b2} = i;  // Apply input
        #10;                   // Wait for DUT response
    endtask

    // Monitor: Observes and prints output
    task monitor;
        $display("%b  %b  %b  %b  |  %b    %b    %b", a1, a2, b1, b2, red, green, blue);
    endtask

    // Testbench process
    initial begin
        $display("A1 A2 B1 B2 | RED GREEN BLUE");

        for (int i = 0; i < 16; i++) begin
            driver(i);  // Apply input
            monitor();  // Capture output
        end

        $finish;
    end
endmodule
