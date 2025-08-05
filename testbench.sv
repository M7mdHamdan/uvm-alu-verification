`include "uvm_macros.svh"
import uvm_pkg::*;

`include "package/alu_pkg.sv"
import alu_pkg::*;

module alu_testbench;
    logic clk, rst;
    always #5 clk = ~clk;
    
    alu_interface alu_if(clk, rst);

    alu dut (
        .clk(alu_if.clk),
        .rst(alu_if.rst),
        .A(alu_if.A),
        .B(alu_if.B),
        .Opcode(alu_if.Opcode),
        .Result(alu_if.Result),
        .Error(alu_if.Error)
    );

    initial begin
        uvm_config_db#(virtual alu_interface)::set(uvm_root::get(), "*", "vif", alu_if);
    end

    initial begin
        run_test("alu_random_test");
    end

    initial begin
        clk = 0;
        rst = 0;
        #10 rst = 1; 
        #10 rst = 0;
    end

    initial begin
        $shm_open("waves.shm",1);
        $shm_probe("AS");
        
    end

    initial begin
        $display("simulation finished");
        #10000000000000000000000000000; 
        $finish; 
    end
endmodule