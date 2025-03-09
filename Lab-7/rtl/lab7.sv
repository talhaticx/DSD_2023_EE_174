module lab7 (
    input logic [3:0] num,   // 4-bit input number
    input logic [2:0] sel,   // 3-bit selector
    input logic write,       // Write enable signal
    input logic clk,         // Clock signal
    input logic rst,       // rst signal

    output logic a, b, c, d, e, f, g,                   // 7-segment output
    output logic an0, an1, an2, an3, an4, an5, an6, an7 // Anode control signals
);

    logic [7:0] sel_output;          // One-hot encoded selection output
    logic [7:0][3:0] stored_values;  // Stores 4-bit values for each 7-segment display
    logic [3:0] selected_num;        // Selected stored value for display
    logic [7:0] write_enable;        // Enables writing only when necessary
    logic [3:0] displayed_num;
    logic [7:0] an;
    logic div_clk;
    logic [2:0] counter;
    logic [2:0] sel_sig;

    
    // Generate write enable signals
    always @(posedge clk) begin
        write_enable <= write ? ~sel_output : 8'b00000000; // using ternary operator instead of AND gate 
    end
    

    // Instantiate 8 D Flip-Flops for storage
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : dff_loop
            d_ff dff_inst (
                .clk(clk),
                .rst(rst),
                .write(write_enable[i]),  
                .d(num),                  
                .q(stored_values[i])      
            );
        end
    endgenerate

    
    // Instantiate frequency divider
    freq_div_sim freq_divider_inst (.clk(clk), .rst(rst), .clk_out(div_clk));

    // Instantiate 3-bit counter (use div_clk as input)
    sel_counter sel_counter_inst (.clk(div_clk), .rst(rst), .Q(counter));

    // Instantiate multiplexer to select stored value based on sel
    mux8x1 mux8x1_inst (
        .num(stored_values),  
        .sel(counter),            
        .selected_num(selected_num) 
    );

    mux2x1 mux2x1_inst (.a(counter), .b(sel), .w(write), .o(sel_sig)); 
    
    // Instantiate sel module to get one-hot encoding for selection
    sel sel_decoder (
        .sel(sel_sig),
        .out(sel_output)
    );

    // Only display stored values when write = 0
    assign displayed_num = write ? 4'b1111 : selected_num;
    
    // Convert displayed 4-bit value to 7-segment output
    num num_decoder (
        .num(displayed_num),  
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g) 
    );

    assign an = write ? 8'b1111_1111 : sel_output;
    // Assign anode control signals from sel output
    assign {an7, an6, an5, an4, an3, an2, an1, an0} = an;

endmodule
