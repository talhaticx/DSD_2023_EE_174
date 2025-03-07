module mux(
    input logic [7:0][3:0] num,  // 8 elements, each 4-bit wide
    input logic [2:0] sel,       // 3-bit selection
    output logic [3:0] selected_num
);

    assign selected_num = num[sel];  // Select one 4-bit value from the array

endmodule
