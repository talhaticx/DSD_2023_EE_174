// Seven Segment Display [Behavioral Code]
// Input: 4-bit binary number [3:0] nums 
// Output: 7 segments (active low)
//
//      a
//     ---
//  f |   | b
//     -g-
//  e |   | c
//     ---
//      d

module beh_nums (
    input  logic [3:0] nums,   // 4-bit input bus
    output logic a, b, c, d, e, f, g
);

    always @(*) begin
        case (nums)
            4'h0: {a, b, c, d, e, f, g} = 7'b0111111;  // Display 0
            4'h1: {a, b, c, d, e, f, g} = 7'b0000110;  // Display 1
            4'h2: {a, b, c, d, e, f, g} = 7'b1011011;  // Display 2
            4'h3: {a, b, c, d, e, f, g} = 7'b1001111;  // Display 3
            4'h4: {a, b, c, d, e, f, g} = 7'b1100110;  // Display 4
            4'h5: {a, b, c, d, e, f, g} = 7'b1101101;  // Display 5
            4'h6: {a, b, c, d, e, f, g} = 7'b1111101;  // Display 6
            4'h7: {a, b, c, d, e, f, g} = 7'b0000111;  // Display 7
            4'h8: {a, b, c, d, e, f, g} = 7'b1111111;  // Display 8
            4'h9: {a, b, c, d, e, f, g} = 7'b1101111;  // Display 9
            4'hA: {a, b, c, d, e, f, g} = 7'b1110111;  // Display A
            4'hB: {a, b, c, d, e, f, g} = 7'b1111100;  // Display B
            4'hC: {a, b, c, d, e, f, g} = 7'b0111001;  // Display C
            4'hD: {a, b, c, d, e, f, g} = 7'b1011110;  // Display D
            4'hE: {a, b, c, d, e, f, g} = 7'b1111001;  // Display E
            4'hF: {a, b, c, d, e, f, g} = 7'b1110001;  // Display F
            default: {a, b, c, d, e, f, g} = 7'b0000000; // Default (off)
        endcase
    end

endmodule
