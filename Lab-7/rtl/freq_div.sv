module freq_div (
    input logic clk,     // 100 MHz clock input
    input logic rst,     // Active-high rst
    output logic clk_out // 100 Hz output clock
);

    logic [19:0] count = 0; // 20-bit counter (log2(500000) ≈ 19.93)

    // 1/100M = 10 ns
    // 1/100 = 10 ms
    // toggle per cycle = 2

    // (10ms/10ns * 2) = 5_00_000 cycles

    always_ff @(posedge clk) begin
        if (rst) begin
            count <= 0;
            clk_out <= 0;
        end 
        else if (count == 499_999) begin
            count <= 0;
            clk_out <= ~clk_out; // Toggle output
        end 
        else begin
            count <= count + 1;
        end
    end

endmodule

module freq_div_sim (
    input logic clk,      // Input clock
    input logic rst,      // Active-high rst
    output logic clk_out  // Output clock (clk/8)
);

    logic [2:0] count = 3'b000; // Ensure count is initialized

    always_ff @(posedge clk) begin
        if (rst) begin
            count <= 3'b000;
            clk_out <= 0; // Ensure output resets properly
        end 
        else if (count == 3'b111) begin
            count <= 3'b000;
            clk_out <= ~clk_out;
        end 
        else begin
            count <= count + 1;
        end
    end    

endmodule
