`include "interface.sv"

module aes_top_env;

	AES_INTF aes_intf();

	// UVM_Package
	import uvm_pkg::*;

	// User defined package (including uvm_classes)
	import aes_uvm_pkg::*;

	// Run Test Method to run the environment
	initial begin

		// Pass the virtual interface to the config_db class to pass it to the rest of the hierarchy
		uvm_config_db #(virtual AES_INTF)::set(null,"uvm_test_top","aes_intf_name",aes_intf);

		// Run Test Should be but in initial block to excute after build phase
		run_test("aes_test");
	end
	

	// DUT Instantiation
	AES_128bits DUT (
		.rst_n(aes_intf.rst_n),
		.CLK(aes_intf.CLK),
		.Valid(aes_intf.Valid),
		.Key(aes_intf.Key),
		.Plain_txt(aes_intf.Plain_txt),

		.Cypher_txt(aes_intf.Cypher_txt),
		.Done(aes_intf.Done),
		.Busy(aes_intf.Busy)
	);

endmodule