class alu_xor_sequence extends uvm_sequence #(alu_sequence_item);

    `uvm_object_utils(alu_xor_sequence)
    
    function new(string name = "alu_xor_sequence");
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
        
        req.randomize() with {
            rst == 0;
            Opcode == 3'b100; 
        };
        start_item(req);
        finish_item(req);
        #10;
    endtask
endclass