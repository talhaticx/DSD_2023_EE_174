`timescale 1ns / 1ps

module lab7_tb;
    // Testbench Signals
    logic [3:0] num;
    logic [2:0] sel;
    logic write;
    logic clk;
    logic rst;
    
    logic a, b, c, d, e, f, g;
    logic an0, an1, an2, an3, an4, an5, an6, an7;

    logic writing;

    // Instantiate lab7 module
    lab7 dut (
        .num(num),
        .sel(sel),
        .write(write),
        .clk(clk),
        .rst(rst),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),
        .an0(an0), .an1(an1), .an2(an2), .an3(an3),
        .an4(an4), .an5(an5), .an6(an6), .an7(an7)
    );

    // Clock Generation
    always #5 clk = ~clk;  // 10ns clock period

    // Monitor Statements (Prints signals during simulation)
    always @( a, b, c, d, e, f, g, an7, an6, an5, an4, an3, an2, an1, an0) begin
        if (write == 0 & writing == 0) begin
            $display("Time: %0t | Write: %b  | Segments: %b%b%b%b%b%b%b | Anodes: %b%b%b%b%b%b%b%b", 
                     $time, write, a, b, c, d, e, f, g, an7, an6, an5, an4, an3, an2, an1, an0);
        end
    end    

    // Task for Writing Values
    task automatic write_values(input [3:0] start_num, input [2:0] start_sel, input int iterations);
        num = start_num;
        sel = start_sel;
        writing = 1;

        // Write values to different locations
        repeat (iterations) begin
            write = 1;
            #10;
            write = 0;
            #10;
            sel = sel + 1;
            num = num + 1;
        end
        writing = 0;
    endtask

    // Test Sequence
    initial begin
        // Initialize Signals
        clk = 0;
        rst = 1;
        write = 0;
        num = 4'b0000;
        sel = 3'b000;
        writing = 0;

        // Reset System
        #10 rst = 1;
        #10 rst = 0;

        // Step 1: Store values 0 to 7 in FFs
        write_values(4'b0000, 3'b000, 8);

        // Step 2: Display stored values
        write = 0;
        #1600;  // Allow enough time for all segments to cycle

        // Step 3: Store values 8 to F in FFs
        write_values(4'b1000, 3'b000, 8);

        // Step 4: Display stored values
        write = 0;
        #1600;  // Allow time for display cycle

        $stop;  // End simulation
    end
endmodule
