// Seven Segment Display [Structural Code]
// Input: 4-bit binary number [3:0] nums (n1 is MSB, n4 is LSB)
// Output: 7 segments (active low)
//
//      a
//     ---
//  f |   | b
//     -g-
//  e |   | c
//     ---
//      d


module struct_nums (
    input  logic [3:0] nums,   // 4-bit input bus
    output logic a, b, c, d, e, f, g
);

    // For better readability, create wire aliases for the inputs
    wire n1 = nums[3];    // MSB
    wire n2 = nums[2];
    wire n3 = nums[1];
    wire n4 = nums[0];    // LSB

    // Implementing each boolean equation using continuous assignments
    wire n1_not, n2_not, n3_not, n4_not;

    not (n1_not, n1);
    not (n2_not, n2);
    not (n3_not, n3);
    not (n4_not, n4);

    
    // a = n1'n2'n3'n4 + n1'n2n3'n4' + n1n2n3'n4 + n1n2'n3n4
    assign a = (n1_not & n2_not & n3_not & n4) |
                (n1_not & n2 & n3_not & n4_not) | 
                (n1 & n2 & n3_not & n4) |
                (n1 & n2_not & n3 & n4);

    // b = n1n2n4' + n1n3n4 + n2n3n4' + n1'n2n3'n4
                assign b = (n1 & n2 & n4_not) |
                (n1 & n3 & n4) |
                (n2 & n3 & n4_not) |
                (n1_not & n2 & n3_not & n4);

    // c = n1n2n4' + n1n2n3 + n1'n2'n3n4'
    assign c = (n1 & n2 & n4_not) |
               (n1 & n2 & n3) |
               (n1_not & n2_not & n3 & n4_not);

    // d = n2n3n4 + n1'n2'n3'n4 + n1'n2n3'n4' + n1n2'n3n4'
    assign d = (n2 & n3 & n4) |
               (n1_not & n2_not & n3_not & n4) |
               (n1_not & n2 & n3_not & n4_not) |
               (n1 & n2_not & n3 & n4_not);

    // e = n1'n4 + n1'n2n3' + n2'n3'n4
    assign e = (n1_not & n4) |
               (n1_not & n2 & n3_not) |
               (n2_not & n3_not & n4);

    // f = n1'n2'n4 + n1'n2'n3 + n1'n3n4 + n1n2n3'n4
    assign f = (n1_not & n2_not & n4) |
               (n1_not & n2_not & n3) |
               (n1_not & n3 & n4) |
               (n1 & n2 & n3_not & n4);

    // g = n1'n2'n3' + n1'n2n3n4 + n1n2n3'n4'
    assign g = (n1_not & n2_not & n3_not) |
               (n1_not & n2 & n3 & n4) |
               (n1 & n2 & n3_not & n4_not);

endmodule