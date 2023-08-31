module testbench;
 
	logic 		  rst_n_tb;
	logic 		  CLK_tb;
	logic         Valid_tb;
	logic [127:0] Key_tb;
	logic [127:0] Plain_txt_tb;
	logic [127:0] Cypher_txt_tb;
	logic         Busy_tb;
	logic         Done_tb;

	// DUT Instantition
	AES_128bits DUT (
		.rst_n(rst_n_tb),
		.CLK(CLK_tb),
		.Valid(Valid_tb),
		.Key(Key_tb),
		.Plain_txt(Plain_txt_tb),
		.Cypher_txt(Cypher_txt_tb),
		.Busy_tb(Busy_tb),
		.Done(Done_tb)
	);

	always begin
		CLK_tb = ~CLK_tb;
		#1;
	end

	initial begin
		rst_n_tb     = 1'b0;
		CLK_tb       = 1'b0;
		Valid_tb     = 1'b0;
		Key_tb       = 128'b0;
		Plain_txt_tb = 128'b0;

		repeat (5) @(negedge CLK_tb);

		rst_n_tb     = 1'b1;
		Valid_tb     = 1'b1;
		Key_tb       = 128'h0f1571c947d9e8590cb7add6af7f6798;
		Plain_txt_tb = 128'h0123456789abcdeffedcba9876543210;
		@(negedge CLK_tb);
		Valid_tb     = 1'b0;

		repeat (20) @(negedge CLK_tb);
		if (Cypher_txt_tb == 128'hff0b844a0853bf7c6934ab4364148fb9) begin
			$display("Correct Case");
		end
		else begin
			$display("Incorrect Case");
		end
		$stop;
	end

endmodule