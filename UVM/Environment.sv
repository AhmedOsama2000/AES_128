class aes_env extends uvm_env;

	virtual AES_INTF aes_intf;

	// Factory Registration
	`uvm_component_utils(aes_env);

	aes_agent 		agent;
	aes_subscriber  subscriber;
	aes_scoreboard  scoreboard;

	// Factory Construction
	function new(string name = "aes_env",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//  ==> Phasing
	// Build Phase Function
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);

		// Factory Creation
		agent 	   = aes_agent::type_id::create("agent",this);
		subscriber = aes_subscriber::type_id::create("subscriber",this);
		scoreboard = aes_scoreboard::type_id::create("scoreboard",this);
		$display("Hello from environment");

		// get the virtual interface that passed via top module
		if (!uvm_config_db #(virtual AES_INTF)::get(this,"","aes_intf_name",aes_intf)) begin
			// Report if virtual interface cannot be obtain
			`uvm_fatal(get_full_name(),"Error");
		end
		uvm_config_db #(virtual AES_INTF)::set(this,"agent","aes_intf_name",aes_intf);

	endfunction

	// Connect Phase Function 
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);

		// Connect analysis port in agent to anaylsis export in scoreboard
		agent.aes_agent_analysis_port.connect(scoreboard.aes_scoreboard_analysis_export);
		agent.aes_agent_analysis_port.connect(subscriber.analysis_export);
	endfunction

	// Run Phase Task
	task run_phase (uvm_phase phase);
		phase.raise_objection(this,"Starting Sequences");
		super.run_phase(phase);
		phase.drop_objection(this,"Finishing Seqeuences");
	endtask
endclass