class alu_over_under_flow_sequence extends uvm_sequence #(alu_sequence_item);

    `uvm_object_utils(alu_over_under_flow_sequence)

    function new(string name = "alu_over_under_flow_sequence");
        super.new(name);
    endfunction 

    task body();
        alu_sequence_item req = alu_sequence_item::type_id::create("req");
        
        // Reset
        req.rst = 1;
        start_item(req);
        `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE)
        finish_item(req);
        #10;
        
        // Test overflow: max positive + 1
        req.randomize() with {
            rst == 0;
            Opcode == 3'b000; // ADD operation
            A == 32'h7FFFFFFF; // 2,147,483,647 (max positive)
            B == 32'h00000001; // 1
        };
        start_item(req);
        `uvm_info(get_type_name(), "Testing overflow: 2147483647 + 1", UVM_NONE)
        finish_item(req);
        #10;
        
        // Test underflow: max negative - 1  
        req.randomize() with {
            rst == 0;
            Opcode == 3'b001; // SUB operation
            A == 32'h80000000; // -2,147,483,648 (max negative)
            B == 32'h00000001; // 1
        };
        start_item(req);
        `uvm_info(get_type_name(), "Testing underflow: -2147483648 - 1", UVM_NONE)
        finish_item(req);
        #10;
        
        // Test another overflow case: two large positives
        req.randomize() with {
            rst == 0;
            Opcode == 3'b000; // ADD
            A == 32'h60000000; // Large positive
            B == 32'h30000000; // Another large positive
        };
        start_item(req);
        `uvm_info(get_type_name(), "Testing overflow: large + large", UVM_NONE)
        finish_item(req);
        #10;
    endtask

endclass