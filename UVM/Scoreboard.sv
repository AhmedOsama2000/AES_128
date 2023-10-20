class aes_scoreboard extends uvm_scoreboard;

	// Factory Registration
	`uvm_component_utils(aes_scoreboard);

	aes_sequence_item seq_item_actual;
	aes_sequence_item seq_item_reference;

	uvm_tlm_analysis_fifo #(aes_sequence_item) aes_scoreboard_tlm_analysis_fifo;
	uvm_analysis_export   #(aes_sequence_item) aes_scoreboard_analysis_export;

	// Build Up Reference Model
	bit [127:0] cypher_txt_cases [16];

	bit scoreboard_done;

	int Correct_Cases;
	int InCorrect_Cases;

	// Capture index of randomized data from contrainted plain_txt/key
	int plain_index;
	int key_index;

	// Factory Construction
	function new(string name = "aes_scoreboard",uvm_component parent = null);
		super.new(name,parent);

		// Build Up cypher text reference Model
		cypher_txt_cases [0]  = 128'h66e94bd4ef8a2c3b884cfa59ca342b2e;
		cypher_txt_cases [1]  = 128'h0a4026dccc7b4f51bb34113ac383caf1;
		cypher_txt_cases [2]  = 128'hc6a13b37878f5b826f4f8162a1c8d879;
		cypher_txt_cases [3]  = 128'ha1f6258c877d5fcd8964484538bfc92c;
		cypher_txt_cases [4]  = 128'hac6c9fd5b14bb5ec1ef70964ac34a9ce;
		cypher_txt_cases [5]  = 128'hff0b844a0853bf7c6934ab4364148fb9;
		cypher_txt_cases [6]  = 128'h868d79bd49a5681cfae908ad51300ba0;
		cypher_txt_cases [7]  = 128'hcb9d39f5844940b492c1ab9ca310adc1;
		cypher_txt_cases [8]  = 128'hc8a331ff8edd3db175e1545dbefb760b;
		cypher_txt_cases [9]  = 128'h7d953dfecf4bb602988570db419df057;
		cypher_txt_cases [10] = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
		cypher_txt_cases [11] = 128'h0a90e5b74d2807a651f69ac0896a09f6;
		cypher_txt_cases [12] = 128'h3f5b8cc9ea855a0afa7347d23e8d664e;
		cypher_txt_cases [13] = 128'h3be66a4da2ae7663447f5031a0b42532;
		cypher_txt_cases [14] = 128'h3c441f32ce07822364d7a2990e50bb13;
		cypher_txt_cases [15] = 128'hbcbf217cb280cf30b2517052193ab979;
	endfunction

	//  ==> Phasing
	// Build Phase Function

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		$display("Hello from scoreboard");

		seq_item_actual    = aes_sequence_item::type_id::create("seq_item_actual");
		seq_item_reference = aes_sequence_item::type_id::create("seq_item_reference");

		// Initialize the analysis fifo
		aes_scoreboard_tlm_analysis_fifo = new("aes_scoreboard_tlm_analysis_fifo",this); // unbounded
		aes_scoreboard_analysis_export 	 = new("aes_scoreboard_analysis_export",this); 

	endfunction

	// Connect Phase Function 
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);

		// Connect Analysis Export in FIFO to analysis port in monitor
		aes_scoreboard_analysis_export.connect(aes_scoreboard_tlm_analysis_fifo.analysis_export);
	endfunction

	// Run Phase Task
	task run_phase (uvm_phase phase);
		super.run_phase(phase);
		forever begin

			// Get sequence items from FIFO of the scoreboard that's retreived from Monitor
			aes_scoreboard_tlm_analysis_fifo.get_peek_export.get(seq_item_actual);
			// Building the reference model
			if (seq_item_actual.finish_test == 1'b1 && !scoreboard_done) begin
				CLEAN_UP();
				scoreboard_done = 1'b1;
			end
			else if (seq_item_actual.rst_n == 1'b0) begin

				seq_item_reference.Busy       = 1'b0;
				seq_item_reference.Done       = 1'b0;
				seq_item_reference.Cypher_txt = 128'b0;

				CHK_RES();
			end
			else begin
				foreach (seq_item_actual.plain_txt_cases[i]) begin
					if (seq_item_actual.Plain_txt == seq_item_actual.plain_txt_cases[i]) begin
						plain_index = i;
						break;
					end
				end
				foreach (seq_item_actual.key_cases[i]) begin
					if (seq_item_actual.Key == seq_item_actual.key_cases[i]) begin
						key_index = i;
						break;
					end
				end

				// Obtain the reference cypher text based in reference plain/key index
				case ({plain_index[1:0],key_index[1:0]}) 
					4'b0000: seq_item_reference.Cypher_txt = cypher_txt_cases[0];
					4'b0001: seq_item_reference.Cypher_txt = cypher_txt_cases[1];
					4'b0010: seq_item_reference.Cypher_txt = cypher_txt_cases[2];
					4'b0011: seq_item_reference.Cypher_txt = cypher_txt_cases[3];
					4'b0100: seq_item_reference.Cypher_txt = cypher_txt_cases[4];
					4'b0101: seq_item_reference.Cypher_txt = cypher_txt_cases[5];
					4'b0110: seq_item_reference.Cypher_txt = cypher_txt_cases[6];
					4'b0111: seq_item_reference.Cypher_txt = cypher_txt_cases[7];
					4'b1000: seq_item_reference.Cypher_txt = cypher_txt_cases[8];
					4'b1001: seq_item_reference.Cypher_txt = cypher_txt_cases[9];
					4'b1010: seq_item_reference.Cypher_txt = cypher_txt_cases[10];
					4'b1011: seq_item_reference.Cypher_txt = cypher_txt_cases[11];
					4'b1100: seq_item_reference.Cypher_txt = cypher_txt_cases[12];
					4'b1101: seq_item_reference.Cypher_txt = cypher_txt_cases[13];
					4'b1110: seq_item_reference.Cypher_txt = cypher_txt_cases[14];
					4'b1111: seq_item_reference.Cypher_txt = cypher_txt_cases[15];
				endcase
				if (seq_item_actual.Done == 1'b1) begin
					CHK_RES();
				end

			end

		end


	endtask


	task CHK_RES;
		if (seq_item_actual.Cypher_txt == seq_item_reference.Cypher_txt) begin
			$display("Correct Case");
			$display("============================================================");
			$display("Reference = %0x,Actual = %0x",seq_item_reference.Cypher_txt,seq_item_actual.Cypher_txt);
			$display("============================================================");
			Correct_Cases++;
		end
		else begin
			$display("Incorrect Case");
			$display("============================================================");
			$display("Reference = %0x,Actual = %0x",seq_item_reference.Cypher_txt,seq_item_actual.Cypher_txt);
			$display("============================================================");
			InCorrect_Cases++;
		end
	endtask;

	task CLEAN_UP;
		// CLEANING UP
		$display("================================== FINISHING ....==================================");
		$display("Test Cases     = %0d",Correct_Cases + InCorrect_Cases);
		$display("Correc Cases   = %0d",Correct_Cases);
		$display("InCorrec Cases = %0d",InCorrect_Cases);
		$display("================================== Veri DONE :) ===================================");
	endtask

endclass
