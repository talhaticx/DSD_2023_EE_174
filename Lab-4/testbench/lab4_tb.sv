`timescale 1ns / 1ps

module lab4_tb;
  logic a1, a2, b1, b2;
  logic red, green, blue;

  // Instantiate the DUT (Device Under Test)
  lab4 dut (
    .a1(a1), .a2(a2),
    .b1(b1), .b2(b2),
    .red(red), .green(green), .blue(blue)
  );

  // Driver Task: Generates Inputs
  task driver(input logic [1:0] a, input logic [1:0] b);
    {a1, a2} = a;  
    {b1, b2} = b;
  endtask

  // Monitor Task: Checks Outputs
  task monitor();
    #1;
    $display("Input: A=%b B=%b | Output: R=%b G=%b B=%b", {a1, a2}, {b1, b2}, red, green, blue);
  endtask

  // Directed Test: Specific Values from the Truth Table
  task directed_test();
    logic [1:0] test_a, test_b;
    for (test_a = 0; test_a < 4; test_a++) begin
      for (test_b = 0; test_b < 4; test_b++) begin
        driver(test_a, test_b);
        #5; 
        monitor();
      end
    end
  endtask

  // Random Test: Generate Random Inputs
  task random_test();
    repeat (10) begin
      driver($random % 4, $random % 4);
      #5;
      monitor();
    end
  endtask

  // Run Testbench
  initial begin
    $display("=== Directed Test ===");
    directed_test();

    $display("\n=== Random Test ===");
    random_test();

    $finish;
  end
endmodule
