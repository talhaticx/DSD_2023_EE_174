module mux (
    input  logic [7:0][3:0] num, // 8 inputs, each 4-bit
    input  logic [2:0] sel,      // 3-bit selector
    output logic [3:0] selected_num // 4-bit output
);

    always_comb begin
        case (sel)
            3'b000: selected_num = num[0];
            3'b001: selected_num = num[1];
            3'b010: selected_num = num[2];
            3'b011: selected_num = num[3];
            3'b100: selected_num = num[4];
            3'b101: selected_num = num[5];
            3'b110: selected_num = num[6];
            3'b111: selected_num = num[7];
            default: selected_num = 4'b0000;
        endcase
    end

endmodule
