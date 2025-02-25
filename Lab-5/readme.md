# Lab 5: Seven Segment Display and Selector

## Overview
This project implements a **seven-segment display decoder** and a **display selector** using **structural and behavioral Verilog**. It also includes a **testbench** for verifying functionality.

## Modules

### 1. `struct_nums`
- **Functionality:** Converts a 4-bit binary number into a **seven-segment display** output.
- **Inputs:**
  - `nums` (4-bit) → Represents the binary number to be displayed.
- **Outputs:**
  - `a, b, c, d, e, f, g` → Seven-segment segments (active low).

### 2. `struct_sel`
- **Functionality:** Selects which **display digit** is active (active low outputs).
- **Inputs:**
  - `sel` (3-bit) → Determines which display is active.
- **Outputs:**
  - `AN0-AN7` → Active-low control signals for each digit.

### 3. `beh_sel`
- **Functionality:** Same as `struct_sel`, but implemented **behaviorally** using a `case` statement.

### 4. `lab5`
- **Top-level module** that instantiates `beh_nums` and `beh_sel`.
- **Inputs:**
  - `nums` (4-bit) → Binary number for display.
  - `sel` (3-bit) → Selects active digit.
- **Outputs:**
  - `a-g` → Seven-segment control.
  - `AN0-AN7` → Digit selection.

## Testbench (`lab5_tb.sv`)
- Tests the **seven-segment decoder** and **display selector**.
- Uses a **functional verification approach** to compare actual vs. expected results.
- **Key features:**
  - **Tests all 16 values (0-F) for the seven-segment decoder.**
  - **Validates selector behavior based on a predefined truth table.**
  - **Reports errors if outputs do not match expected values.**

## How to Run
1. **Compile the Verilog files** using a simulator like ModelSim, VCS, or Xilinx Vivado.
   ```sh
   vlog lab5.sv lab5_tb.sv
   ```
2. **Run the testbench**:
   ```sh
   vsim lab5_tb
   run -all
   ```
3. **Check results:**
   - If all tests pass, you’ll see a success message.
   - If errors occur, the mismatched values will be displayed.

## Expected Output
- The seven-segment display should correctly show **0-F** in active-low logic.
- The display selector should activate the correct **AN0-AN7** signals per the truth table.

## Truth Table for Selector (`beh_sel`)

| `sel[2:0]` | AN0 | AN1 | AN2 | AN3 | AN4 | AN5 | AN6 | AN7 |
|------------|----|----|----|----|----|----|----|----|
| 000        |  0 |  1 |  1 |  1 |  1 |  1 |  1 |  1 |
| 001        |  1 |  0 |  1 |  1 |  1 |  1 |  1 |  1 |
| 010        |  1 |  1 |  0 |  1 |  1 |  1 |  1 |  1 |
| 011        |  1 |  1 |  1 |  0 |  1 |  1 |  1 |  1 |
| 100        |  1 |  1 |  1 |  1 |  0 |  1 |  1 |  1 |
| 101        |  1 |  1 |  1 |  1 |  1 |  0 |  1 |  1 |
| 110        |  1 |  1 |  1 |  1 |  1 |  1 |  0 |  1 |
| 111        |  1 |  1 |  1 |  1 |  1 |  1 |  1 |  0 |

## Notes
- **Active low outputs:** Segments and digit selectors use active-low logic (`0` means ON, `1` means OFF).
- **Can be simulated on FPGA:** Works with common FPGA boards with **seven-segment displays**.
