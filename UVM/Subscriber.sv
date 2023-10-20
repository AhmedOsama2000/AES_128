class aes_subscriber extends uvm_subscriber #(aes_sequence_item);
	
	// Factory Registration
	`uvm_component_utils(aes_subscriber);

	aes_sequence_item seq_item;

	// Define Coverage Models
	parameter ALL_ZERO = 128'h0;
	parameter ALL_ONE  = 128'hffffffffffffffff_ffffffffffffffff;

	// No need for creating the analysis export because it's in the uvm_subscriber itself
	// No need for sampling synchronously with the clock, because write function samples synchronously

	covergroup Plain_Cov;
			plain: coverpoint seq_item.Plain_txt {
				  bins ZEROS      = {ALL_ZERO};
				  bins ONES       = {ALL_ONE};
				  bins ZEROS_ONES = (ALL_ZERO => ALL_ONE);
				  bins ONES_ZEORS = (ALL_ONE  => ALL_ZERO);
				  bins others     = default;
			}
		endgroup : Plain_Cov
		covergroup Key_Cov;
			key: coverpoint seq_item.Key {
				  bins ZEROS      = {ALL_ZERO};
				  bins ONES       = {ALL_ONE};
  				  bins ZEROS_ONES = (ALL_ZERO => ALL_ONE);
				  bins ONES_ZEORS = (ALL_ONE  => ALL_ZERO);
				  bins Others     = default;
			}
		endgroup : Key_Cov
		covergroup Reset_Cov;
			rst: coverpoint seq_item.rst_n {
				  bins assrt     = {0};
				  bins de_assrt  = {1};
			}
		endgroup : Reset_Cov

	// Factory Construction
	function new(string name = "aes_subscriber",uvm_component parent = null);
		super.new(name,parent);

		// Constructing coveragegroups
		$display("New covgrps");
		Plain_Cov = new();
		Key_Cov   = new();
		Reset_Cov = new();
	endfunction

	//  ==> Phasing
	// Build Phase Function
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		$display("Hello from subscriber");
		seq_item = aes_sequence_item::type_id::create("seq_item");
	endfunction

	// the user sequence item should be 't' as in original class (Virtual Function)
	// pure virtual function inside the parent class itelf ==> 
	function void write(aes_sequence_item t);
		seq_item = t;

		// Sampling Cover Groups
		Plain_Cov.sample();
		Key_Cov.sample();
		Reset_Cov.sample();
	endfunction

endclass
