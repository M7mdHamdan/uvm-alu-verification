class alu_regression_test extends uvm_test;
    alu_environment enviroment;
    alu_add_sequence add_sequence;
    alu_sub_sequence sub_sequence;
    alu_and_sequence and_sequence;
    alu_or_sequence or_sequence;
    alu_xor_sequence xor_sequence;
    alu_over_under_flow_sequence over_under_sequence;
    alu_undefined_opcode_sequence undef_sequence;

    `uvm_component_utils(alu_regression_test)
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        enviroment = alu_environment::type_id::create("enviroment", this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        // Create all sequences
        add_sequence = alu_add_sequence::type_id::create("add_sequence");
        sub_sequence = alu_sub_sequence::type_id::create("sub_sequence");
        and_sequence = alu_and_sequence::type_id::create("and_sequence");
        or_sequence = alu_or_sequence::type_id::create("or_sequence");
        xor_sequence = alu_xor_sequence::type_id::create("xor_sequence");
        over_under_sequence = alu_over_under_flow_sequence::type_id::create("over_under_sequence");
        undef_sequence = alu_undefined_opcode_sequence::type_id::create("undef_sequence");

        `uvm_info(get_type_name(), "Running ALU regression test", UVM_LOW);
        
        // Execute each sequence once initially
        add_sequence.start(enviroment.agent.sequencer);
        sub_sequence.start(enviroment.agent.sequencer);
        and_sequence.start(enviroment.agent.sequencer);
        or_sequence.start(enviroment.agent.sequencer);
        xor_sequence.start(enviroment.agent.sequencer);
        over_under_sequence.start(enviroment.agent.sequencer);
        undef_sequence.start(enviroment.agent.sequencer);

        repeat (500) begin
            add_sequence.start(enviroment.agent.sequencer);
            sub_sequence.start(enviroment.agent.sequencer);
            and_sequence.start(enviroment.agent.sequencer);
            or_sequence.start(enviroment.agent.sequencer);
            xor_sequence.start(enviroment.agent.sequencer);
            over_under_sequence.start(enviroment.agent.sequencer);
            undef_sequence.start(enviroment.agent.sequencer);
        end

        phase.drop_objection(this);
        `uvm_info(get_type_name(), "End of ALU regression test", UVM_LOW);
    endtask
endclass