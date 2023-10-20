class aes_sequencer extends uvm_sequencer #(aes_sequence_item);

		// Factory Registration
		`uvm_component_utils(aes_sequencer);

		// Factory Construction
		function new(string name = "aes_sequencer",uvm_component parent = null);
			super.new(name,parent);
		endfunction

endclass