class aes_sequence_item extends uvm_sequence_item;
	// Factory Registration
	`uvm_object_utils(aes_sequence_item);

	// I/O of DUT
	// Input
		 bit 		   CLK;
		 logic 		   rst_n;
		 logic 	       Valid;
	rand logic [127:0] Key;
	rand logic [127:0] Plain_txt;

	// Output
		 logic [127:0] Cypher_txt;
		 logic         Done;
		 logic         Busy;

	// Signal to control testing
	bit finish_test;

	// Hold Test Stimulus
	bit [127:0] plain_txt_cases [int];
	bit [127:0] key_cases       [int];

	// Randomization Constraints
	constraint pln_txt_constr {
		Plain_txt inside {plain_txt_cases};
	}
	constraint key_constr {
		Key inside {key_cases};
	}

	// Factory Construction
	function new(string name = "aes_sequence_item");
		super.new(name);

		// Plain Text & Key Test Cases Permutations
		plain_txt_cases [0] = 128'h00000000000000000000000000000000;
		plain_txt_cases [1] = 128'h0123456789abcdeffedcba9876543210;
		plain_txt_cases [2] = 128'h00112233445566778899aabbccddeeff;
		plain_txt_cases [3] = 128'hffffffffffffffffffffffffffffffff;

		key_cases  		[0] = 128'h00000000000000000000000000000000;
		key_cases  		[1] = 128'h0f1571c947d9e8590cb7add6af7f6798;
		key_cases  		[2] = 128'h000102030405060708090a0b0c0d0e0f;
		key_cases  		[3] = 128'hffffffffffffffffffffffffffffffff;

	endfunction

endclass