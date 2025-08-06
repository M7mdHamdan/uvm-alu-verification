# UVM ALU Verification

A comprehensive SystemVerilog UVM testbench for verifying an Arithmetic Logic Unit (ALU) design.

## Overview

This project implements a complete UVM-based verification environment for a 32-bit ALU with support for basic arithmetic and logical operations. The testbench includes various test scenarios to verify functionality, error handling, and edge cases.

## Project Structure

```
├── design/
│   └── alu.sv                      # ALU design under test (DUT)
├── interfaces/
│   └── alu_interface.sv            # SystemVerilog interface for ALU signals
├── components/
│   ├── alu_sequence_item.sv        # Transaction object
│   ├── alu_sequencer.sv            # UVM sequencer
│   ├── alu_driver.sv               # UVM driver
│   ├── alu_monitor.sv              # UVM monitor
│   ├── alu_scoreboard.sv           # UVM scoreboard
│   ├── alu_subscriber.sv           # UVM subscriber
│   ├── alu_agent.sv                # UVM agent
│   └── alu_environment.sv          # UVM environment
├── sequences/
│   ├── ALU_random_sequence.sv      # Random operation sequence
│   ├── ALU_add_sequence.sv         # Addition operation tests
│   ├── ALU_sub_sequence.sv         # Subtraction operation tests
│   ├── ALU_and_sequence.sv         # AND operation tests
│   ├── ALU_or_sequence.sv          # OR operation tests
│   ├── ALU_xor_sequence.sv         # XOR operation tests
│   ├── ALU_over_under_flow_sequence.sv # Overflow/underflow tests
│   └── ALU_undefined_opcode_sequence.sv # Invalid opcode tests
├── tests/
│   ├── alu_random_test.sv          # Random test case
│   └── alu_regression_test.sv      # Regression test suite
├── package/
│   └── alu_pkg.sv                  # UVM package with all includes
├── testbench.sv                    # Top-level testbench module
└── .gitignore                      # Git ignore file for simulation artifacts
```

## Features

- **Complete UVM Environment**: Full UVM testbench with agent, driver, monitor, and scoreboard
- **Comprehensive Test Coverage**: Multiple test sequences covering all ALU operations
- **Error Detection**: Overflow, underflow, and invalid opcode handling
- **Modular Design**: Well-organized file structure for easy maintenance
- **Professional Structure**: Industry-standard UVM methodology

## ALU Operations

The ALU supports the following operations:
- Addition (ADD)
- Subtraction (SUB)
- Bitwise AND
- Bitwise OR
- Bitwise XOR
- Error handling for overflow/underflow conditions
- Invalid opcode detection

## Getting Started

### Prerequisites

- SystemVerilog simulator (Xcelium, VCS, Questa, etc.)
- UVM library support

### Running Tests

1. Compile the design and testbench:
```bash
# Example for Xcelium
xrun -uvm testbench.sv +UVM_TESTNAME=alu_random_test
```

2. Run specific test:
```bash
xrun -uvm testbench.sv +UVM_TESTNAME=alu_regression_test
```

### Test Options

- `alu_random_test`: Runs random operations on the ALU
- `alu_regression_test`: Comprehensive test suite covering all operations

## File Descriptions

### Core Components
- **testbench.sv**: Top-level module that instantiates DUT and runs UVM tests
- **alu_pkg.sv**: Main package file that includes all UVM components and tests

### UVM Components
- **alu_sequence_item**: Defines transaction properties (operands, opcode, results)
- **alu_driver**: Drives stimulus to the DUT through the interface
- **alu_monitor**: Observes DUT behavior and collects coverage
- **alu_scoreboard**: Checks DUT outputs against expected results
- **alu_agent**: Contains driver, monitor, and sequencer
- **alu_environment**: Top-level UVM environment

### Test Sequences
- **Random Sequence**: Generates random valid operations
- **Directed Sequences**: Target specific operations (ADD, SUB, AND, OR, XOR)
- **Corner Case Sequences**: Test overflow, underflow, and invalid opcodes
