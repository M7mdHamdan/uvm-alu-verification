class alu_environment extends uvm_env;

    alu_agent agent;
    alu_scoreboard scoreboard;
    alu_subscriber subscriber;
    
    `uvm_component_utils(alu_environment)

    function new (string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = alu_agent::type_id::create("agent",this);
        scoreboard = alu_scoreboard::type_id::create("scoreboard",this);
        subscriber = alu_subscriber::type_id::create("subscriber",this);
    endfunction

    function void connect_phase (uvm_phase phase);
        agent.monitor.port.connect(scoreboard.exp);
        agent.monitor.port.connect(subscriber.analysis_export);
    endfunction


endclass