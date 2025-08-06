class alu_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(alu_scoreboard)

    alu_sequence_item m_item; 
    alu_sequence_item refPacket;
    alu_sequence_item packetQueue [$];
    uvm_analysis_imp#(alu_sequence_item, alu_scoreboard) exp; 



    function new(string name = "alu_scoreboard", uvm_component parent);
        super.new(name, parent);
        refPacket = alu_sequence_item::type_id::create("refPacket"); 
    endfunction: new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        exp = new("exp", this);
    endfunction

    function void write(alu_sequence_item req);
        packetQueue.push_back(req);
    endfunction

    static task ALU_RF(input logic signed [31:0] A,
                      input logic [31:0] B,
                      input logic [2:0] Opcode,
                      output logic [31:0] Result,
                      output logic Error);
        Error = 0;
        case (Opcode)
            3'b000: begin
                // Addition operation
                Result = A + B;
                if ((A > 0 && B > 0 && Result < 0) || (A < 0 && B < 0 && Result > 0)) 
                    Error = 1;
            end

            3'b001: begin
                // Subtraction operation
                Result = A - B;
                if ((A < 0 && B > 0 && Result > A) || (A > 0 && B < 0 && Result < A)) 
                    Error = 1;
            end

            3'b010: begin
                // AND operation
                Result = A & B;
            end

            3'b011: begin
                // OR operation
                Result = A | B;
            end

            3'b100: begin
                // XOR operation
                Result = A ^ B;
            end

            default: begin
                Result = 0;
                Error = 1'b1; // Set error flag for invalid opcode
            end
        endcase
    endtask

    function bit is_equal(alu_sequence_item reference, alu_sequence_item packet);
        if(reference.A === packet.A &&
           reference.B === packet.B &&
           reference.Opcode === packet.Opcode &&
           reference.Result === packet.Result &&
           reference.Error === packet.Error
          ) return 1;
        else return 0;
    endfunction

    task run_phase(uvm_phase phase);
        alu_sequence_item packet; 
        forever begin
            wait(packetQueue.size>0);
            packet = packetQueue.pop_front();
            ALU_RF(packet.A, packet.B, packet.Opcode,
                   refPacket.Result, refPacket.Error);
            
            if(is_equal(packet, refPacket)) begin
                `uvm_info("PASS", $sformatf("------ :: Match :: ------"), UVM_LOW); 
                `uvm_info("MATCH", $sformatf("Actual: A=%0h B=%0h Op=%0h Result=%0h Error=%0b | Expected: Result=%0h Error=%0b", 
                         packet.A, packet.B, packet.Opcode, packet.Result, packet.Error, refPacket.Result, refPacket.Error), UVM_LOW);
            end
            else begin
                `uvm_info("FAIL", $sformatf("------ :: Mismatch :: ------"), UVM_LOW);
                `uvm_info("MISMATCH", $sformatf("Actual: A=%0h B=%0h Op=%0h Result=%0h Error=%0b | Expected: Result=%0h Error=%0b", 
                         packet.A, packet.B, packet.Opcode, packet.Result, packet.Error, refPacket.Result, refPacket.Error), UVM_LOW);
            end
        end
    endtask

endclass