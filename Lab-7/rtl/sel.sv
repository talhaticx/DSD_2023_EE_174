module sel (
    input  logic [2:0] sel,     // 3-bit selection input
    output logic [7:0] out      // 8-bit output
);

    always_comb begin
        out = 8'b1111_1111;     // Default all outputs to 1 (active low logic)
        out[sel] = 0;           // Set selected bit to 0
    end
    
endmodule

// =================================================================
//                       Previous Code
// =================================================================

// module sel (
//     input  logic [2:0] sel,   // 3-bit selection input
//     output logic o0, o1, o2, o3, o4, o5, o6, o7 // Individual outputs
// );

//     always_comb begin
//         // Default all outputs to 1 (active low logic)
//         o0 = 1;
//         o1 = 1;
//         o2 = 1;
//         o3 = 1;
//         o4 = 1;
//         o5 = 1;
//         o6 = 1;
//         o7 = 1;
        
//         case (sel)
//             3'b000: o0 = 0;
//             3'b001: o1 = 0;
//             3'b010: o2 = 0;
//             3'b011: o3 = 0;
//             3'b100: o4 = 0;
//             3'b101: o5 = 0;
//             3'b110: o6 = 0;
//             3'b111: o7 = 0;
//         endcase
//     end
    
// endmodule