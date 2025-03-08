module sel_counter (
    input logic clk,    
    input logic rst,    
    output logic [2:0] Q 
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 3'b000;
        else 
            Q <= Q + 1'b1;
    end

endmodule
