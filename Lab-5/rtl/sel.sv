module sel(
    input  logic [2:0] sel,  // 3-bit selection input
    output logic AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7
);
    // Corrected decoder equations
    assign AN0 = ~(~sel[2] & ~sel[1] & ~sel[0]);
    assign AN1 = ~(~sel[2] & ~sel[1] &  sel[0]);
    assign AN2 = ~(~sel[2] &  sel[1] & ~sel[0]);
    assign AN3 = ~(~sel[2] &  sel[1] &  sel[0]);
    assign AN4 = ~( sel[2] & ~sel[1] & ~sel[0]);
    assign AN5 = ~( sel[2] & ~sel[1] &  sel[0]);
    assign AN6 = ~( sel[2] &  sel[1] & ~sel[0]);
    assign AN7 = ~( sel[2] &  sel[1] &  sel[0]);
endmodule