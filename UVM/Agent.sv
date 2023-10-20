class aes_agent extends uvm_agent;

	// Factory Registration
	`uvm_component_utils(aes_agent);

	virtual AES_INTF aes_intf;

	// Define an analysis port to connect monitor to scoreboard analysis_export & subsrciber analysis_export
	uvm_analysis_port #(aes_sequence_item) aes_agent_analysis_port;

	aes_driver    driver;
	aes_monitor   monitor;
	aes_sequencer sequencer;

	// Factory Construction
	function new(string name = "aes_agent",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//  ==> Phasing
	// Build Phase Function
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);

		// Factory Creation
		driver 	  = aes_driver::type_id::create("driver",this);
		monitor   = aes_monitor::type_id::create("monitor",this);
		sequencer = aes_sequencer::type_id::create("sequencer",this);

		aes_agent_analysis_port = new("aes_agent_analysis_port",this);

		$display("Hello from agent");

		// get the virtual interface that passed via top module
		if (!uvm_config_db #(virtual AES_INTF)::get(this,"","aes_intf_name",aes_intf)) begin
			// Report if virtual interface cannot be obtain
			`uvm_fatal(get_full_name(),"Error");
		end
		uvm_config_db #(virtual AES_INTF)::set(this,"driver","aes_intf_name",aes_intf);
		uvm_config_db #(virtual AES_INTF)::set(this,"monitor","aes_intf_name",aes_intf);

	endfunction

	// Connect Phase Function 
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);

		// Connect Sequence item port in driver to sequence item export in the sequencer
		driver.seq_item_port.connect(sequencer.seq_item_export);
		monitor.aes_monitor_analysis_port.connect(aes_agent_analysis_port);

	endfunction

	// Run Phase Task
	task run_phase (uvm_phase phase);
		phase.raise_objection(this,"Starting Sequences");
		super.run_phase(phase);
		phase.drop_objection(this,"Finishing Seqeuences");
	endtask
endclass