`timescale 1ns / 1ps

module lab4(
    input logic a1, a2, b1, b2,
    output logic red, green, blue
    );

    logic [1:0] a, b;

    assign a = {a1, a2};  // a1 -> MSB, a2 -> LSB
    assign b = {b1, b2};  // b1 -> MSB, b2 -> LSB

    // Red LED Logic
    assign red = (~b1 & (~b2 | a2)) | (a1 & (a2 | ~b1 | ~b2));

    // Green LED Logic
    assign green = (~a1 & (b2 | b1 | ~a2)) | (b1 & (b2 | ~a2));

    // Blue LED Logic
    assign blue = (a1 ^ b1) | (a2 ^ b2);

endmodule
