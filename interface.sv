// Using Generic or named bundle
interface AES_INTF;
	
	// Input
	bit 		  CLK;
	logic 		  rst_n;
	logic 	      Valid;
	logic [127:0] Key;
	logic [127:0] Plain_txt;
	// Output
	logic [127:0] Cypher_txt;
	logic         Done;
	logic         Busy;

	// Control Testing
	bit 		  finish_test;

	// Clk Generation
	always begin
		CLK = ~CLK;
		#1;
	end

	
endinterface