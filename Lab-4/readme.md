# Tri-Color LED Comparator

## Overview
This project implements a digital comparator using a tri-color RGB LED on the Nexys A7 FPGA. The LED color indicates the relationship between two 2-bit binary numbers (`a` and `b`):
- **Purple** (Red + Blue) if `a > b`
- **Yellow** (Red + Green) if `a == b`
- **Cyan** (Green + Blue) if `a < b`

The implementation uses SystemVerilog for the design and testbench, ensuring correctness through simulation before deploying to hardware.

## Hardware Details
### FPGA Pin Mapping
The RGB LED and input signals are mapped as follows:
| Signal | FPGA Pin | Description |
|--------|---------|-------------|
| Red | N16 | LED Red Component |
| Green | R11 | LED Green Component |
| Blue | G14 | LED Blue Component |
| a1 | J15 | MSB of a |
| a2 | L16 | LSB of a |
| b1 | M13 | MSB of b |
| b2 | R15 | LSB of b |

## Truth Table
Below is the truth table used to derive the Boolean logic for LED control:

| No. | a1 | a2 | b1 | b2 | Color  | R | G | B |
|----|----|----|----|----|--------|---|---|---|
| 0  | 0  | 0  | 0  | 0  | Yellow | 1 | 1 | 0 |
| 1  | 0  | 0  | 0  | 1  | Cyan   | 0 | 1 | 1 |
| 2  | 0  | 0  | 1  | 0  | Cyan   | 0 | 1 | 1 |
| 3  | 0  | 0  | 1  | 1  | Cyan   | 0 | 1 | 1 |
| 4  | 0  | 1  | 0  | 0  | Purple | 1 | 0 | 1 |
| 5  | 0  | 1  | 0  | 1  | Yellow | 1 | 1 | 0 |
| 6  | 0  | 1  | 1  | 0  | Cyan   | 0 | 1 | 1 |
| 7  | 0  | 1  | 1  | 1  | Cyan   | 0 | 1 | 1 |
| 8  | 1  | 0  | 0  | 0  | Purple | 1 | 0 | 1 |
| 9  | 1  | 0  | 0  | 1  | Purple | 1 | 0 | 1 |
| 10 | 1  | 0  | 1  | 0  | Yellow | 1 | 1 | 0 |
| 11 | 1  | 0  | 1  | 1  | Cyan   | 0 | 1 | 1 |
| 12 | 1  | 1  | 0  | 0  | Purple | 1 | 0 | 1 |
| 13 | 1  | 1  | 0  | 1  | Purple | 1 | 0 | 1 |
| 14 | 1  | 1  | 1  | 0  | Purple | 1 | 0 | 1 |
| 15 | 1  | 1  | 1  | 1  | Yellow | 1 | 1 | 0 |

## Approach
1. **Define Inputs and Outputs:**
   - Inputs: Two 2-bit numbers (`a` and `b`)
   - Outputs: Red, Green, and Blue control signals for the RGB LED

2. **Logic Derivation:**
   - Use the truth table to derive Boolean expressions for each LED component.
   - Optimize expressions using Karnaugh Maps (K-maps).

3. **SystemVerilog Implementation:**
   - Implement the logic equations in a SystemVerilog module.
   - Assign input bits correctly and use combinational logic for LED control.

4. **Testing with a Testbench:**
   - Apply all possible combinations of inputs in a testbench.
   - Verify that the LED colors match the expected outputs from the truth table.

5. **Synthesis and Deployment:**
   - Load the bitstream onto the FPGA.
   - Observe LED behavior and validate correctness.

## Conclusion
This project demonstrates digital comparison using combinational logic and FPGA-based control of an RGB LED. The implementation follows an industrial standard approach with Boolean logic derivation, testbench validation, and hardware deployment.

