class aes_test extends uvm_test;

	// Defining the virtual interface
	virtual AES_INTF aes_intf;

	// Factory Registration	
	`uvm_component_utils(aes_test);

	aes_env 	 env;
	aes_sequence sequence_inst;

	// Factory Construction
	function new(string name = "aes_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//  ==> Phasing
	// Build Phase Function
	function void build_phase (uvm_phase phase);

		// Factory Creation
		super.build_phase(phase);

		sequence_inst = aes_sequence::type_id::create("sequence_inst");
		env           = aes_env::type_id::create("env",this);
		$display("Hello from test");

		// get the virtual interface that passed via top module
		if (!uvm_config_db #(virtual AES_INTF)::get(this,"","aes_intf_name",aes_intf)) begin
			// Report if virtual interface cannot be obtain
			`uvm_fatal(get_full_name(),"Error");
		end
		uvm_config_db #(virtual AES_INTF)::set(this,"env","aes_intf_name",aes_intf);
	endfunction

	// Connect Phase Function 
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	// Run Phase Task
	task run_phase (uvm_phase phase);
		phase.raise_objection(this,"Starting Sequences");
		super.run_phase(phase);

		// Start Sequencing 
		sequence_inst.start(env.agent.sequencer);
		phase.drop_objection(this,"Finishing Seqeuences");
	endtask
endclass