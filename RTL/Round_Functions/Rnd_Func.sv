module Rnd_Func (
	input  logic 	  	 rst_n,
	input  logic 		 CLK,
	input  logic 		 Valid,
	input  logic         En_Func,
	input  logic [127:0] Plain_txt,
	input  logic [127:0] key_rnd0,
	input  logic [127:0] key_rndn,
	output logic [127:0] Cypher_txt
);

logic  [3:0]   rnds;

logic  [127:0] addkey_in_state;
logic  [127:0] subs_in_state;
logic  [127:0] shft_in_state;
logic  [127:0] mix_in_state;

logic  [127:0] post_initial_state;
logic  [127:0] next_state_out;
logic  [127:0] rnd_key_in;

// Include the 4-functions block
Add_Rnd_Key initial_state (
	.Key_exp(key_rnd0),
	.data_in(Plain_txt),
	.data_out(post_initial_state)
);

Subs_Bytes substitution (
	.data_in(subs_in_state),
	.data_out(shft_in_state)
);

Shift_Rows shft_rws (
	.data_in(shft_in_state),
	.data_out(mix_in_state)
);

Mix_Cols mix_cls (
	.data_in(mix_in_state),
	.data_out(addkey_in_state)
);

Add_Rnd_Key addrnd_key (
	.Key_exp(key_rndn),
	.data_in(rnd_key_in),
	.data_out(next_state_out)
);

always @(posedge CLK,negedge rst_n) begin
	if (!rst_n) begin
		Cypher_txt          <= 128'b0;
		subs_in_state       <= 128'b0;
		rnds       			<= 4'b0000;
	end
	else if (Valid) begin
		subs_in_state       <= post_initial_state;
		rnds       			<= 4'b0001;
	end
	else if (rnds == 4'b1010) begin
		Cypher_txt          <= next_state_out;
		rnds                <= 4'b0001;
	end
	else if (En_Func) begin
		subs_in_state       <= next_state_out;
		rnds      			<= rnds + 1'b1;
	end
end

// Select the input of the incoming Add_Rnd_Key
always @(*) begin
	if (rnds == 4'b1010) begin
		rnd_key_in = mix_in_state;
	end
	else begin
		rnd_key_in = addkey_in_state;
	end
end

endmodule