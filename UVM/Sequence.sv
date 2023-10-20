class aes_sequence extends uvm_sequence;

		int TEST_CASES = 50;

		// Factory Registration
		`uvm_object_utils(aes_sequence);

		// Include the virtual interface to i

		aes_sequence_item seq_item;

		// Creation  ==> no factory phases in object
		task pre_body;
			seq_item = aes_sequence_item::type_id::create("seq_item");
		endtask

		// Begin Testing Stimilus
		// Don't Insert Delay between start_item and finish_item {It's a set of combination trasnaction}
		task body;

			start_item(seq_item);
				$display("Start Reset");
				RESET();
			finish_item(seq_item);

			start_item(seq_item);
			$display("DUT INIT");
				DUT_INIT();
				SET();
			finish_item(seq_item);

			for (int  i = 0; i < TEST_CASES;i++) begin
				start_item(seq_item);
					VALID_HIGH();
					assert(seq_item.randomize());
				finish_item(seq_item);
			end

			start_item(seq_item);
				FINISH_TEST();
			finish_item(seq_item);

		endtask

		task DUT_INIT;
			seq_item.Valid     = 1'b0;
			seq_item.Plain_txt = 128'h0;
			seq_item.Key	   = 128'h0;
		endtask

		task RESET;
			seq_item.rst_n     = 1'b0;
		endtask

		task SET;
			seq_item.rst_n     = 1'b1;
		endtask

		task VALID_HIGH;
			seq_item.Valid 	   = 1'b1;
		endtask

		task FINISH_TEST;
			seq_item.finish_test = 1'b1;
		endtask

endclass