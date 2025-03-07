module lab6 (
    input logic [3:0] num,   // 4-bit input number
    input logic [2:0] sel,   // 3-bit selector
    input logic write,       // Write enable signal
    input logic clk,         // Clock signal
    input logic reset,         // Reset signal

    output logic a, b, c, d, e, f, g, // 7-segment output
    output logic an0, an1, an2, an3, an4, an5, an6, an7 // Anode control signals
);

    logic [7:0] sel_output;          // One-hot encoded selection output
    logic [7:0][3:0] stored_values;  // Stores 4-bit values for each 7-segment display
    logic [3:0] selected_num;        // Selected stored value for display
    logic [7:0] write_enable;        // Enables writing only when necessary

    // Instantiate sel module to get one-hot encoding for selection
    sel sel_decoder (
        .sel(sel),
        .out(sel_output)
    );

    // Generate write enable signals
    assign write_enable = write & ~sel_output;

    // Instantiate 8 D Flip-Flops for storage
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : dff_loop
            d_ff dff_inst (
                .clk(clk),
                .reset(reset),
                .write(write_enable[i]),  
                .d(num),                  
                .q(stored_values[i])      
            );
        end
    endgenerate

    // Instantiate multiplexer to select stored value based on sel
    mux mux_inst (
        .num(stored_values),  
        .sel(sel),            
        .selected_num(selected_num) 
    );

    // Only display stored values when write = 0
    logic [3:0] displayed_num;
    assign displayed_num = (write == 0) ? selected_num : 4'b1111; // Show nothing when write = 1

    // Convert displayed 4-bit value to 7-segment output
    num num_decoder (
        .num(displayed_num),  
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g) 
    );

    // Assign anode control signals from sel output
    assign {an7, an6, an5, an4, an3, an2, an1, an0} = sel_output | write;

endmodule
