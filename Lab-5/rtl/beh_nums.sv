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
    input logic [3:0] nums,   // 4-bit input bus
    output logic a, b, c, d, e, f, g
);

    always_comb begin
        case (nums)
            4'h0: {a, b, c, d, e, f, g} = 7'b0000001;
            4'h1: {a, b, c, d, e, f, g} = 7'b1001111;
            4'h2: {a, b, c, d, e, f, g} = 7'b0010010;
            4'h3: {a, b, c, d, e, f, g} = 7'b0000110;
            4'h4: {a, b, c, d, e, f, g} = 7'b1001100;
            4'h5: {a, b, c, d, e, f, g} = 7'b0100100;
            4'h6: {a, b, c, d, e, f, g} = 7'b0100000;
            4'h7: {a, b, c, d, e, f, g} = 7'b0001111;
            4'h8: {a, b, c, d, e, f, g} = 7'b0000000;
            4'h9: {a, b, c, d, e, f, g} = 7'b0000100;
            4'hA: {a, b, c, d, e, f, g} = 7'b0001000;
            4'hB: {a, b, c, d, e, f, g} = 7'b1100000;
            4'hC: {a, b, c, d, e, f, g} = 7'b0110001;
            4'hD: {a, b, c, d, e, f, g} = 7'b1000010;
            4'hE: {a, b, c, d, e, f, g} = 7'b0110000;
            4'hF: {a, b, c, d, e, f, g} = 7'b0111000;
            default: {a, b, c, d, e, f, g} = 7'b1111111; // Default case
        endcase
    end

endmodule
