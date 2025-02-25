`timescale 1ns / 1ps

module lab5_tb();
    // Test signals for beh_nums
    logic [3:0] nums;
    logic a, b, c, d, e, f, g;
    
    // Test signals for sel
    logic [2:0] sel;
    logic AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7;
    
    // Test counters
    integer seven_seg_errors = 0;
    integer selector_errors = 0;
    
    // Instantiate both modules separately for clear testing
    beh_nums seven_seg_dut (
        .nums(nums),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g)
    );
    
    beh_sel selector_dut (
        .sel(sel),
        .AN0(AN0), .AN1(AN1), .AN2(AN2), .AN3(AN3),
        .AN4(AN4), .AN5(AN5), .AN6(AN6), .AN7(AN7)
    );
    
    // Expected patterns for seven-segment display (0-F) - Active LOW
    function [6:0] get_expected_segments(input [3:0] num);
        case(num)
            4'h0: return 7'b0000001; // 0
            4'h1: return 7'b1001111; // 1
            4'h2: return 7'b0010010; // 2
            4'h3: return 7'b0000110; // 3
            4'h4: return 7'b1001100; // 4
            4'h5: return 7'b0100100; // 5
            4'h6: return 7'b0100000; // 6
            4'h7: return 7'b0001111; // 7
            4'h8: return 7'b0000000; // 8
            4'h9: return 7'b0000100; // 9
            4'ha: return 7'b0001000; // A
            4'hb: return 7'b1100000; // B
            4'hc: return 7'b0110001; // C
            4'hd: return 7'b1000010; // D
            4'he: return 7'b0110000; // E
            4'hf: return 7'b0111000; // F
        endcase
    endfunction
    
    // Test the seven-segment decoder
    task test_seven_segment();
        automatic logic [6:0] expected;
        automatic logic [6:0] actual;
        
        $display("\n=== Testing Seven Segment Decoder ===");
        for (int i = 0; i <= 15; i++) begin
            nums = i[3:0];
            #10;
            
            expected = get_expected_segments(nums);
            actual = {a,b,c,d,e,f,g};
            
            $write("Testing number %0h: ", i);
            if (actual !== expected) begin
                $display("FAILED");
                $display("Expected: %b", expected);
                $display("Actual:   %b", actual);
                seven_seg_errors++;
            end else begin
                $display("PASSED");
            end
        end
    endtask
    
    // Expected output for selector based on the truth table
    function [7:0] get_expected_selector(input [2:0] s);
        case (s)
            3'b000: return 8'b11111110;
            3'b001: return 8'b11111101;
            3'b010: return 8'b11111011;
            3'b011: return 8'b11110111;
            3'b100: return 8'b11101111;
            3'b101: return 8'b11011111;
            3'b110: return 8'b10111111;
            3'b111: return 8'b01111111;
        endcase
    endfunction
    
    // Test the display selector
    task test_selector();
        automatic logic [7:0] expected;
        automatic logic [7:0] actual;
        
        $display("\n=== Testing Display Selector ===");
        for (int i = 0; i < 8; i++) begin
            sel = i[2:0];
            #10;
            
            expected = get_expected_selector(sel);
            actual = {AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0};
            
            $write("Testing sel %b: ", sel);
            if (actual !== expected) begin
                $display("FAILED");
                $display("Expected: %b", expected);
                $display("Actual:   %b", actual);
                selector_errors++;
            end else begin
                $display("PASSED");
            end
        end
    endtask
    
    initial begin
        // Initialize inputs
        nums = 4'b0000;
        sel = 3'b000;
        #10;
        
        // Test each module separately
        test_seven_segment();
        test_selector();
        
        // Display final results
        $display("\n=== Test Summary ===");
        $display("Seven Segment Decoder errors: %0d", seven_seg_errors);
        $display("Display Selector errors: %0d", selector_errors);
        
        if (seven_seg_errors == 0 && selector_errors == 0)
            $display("ALL TESTS PASSED SUCCESSFULLY!");
        else
            $display("SOME TESTS FAILED!");
            
        #100 $stop;
    end

endmodule
