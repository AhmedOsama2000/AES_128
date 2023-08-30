module Key_Expansion (
	input  logic         rst_n,
	input  logic         CLK,
	input  logic 		 Valid,
	input  logic         En_Exp,
	input  logic [127:0] Key_in,
	output logic [127:0] key_rnd0,
	output logic [127:0] key_rndn
);

assign key_rnd0 = Key_in;

logic [0:3][7:0] keys [0:3];
logic [3:0]      rnd_num;

logic [31:0]     words_arr_0   [0:3];
logic [31:0]     words_arr_in  [0:3];
logic [31:0]     words_arr_out [0:3];
logic [31:0]  	 g_word_in;
logic [31:0]  	 g_word_out;

// Convert the input to an 4x4 Matrix
assign keys[0][0] = Key_in[127:120]; // in0
assign keys[1][0] = Key_in[119:112]; // in1
assign keys[2][0] = Key_in[111:104]; // in2
assign keys[3][0] = Key_in[103:96];  // in3

assign keys[0][1] = Key_in[95:88];   // in4
assign keys[1][1] = Key_in[87:80];   // in5
assign keys[2][1] = Key_in[79:72];   // in6
assign keys[3][1] = Key_in[71:64];   // in7

assign keys[0][2] = Key_in[63:56];   // in8 
assign keys[1][2] = Key_in[55:48];   // in9 
assign keys[2][2] = Key_in[47:40];   // in10 
assign keys[3][2] = Key_in[39:32];   // in11

assign keys[0][3] = Key_in[31:24];   // in12 
assign keys[1][3] = Key_in[23:16];   // in13 
assign keys[2][3] = Key_in[15:8];    // in14
assign keys[3][3] = Key_in[7:0]; 	 // in15 

assign words_arr_0[0] = {keys[0][0],keys[1][0],keys[2][0],keys[3][0]}; // in0-in1-in2-in3
assign words_arr_0[1] = {keys[0][1],keys[1][1],keys[2][1],keys[3][1]}; // in4-in5-in6-in7
assign words_arr_0[2] = {keys[0][2],keys[1][2],keys[2][2],keys[3][2]}; // in8-in9-in10-in11
assign words_arr_0[3] = {keys[0][3],keys[1][3],keys[2][3],keys[3][3]}; // in12-in13-in14-in15

// Key Expansion Algorithm
always @(posedge CLK,negedge rst_n) begin
	if (!rst_n) begin
		g_word_in        <= 32'b0;
		words_arr_in[0]  <= 32'b0;
		words_arr_in[1]  <= 32'b0;
		words_arr_in[2]  <= 32'b0;
		words_arr_in[3]  <= 32'b0;
		rnd_num          <= 4'b0000;
	end
	else if (Valid) begin
		words_arr_in[0]  <= words_arr_0[0];
		words_arr_in[1]  <= words_arr_0[1];
		words_arr_in[2]  <= words_arr_0[2];
		words_arr_in[3]  <= words_arr_0[3];

		g_word_in        <= words_arr_0[3];
		rnd_num++;
	end
	else if (En_Exp) begin
		words_arr_in[0]  <= words_arr_out[0];
		words_arr_in[1]  <= words_arr_out[1];
		words_arr_in[2]  <= words_arr_out[2];
		words_arr_in[3]  <= words_arr_out[3];
		g_word_in        <= words_arr_out[3];
		rnd_num++;
	end
end

always @(*) begin
	words_arr_out[0] = words_arr_in [0] ^ g_word_out;
	words_arr_out[1] = words_arr_out[0] ^ words_arr_in[1];
	words_arr_out[2] = words_arr_out[1] ^ words_arr_in[2];
	words_arr_out[3] = words_arr_out[2] ^ words_arr_in[3];
end

assign key_rndn[127:96] = words_arr_out[0]; 
assign key_rndn[95:64]  = words_arr_out[1]; 
assign key_rndn[63:32]  = words_arr_out[2]; 
assign key_rndn[31:0]   = words_arr_out[3]; 

G_func g_f (
	.rnd_num(rnd_num),
	.word_in(g_word_in),
	.word_out(g_word_out)
);

endmodule