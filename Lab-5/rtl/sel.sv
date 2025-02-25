module struct_sel(
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

module beh_sel (
    input  logic [2:0] sel,   // 3-bit selection input
    output logic AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7 // Individual outputs
);

    always_comb begin
        // Default all outputs to 1 (active low logic)
        AN0 = 1;
        AN1 = 1;
        AN2 = 1;
        AN3 = 1;
        AN4 = 1;
        AN5 = 1;
        AN6 = 1;
        AN7 = 1;
        
        case (sel)
            3'b000: AN0 = 0;
            3'b001: AN1 = 0;
            3'b010: AN2 = 0;
            3'b011: AN3 = 0;
            3'b100: AN4 = 0;
            3'b101: AN5 = 0;
            3'b110: AN6 = 0;
            3'b111: AN7 = 0;
        endcase
    end
    
endmodule
