class aes_driver extends uvm_driver #(aes_sequence_item);

	// Creating virtual interface to be obtained 
	// ==> should be the same name as the concrete interface
	virtual AES_INTF aes_intf;

	aes_sequence_item seq_item;

	// Factory Registration
	`uvm_component_utils(aes_driver);

	// Factory Construction
	function new(string name = "aes_driver",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//  ==> Phasing
	// Build Phase Function
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		$display("Hello from driver");

		// Factory Creation of Sequence item
		seq_item = aes_sequence_item::type_id::create("seq_item");

		// get the virtual interface that passed via top module
		if (!uvm_config_db #(virtual AES_INTF)::get(this,"","aes_intf_name",aes_intf)) begin
			// Report if virtual interface cannot be obtain
			`uvm_fatal(get_full_name(),"Error");
		end

	endfunction

	// Connect Phase Function 
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	// Run Phase Task
	task run_phase (uvm_phase phase);
		super.run_phase(phase);

		
		forever begin

			seq_item_port.get_next_item(seq_item);

				aes_intf.finish_test = seq_item.finish_test;
				// Send Stimiulus to DUT via virtual interface
				// Syncronize with CLK
				if (seq_item.rst_n == 1'b0) begin
					aes_intf.rst_n 	   = seq_item.rst_n;
					repeat (10) @(negedge aes_intf.CLK);
				end

				if (seq_item.Valid == 1'b1) begin
					@(negedge aes_intf.CLK);
					aes_intf.rst_n 	   = seq_item.rst_n;
					aes_intf.Valid 	   = seq_item.Valid;
					aes_intf.Plain_txt = seq_item.Plain_txt;
					aes_intf.Key       = seq_item.Key;

					@(negedge aes_intf.CLK);
					aes_intf.Valid     = 1'b0;
					WAIT_OP();
				end
				
			seq_item_port.item_done(); // Driver ACK sequencer that's seq_item has been finished
		end
	endtask

	task WAIT_OP;
		while (aes_intf.Busy) begin
			@(negedge aes_intf.CLK);
		end
	endtask;

endclass
