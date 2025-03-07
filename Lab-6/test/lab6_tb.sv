`timescale 1ns / 10ps

module lab6_tb();
    logic [3:0] num;   // 4-bit input number
    logic [2:0] sel;   // 3-bit selector
    logic write;       // Write enable signal
    logic reset;       // Reset signal
    logic a, b, c, d, e, f, g;                      // 7-segment output
    logic an0, an1, an2, an3, an4, an5, an6, an7;   // Anode control signals

    reg clk; // Clock signal

    initial begin
        clk = 0;
        reset = 0;
    end

    // Generating clock signal
    always #5 clk = ~clk;

    lab6 dut (
        .num  (num  ),
        .sel  (sel  ),
        .write(write),
        .clk  (clk  ),
        .reset(reset),
        .a    (a    ),
        .b    (b    ),
        .c    (c    ),
        .d    (d    ),
        .e    (e    ),
        .f    (f    ),
        .g    (g    ),
        .an0  (an0  ),
        .an1  (an1  ),
        .an2  (an2  ),
        .an3  (an3  ),
        .an4  (an4  ),
        .an5  (an5  ),
        .an6  (an6  ),
        .an7  (an7  )
    );

    // Function to get expected seven-segment display output
    function [6:0] get_expected_segments(input [3:0] num);
        case(num)
            4'h0: return 7'b0000001;
            4'h1: return 7'b1001111;
            4'h2: return 7'b0010010;
            4'h3: return 7'b0000110;
            4'h4: return 7'b1001100;
            4'h5: return 7'b0100100;
            4'h6: return 7'b0100000;
            4'h7: return 7'b0001111;
            4'h8: return 7'b0000000;
            4'h9: return 7'b0000100;
            4'ha: return 7'b0001000;
            4'hb: return 7'b1100000;
            4'hc: return 7'b0110001;
            4'hd: return 7'b1000010;
            4'he: return 7'b0110000;
            4'hf: return 7'b0111000;
        endcase
    endfunction

    // Function to get expected selector output
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

    task edgecheck();
        @(posedge clk);
    endtask

    integer file;

    task test();
        automatic logic [6:0] expected_segment;
        automatic logic [6:0] actual_segment;
        automatic logic [7:0] expected_sel;
        automatic logic [7:0] actual_sel;
        
        logic [3:0] stored_values [7:0]; // Array to track expected stored values

        $display("Starting Test...");

        // Open file to save results
        file = $fopen("lab6_output.txt", "w");

        // Apply reset
        reset = 1;
        edgecheck();
        #10 reset = 0;


        for (int i = 0; i < 8; i++) begin
            num = i;
            sel = i;
            write = 1;
            edgecheck();
            #10;
            write = 0;
            edgecheck();
            stored_values[i] = num; // Store the expected value
            #10;

        end
        

        write = 0;
        edgecheck();
        #10;
        

        $fdisplay(file, "|  Time  | sel | Expected Segment | Actual Segment | Expected Anodes | Actual Anodes |");

        // Reading back values and checking outputs
        for (int i = 0; i < 8; i++) begin
            sel = i;
            edgecheck();
            #10;

            expected_segment = get_expected_segments(stored_values[i]); // Use stored value
            actual_segment = {a, b, c, d, e, f, g};

            expected_sel = get_expected_selector(sel);
            actual_sel = {an7, an6, an5, an4, an3, an2, an1, an0};

            // Log results
            $fdisplay(file, "| %0t  | %b |      %b     |     %b    |     %b    |    %b    |",
                    $time, sel, expected_segment, actual_segment, expected_sel, actual_sel);

            // Check if the outputs match expectations
            if (expected_segment !== actual_segment) begin
                $display("ERROR: Segment mismatch at sel=%b, Expected: %b, Got: %b", sel, expected_segment, actual_segment);
            end
            if (expected_sel !== actual_sel) begin
                $display("ERROR: Anode mismatch at sel=%b, Expected: %b, Got: %b", sel, expected_sel, actual_sel);
            end
        end

        // Close file
        $fclose(file);

        $display("Test Completed!");
        $stop;
    endtask

    initial begin
        #10;
        test();
    end

endmodule
