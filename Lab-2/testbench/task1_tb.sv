`timescale 1ns / 1ps

module task1_tb;
    // Inputs
    reg a, b, c;
    // Outputs
    wire x, y;

    // Instantiate the DUT (Device Under Test)
    task1 UUT (
        .x(x), 
        .y(y), 
        .a(a), 
        .b(b), 
        .c(c)
    );

    // Test stimulus
    initial begin
        // Monitor outputs
        $monitor("Time=%0t | a=%b b=%b c=%b | x=%b y=%b", $time, a, b, c, x, y);
        
        // Apply test cases
        a = 0; b = 0; c = 0; #10;
        a = 0; b = 0; c = 1; #10;
        a = 0; b = 1; c = 0; #10;
        a = 0; b = 1; c = 1; #10;
        a = 1; b = 0; c = 0; #10;
        a = 1; b = 0; c = 1; #10;
        a = 1; b = 1; c = 0; #10;
        a = 1; b = 1; c = 1; #10;
        
        // End simulation
        $finish;
    end
endmodule
