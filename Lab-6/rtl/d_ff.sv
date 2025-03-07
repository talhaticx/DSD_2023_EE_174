module d_ff (
    input clk,          // Clock signal
    input reset,          // Active-high synchronous reset
    input write,        // Write enable signal
    input [3:0] d,      // 4-bit Data input
    output reg [3:0] q  // 4-bit Output
);

    always @(posedge clk) begin
        if (reset) 
            q <= 4'b0000;      // Reset Q to 0 on clock edge
        else if (write) 
            q <= d;            // Store D only when write is high
    end

endmodule