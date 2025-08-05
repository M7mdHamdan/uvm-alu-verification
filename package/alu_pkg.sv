`ifndef ALU_PKG_SV
`define ALU_PKG_SV

// Include interface and design files before the package
`include "interfaces/alu_interface.sv"
`include "design/ALU.sv"

package alu_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // Include all files in order
    `include "components/alu_sequence_item.sv"
    `include "components/alu_sequencer.sv"
    `include "components/alu_driver.sv"
    `include "components/alu_monitor.sv"
    `include "components/alu_scoreboard.sv"
    `include "components/alu_subscriber.sv"
    `include "components/alu_agent.sv"
    `include "components/alu_enviroment.sv"
    
    // Include sequences
    `include "sequences/ALU_random_sequence.sv"
    `include "sequences/ALU_add_sequence.sv"
    `include "sequences/ALU_sub_sequence.sv"
    `include "sequences/ALU_and_sequence.sv"
    `include "sequences/ALU_or_sequence.sv"
    `include "sequences/ALU_xor_sequence.sv"
    `include "sequences/ALU_over_under_flow_sequence.sv"
    `include "sequences/ALU_undefined_opcode_sequence.sv"

endpackage

// Include test files after the package
`include "tests/alu_random_test.sv"
`include "tests/alu_regression_test.sv"

`endif
