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

    logic print;

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

    function [3:0] segment_to_hex(input [6:0] segments);
        case(segments)
            7'b0000001: return 4'h0; // 0
            7'b1001111: return 4'h1; // 1
            7'b0010010: return 4'h2; // 2
            7'b0000110: return 4'h3; // 3
            7'b1001100: return 4'h4; // 4
            7'b0100100: return 4'h5; // 5
            7'b0100000: return 4'h6; // 6
            7'b0001111: return 4'h7; // 7
            7'b0000000: return 4'h8; // 8
            7'b0000100: return 4'h9; // 9
            7'b0001000: return 4'hA; // A
            7'b1100000: return 4'hB; // B
            7'b0110001: return 4'hC; // C
            7'b1000010: return 4'hD; // D
            7'b0110000: return 4'hE; // E
            7'b0111000: return 4'hF; // F
            default: return 4'hX; // Invalid pattern
        endcase
    endfunction


    // Clock Generation
    always #5 clk = ~clk;  // 10ns clock period

    // Monitor Statements (Prints signals during simulation)
    always @( a, b, c, d, e, f, g, an7, an6, an5, an4, an3, an2, an1, an0) begin
        #1;
        if (write == 0 & writing == 0 & print == 1) begin
            $display("Time: %0t | Write: %b  | Segments: %b%b%b%b%b%b%b (%h)| Anodes: %b%b%b%b%b%b%b%b", 
                      $time, write, a, b, c, d, e, f, g, segment_to_hex({a, b, c, d, e, f, g}), an7, an6, an5, an4, an3, an2, an1, an0 );
        end
    end

    // Task for Writing Values
    task automatic write_values(input [3:0] start_num, input [2:0] start_sel, input int iterations);
        writing <= 1;
        num <= start_num;
        sel <= start_sel;
        @(posedge clk);
        repeat (iterations) begin
            write <= 1;
            @(posedge clk);
            write <= 0;
            @(posedge clk);
            sel <= sel + 1;
            num <= num + 1;
        end
        writing <= 0;
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

        print = 0;

        // Reset System
        @(posedge clk);
        rst <= 1;
        @(posedge clk);
        rst <= 0;

        $display("Setting values of ff from 0 to 7 as 0 to 7");

        // Step 1: Store values 0 to 7 in FFs
        write_values(4'b0000, 3'b000, 8);

        while ( an7 ) begin
            #1;
        end
        
        print <= ~print;

        // Step 2: Display stored values
        write <= 0;
        repeat (140) @(posedge clk); // Allow enough time for all segments to cycle

        $display("Setting values of ff from 0 to 7 as 8 to F");

        print <= ~print;

        // Step 3: Store values 8 to F in FFs
        write_values(4'b1000, 3'b000, 8);

        while ( an7 ) begin
            #1;
        end
        
        print <= ~print;
        
        // Step 4: Display stored values
        write <= 0;
        repeat (140) @(posedge clk); // Allow time for display cycle

        $stop;  // End simulation
    end
endmodule