`timescale 1ns/1ps

// 340 ns

module lab5_tb;
    // Test signals
    logic [3:0] nums;
    logic [2:0] sel;
    logic a, b, c, d, e, f, g;
    logic AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7;
    
    // Instantiate DUT
    lab5 DUT (
        .nums(nums),
        .sel(sel),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),
        .AN0(AN0), .AN1(AN1), .AN2(AN2), .AN3(AN3),
        .AN4(AN4), .AN5(AN5), .AN6(AN6), .AN7(AN7)
    );

    // Test case and error counters
    int test_count = 0;
    int error_count = 0;

    // Arrays for expected values
    logic [6:0] segment_patterns [16] = '{
        7'b0000001, // 0
        7'b1001111, // 1
        7'b0010010, // 2
        7'b0000110, // 3
        7'b1001100, // 4
        7'b0100100, // 5
        7'b0100000, // 6
        7'b0001111, // 7
        7'b0000000, // 8
        7'b0000100, // 9
        7'b0001000, // A
        7'b1100000, // B
        7'b0110001, // C
        7'b1000010, // D
        7'b0110000, // E
        7'b0111000  // F
    };

    logic [7:0] anode_patterns [8] = '{
        8'b11111110, // AN0 active
        8'b11111101, // AN1 active
        8'b11111011, // AN2 active
        8'b11110111, // AN3 active
        8'b11101111, // AN4 active
        8'b11011111, // AN5 active
        8'b10111111, // AN6 active
        8'b01111111  // AN7 active
    };

    // Task to check seven segment outputs
    task check_segments(input [3:0] num_val);
        logic [6:0] expected_segments;
        logic [6:0] actual_segments;
        string test_status;
        
        test_count++;
        
        expected_segments = segment_patterns[num_val];
        actual_segments = {a,b,c,d,e,f,g};
        
        if (actual_segments === expected_segments) begin
            test_status = "PASSED";
        end else begin
            test_status = "FAILED";
            error_count++;
            $display("\n[%0t] SEVEN SEGMENT TEST %0d: FAILED", $time, test_count);
            $display("Input number: 4'h%h", num_val);
            $display("Expected segments (abcdefg): %b", expected_segments);
            $display("Actual segments   (abcdefg): %b", actual_segments);
        end
        
        $display("[%0t] Seven Segment Test %0d: nums=4'h%h -> %s", 
                 $time, test_count, num_val, test_status);
    endtask

    // Task to check anode outputs
    task check_anodes(input [2:0] sel_val);
        logic [7:0] expected_anodes;
        logic [7:0] actual_anodes;
        string test_status;
        
        test_count++;
        
        expected_anodes = anode_patterns[sel_val];
        actual_anodes = {AN7,AN6,AN5,AN4,AN3,AN2,AN1,AN0};
        
        if (actual_anodes === expected_anodes) begin
            test_status = "PASSED";
        end else begin
            test_status = "FAILED";
            error_count++;
            $display("\n[%0t] ANODE SELECT TEST %0d: FAILED", $time, test_count);
            $display("Select value: 3'b%b", sel_val);
            $display("Expected anodes (AN7-AN0): %b", expected_anodes);
            $display("Actual anodes   (AN7-AN0): %b", actual_anodes);
        end
        
        $display("[%0t] Anode Select Test %0d: sel=3'b%b -> %s", 
                 $time, test_count, sel_val, test_status);
    endtask

    // Main test process
    initial begin
        // Print test header
        $display("\n============================================");
        $display("Seven Segment Display System Testbench");
        $display("Date: 2025-02-23 17:37:51 UTC");
        $display("User: talhaticx");
        $display("============================================\n");

        // Initialize inputs
        nums = 4'h0;
        sel = 3'b000;
        #10;

        // Test 1: Seven Segment Decoder Tests
        $display("\n--- Testing Seven Segment Decoder ---");
        sel = 3'b000; // Keep one display active
        for (int i = 0; i < 16; i++) begin
            nums = i[3:0];
            #10;
            check_segments(nums);
        end

        // Test 2: Display Selector Tests
        $display("\n--- Testing Display Selector ---");
        nums = 4'h0; // Keep a fixed number displayed
        for (int i = 0; i < 8; i++) begin
            sel = i[2:0];
            #10;
            check_anodes(sel);
        end

        // Print test summary
        $display("\n============================================");
        $display("Test Summary:");
        $display("Total Tests Run: %0d", test_count);
        $display("Tests Passed:    %0d", test_count - error_count);
        $display("Tests Failed:    %0d", error_count);
        $display("============================================");

        if (error_count == 0)
            $display("\nTESTBENCH PASSED ALL TESTS!");
        else
            $display("\nTESTBENCH FAILED!");

        $display("\nSimulation completed at time %0t", $time);
        $display("============================================\n");
        
        #100 $stop;
    end


endmodule