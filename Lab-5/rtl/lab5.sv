module lab5(
    input  logic [3:0] nums,     // 4-bit input for seven segment display
    input  logic [2:0] sel,      // 3-bit input for display selection
    output logic a, b, c, d, e, f, g,  // Seven segment display outputs
    output logic AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7  // Digit enable outputs
);

    // Instantiate the seven segment decoder module
    struct_nums seven_seg_decoder (
        .nums(nums),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g)
    );

    // Instantiate the display selector module
    sel display_selector (
        .sel(sel),
        .AN0(AN0),
        .AN1(AN1),
        .AN2(AN2),
        .AN3(AN3),
        .AN4(AN4),
        .AN5(AN5),
        .AN6(AN6),
        .AN7(AN7)
    );

endmodule