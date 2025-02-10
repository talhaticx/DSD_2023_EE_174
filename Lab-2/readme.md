# DSD LAB 2

## Task 1

Implemented the code of the circuit.

[Task 1 rtl](/Lab-2/rtl/task1.sv)
[Task 1 testbench](/Lab-2/testbench/task1_tb.sv)

![Simulation Output](/Lab-2/docs/task1.png)

it matches the exact output of the truth table

| a | b | c |  x | y |
|---|---|---|----|---|
| 0 | 0 | 0 | 1  | 0 |
| 0 | 0 | 1 | 0  | 0 |
| 0 | 1 | 0 | 0  | 0 |
| 0 | 1 | 1 | 1  | 0 |
| 1 | 0 | 0 | 0  | 0 |
| 1 | 0 | 1 | 1  | 0 |
| 1 | 1 | 0 | 0  | 1 |
| 1 | 1 | 1 | 1  | 1 |

## Task 2

### RTL

Original Code

```verilog
module full_adder(
    input logic a,
    input logic b,
    input logic c,
    output logic sum,
    output logic carry,
  );

  sum = (a ^ b) ^ c;
  assign carry = (a & b) | (c(a ^ b));

endmodule
```

Corrected Code

```verilog
module full_adder(
    input logic a,
    input logic b,
    input logic c,
    output logic sum,
    output logic carry
  );

  assign sum = (a ^ b) ^ c; <----------------------
  assign carry = (a & b) | (c & (a ^ b)); <---------------------

endmodule

```

**Changes:**

1. added assign before sum.
2. & added in the carry's logic

---

### Testbench

Original Code

```verilog
module full_adder_tb();
logic a1;
logic b1;
logic c1;
logic sum1;
full_adder (
.a(a1),
.b(b1),
.c(c1),
.sum(sum1),
.carry(carry1)
);
initial
begin
// Provide different combinations of the inputs to check validity of code
a = 0; b = 0; c = 0;
#10;
a1 = 0; b1 = 0; c = 1;
#10;
a1 = 0; b1 = 1; c1 = 0;
#10;
a1 = 0; b = 1; c1 = 1;
#10;
a1 = 1; b1 = 0; c1 = 0;
#10;
a1 = 1; b1 = 0; c1 = 1;
#10;
a = 1; b1 = 1; c1 = 0;
#10
a1 = 1; b1 = 1; c1 = 1;
#10;
$stop;
endmodule
```

Corrected Code

```verilog
module full_adder_tb();
    logic a1;
    logic b1;
    logic c1;
    logic sum1;
    logic carry1; <--------------------------

    full_adder UUT ( <---------------------
        .a(a1),
        .b(b1),
        .c(c1),
        .sum(sum1),
        .carry(carry1)
    );

    initial begin
        
        // Provide different combinations of the inputs to check validity of code
        a1 = 0; b1 = 0; c1 = 0;
        #10;
        a1 = 0; b1 = 0; c1 = 1;
        #10;
        a1 = 0; b1 = 1; c1 = 0;
        #10;
        a1 = 0; b1 = 1; c1 = 1;
        #10;
        a1 = 1; b1 = 0; c1 = 0;
        #10;
        a1 = 1; b1 = 0; c1 = 1;
        #10;
        a1 = 1; b1 = 1; c1 = 0;
        #10;
        a1 = 1; b1 = 1; c1 = 1;
        #10;
        $stop;

    end <------------
endmodule
```

**Changes:**

1. Added Carry1 logic variable
2. Added UUT instance correctly
3. Corrected a, b and c to a1, b1 and c1 in the initial block
4. Added end for initial block

Implemented the code of the circuit.

[Task 2 rtl](/Lab-2/rtl/task2.sv)
[Task 2 testbench](/Lab-2/testbench/task2_tb.sv)

![Simulation Output](/Lab-2/docs/task2.png)

it matches the exact output of the truth table

## Full Adder Truth Table

| **a** | **b** | **c** | **sum** | **carry** |
|:-----:|:-----:|:-----------:|:-------:|:---------:|
|   0   |   0   |      0      |    0    |     0     |
|   0   |   0   |      1      |    1    |     0     |
|   0   |   1   |      0      |    1    |     0     |
|   0   |   1   |      1      |    0    |     1     |
|   1   |   0   |      0      |    1    |     0     |
|   1   |   0   |      1      |    0    |     1     |
|   1   |   1   |      0      |    0    |     1     |
|   1   |   1   |      1      |    1    |     1     |

The Logic Gate Diagram of this circuit is given in

[Diagram](/Lab-2/docs/task2.drawio)

![Diagram](/Lab-2/docs/task2_diagram.png)
