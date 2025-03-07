`timescale 1ns / 1ps

module lab6_tb;
    // Testbench signals
    logic [3:0] num;
    logic [2:0] sel;
    logic write;
    logic reset;
    logic a, b, c, d, e, f, g;
    logic an0, an1, an2, an3, an4, an5, an6, an7;
    
    reg clk; // Clock signal
    integer file;

    // Clock generation
    always #5 clk = ~clk;

    // Instantiate lab6 module
    lab6 dut (
        .num(num),
        .sel(sel),
        .write(write),
        .clk(clk),
        .reset(reset),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),
        .an0(an0), .an1(an1), .an2(an2), .an3(an3),
        .an4(an4), .an5(an5), .an6(an6), .an7(an7)
    );

    // Function to get expected seven-segment display output
    function automatic [6:0] get_expected_segments(input [3:0] num);
        case(num)
            4'h0: get_expected_segments = 7'b0000001;
            4'h1: get_expected_segments = 7'b1001111;
            4'h2: get_expected_segments = 7'b0010010;
            4'h3: get_expected_segments = 7'b0000110;
            4'h4: get_expected_segments = 7'b1001100;
            4'h5: get_expected_segments = 7'b0100100;
            4'h6: get_expected_segments = 7'b0100000;
            4'h7: get_expected_segments = 7'b0001111;
            4'h8: get_expected_segments = 7'b0000000;
            4'h9: get_expected_segments = 7'b0000100;
            4'hA: get_expected_segments = 7'b0001000;
            4'hB: get_expected_segments = 7'b1100000;
            4'hC: get_expected_segments = 7'b0110001;
            4'hD: get_expected_segments = 7'b1000010;
            4'hE: get_expected_segments = 7'b0110000;
            4'hF: get_expected_segments = 7'b0111000;
        endcase
    endfunction

    // Function to get expected selector output
    function automatic [7:0] get_expected_selector(input [2:0] s);
        case (s)
            3'b000: get_expected_selector = 8'b11111110;
            3'b001: get_expected_selector = 8'b11111101;
            3'b010: get_expected_selector = 8'b11111011;
            3'b011: get_expected_selector = 8'b11110111;
            3'b100: get_expected_selector = 8'b11101111;
            3'b101: get_expected_selector = 8'b11011111;
            3'b110: get_expected_selector = 8'b10111111;
            3'b111: get_expected_selector = 8'b01111111;
        endcase
    endfunction

    task automatic write_values(input [3:0] dummy_num, input [2:0] dummy_sel, input int iterations);
        
        num = dummy_num;
        sel = dummy_sel;
        #10;

        // Write values to different locations
        repeat (iterations) begin
            write = 1;
            #10;
            write = 0;
            #10;
            sel = sel + 1;
            num = num + 1;
        end
    endtask

    task read_values(input [3:0] dummy_num, input [2:0] dummy_sel, input int iterations);
         // Read back stored values and validate
        sel = dummy_sel;
        num = dummy_num;
        #10;
        repeat (iterations) begin
            automatic logic [6:0] expected_segment = get_expected_segments(num);
            automatic logic [7:0] expected_sel = get_expected_selector(sel);
            automatic logic [6:0] actual_segment = {a, b, c, d, e, f, g};
            automatic logic [7:0] actual_sel = {an7, an6, an5, an4, an3, an2, an1, an0};
            automatic string result = (actual_segment == expected_segment && actual_sel == expected_sel) ? "PASSED" : "FAILED";
            
            $fdisplay(file, "| %0t  | %b |      %b     |     %b    |     %b    |    %b    | %s |", 
                    $time, sel, expected_segment, actual_segment, expected_sel, actual_sel, result);
            
            if (result == "FAILED")
                $display("\n==========\nTest failed at time %0t: sel=%b, expected_segment=%b, actual_segment=%b, expected_sel=%b, actual_sel=%b\n==========\n", 
                        $time, sel, expected_segment, actual_segment, expected_sel, actual_sel);
            else
                $display("Test passed at time %0t: sel=%b, segment=%b, decoded sel=%b", 
                        $time, sel, actual_segment, actual_sel);

            sel = sel + 1;
            num = num + 1;
            #10;
        end
    endtask

    // Test sequence
    initial begin
        file = $fopen("tb_result.txt", "w");
        $fdisplay(file, "|  Time   | sel | Expected Segment | Actual Segment | Expected Anodes | Actual Anodes  | Result |");

        clk = 0;
        reset = 1;
        write = 0;
        #10;
        reset = 0;

        write_values( 4'd0, 3'd0, 8);  // write num 0 to 7 to ff from 0 to 7

        read_values(4'd0, 3'd0, 8);    // read num 0 to 7 to ff from 0 to 7

        write_values( 4'd8, 3'd0, 8);  // write num 8 to F to ff from 0 to 7

        read_values(4'd8, 3'd0, 8);    // read num 8 to F to ff from 0 to 7
        
        $fclose(file);

        $display("\nTest completed.\n");

        $finish;
    end
endmodule
