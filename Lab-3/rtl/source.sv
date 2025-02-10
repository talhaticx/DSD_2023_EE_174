`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UET, Lahore 
// Engineer: Muhammad Talha Ayyaz
// 
// Create Date: 01/28/2025 10:40:50 AM
// Design Name: LAB 3
// Target Devices: Nexys A7-100T
//////////////////////////////////////////////////////////////////////////////////


module lab3(output x, y,
    input a, b, c
    );
    assign x = (a | b) ^ ~c;
    assign y = ( a | b ) & ( ( ~ ( a & b )) ^ ( a | b ) );

endmodule