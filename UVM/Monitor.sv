class aes_monitor extends uvm_monitor;

	virtual AES_INTF aes_intf;

	aes_sequence_item seq_item1;
	aes_sequence_item seq_item2; // For Future Clonning

	// Defining an analysis port to hold sequence items
	uvm_analysis_port #(aes_sequence_item) aes_monitor_analysis_port;

	// Factory Registration
	`uvm_component_utils(aes_monitor);

	// Factory Construction
	function new(string name = "aes_monitor",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//  ==> Phasing
	// Build Phase Function
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		$display("Hello from monitor");

		seq_item1 = aes_sequence_item::type_id::create("seq_item1");
		seq_item2 = aes_sequence_item::type_id::create("seq_item2");

		// get the virtual interface that passed via top module
		if (!uvm_config_db #(virtual AES_INTF)::get(this,"","aes_intf_name",aes_intf)) begin
			// Report if virtual interface cannot be obtain
			`uvm_fatal(get_full_name(),"Error");
		end

		aes_monitor_analysis_port = new("aes_monitor_analysis_port",this);

	endfunction

	// Connect Phase Function 
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	// Run Phase Task
	task run_phase (uvm_phase phase);
		super.run_phase(phase);

		forever begin
			@(posedge aes_intf.CLK);
			// Capture I/O for coverage and checking
			seq_item1.rst_n       <= aes_intf.rst_n;
			seq_item1.Valid       <= aes_intf.Valid;
			seq_item1.Plain_txt   <= aes_intf.Plain_txt;
			seq_item1.Key         <= aes_intf.Key;
			seq_item1.Busy        <= aes_intf.Busy;
			seq_item1.Done        <= aes_intf.Done;
			seq_item1.Cypher_txt  <= aes_intf.Cypher_txt;

			seq_item1.finish_test <= aes_intf.finish_test;
			// Dynamic Casting for sequence item1
			$cast(seq_item2,seq_item1);

			// Calling the write method 
			aes_monitor_analysis_port.write(seq_item2);
		end

		
	endtask
endclass