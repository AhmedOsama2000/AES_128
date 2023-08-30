module Add_Rnd_Key (
	input  logic [127:0] Key_exp,
	input  logic [127:0] data_in,
	output logic [127:0] data_out
);

integer rw;
integer cl;

reg  [0:3][7:0] key_matrix_in   [0:3];
reg  [0:3][7:0] data_matrix_in  [0:3];
reg  [0:3][7:0] data_matrix_out [0:3];

// Convert the input to an 4x4 Matrix
assign data_matrix_in[0][0] = data_in[127:120]; // in0
assign data_matrix_in[1][0] = data_in[119:112]; // in1
assign data_matrix_in[2][0] = data_in[111:104]; // in2
assign data_matrix_in[3][0] = data_in[103:96];  // in3

assign data_matrix_in[0][1] = data_in[95:88];   // in4
assign data_matrix_in[1][1] = data_in[87:80];   // in5
assign data_matrix_in[2][1] = data_in[79:72];   // in6
assign data_matrix_in[3][1] = data_in[71:64];   // in7

assign data_matrix_in[0][2] = data_in[63:56];   // in8 
assign data_matrix_in[1][2] = data_in[55:48];   // in9 
assign data_matrix_in[2][2] = data_in[47:40];   // in10 
assign data_matrix_in[3][2] = data_in[39:32];   // in11

assign data_matrix_in[0][3] = data_in[31:24];   // in12 
assign data_matrix_in[1][3] = data_in[23:16];   // in13 
assign data_matrix_in[2][3] = data_in[15:8];    // in14
assign data_matrix_in[3][3] = data_in[7:0]; 	// in15 

// Convert the key to an 4x4 Matrix
assign key_matrix_in[0][0]  = Key_exp[127:120]; // in0
assign key_matrix_in[1][0]  = Key_exp[119:112]; // in1
assign key_matrix_in[2][0]  = Key_exp[111:104]; // in2
assign key_matrix_in[3][0]  = Key_exp[103:96];  // in3

assign key_matrix_in[0][1]  = Key_exp[95:88];   // in4
assign key_matrix_in[1][1]  = Key_exp[87:80];   // in5
assign key_matrix_in[2][1]  = Key_exp[79:72];   // in6
assign key_matrix_in[3][1]  = Key_exp[71:64];   // in7

assign key_matrix_in[0][2]  = Key_exp[63:56];   // in8 
assign key_matrix_in[1][2]  = Key_exp[55:48];   // in9 
assign key_matrix_in[2][2]  = Key_exp[47:40];   // in10 
assign key_matrix_in[3][2]  = Key_exp[39:32];   // in11

assign key_matrix_in[0][3]  = Key_exp[31:24];   // in12 
assign key_matrix_in[1][3]  = Key_exp[23:16];   // in13 
assign key_matrix_in[2][3]  = Key_exp[15:8];    // in14
assign key_matrix_in[3][3]  = Key_exp[7:0]; 	// in15 

// bitwise XORING
always @(*) begin
	for (rw = 0;rw < 4;rw++) begin
		for (cl = 0;cl < 4;cl++) begin
			data_matrix_out[rw][cl] = data_matrix_in[rw][cl] ^ key_matrix_in[rw][cl];
		end
	end
end

// Convert the matrix to output
assign data_out[127:120] = data_matrix_out[0][0];  // out0
assign data_out[119:112] = data_matrix_out[1][0];  // out1
assign data_out[111:104] = data_matrix_out[2][0];  // out2
assign data_out[103:96]  = data_matrix_out[3][0];  // out3

assign data_out[95:88]   = data_matrix_out[0][1];  // out4
assign data_out[87:80]   = data_matrix_out[1][1];  // out5
assign data_out[79:72]   = data_matrix_out[2][1];  // out6
assign data_out[71:64]   = data_matrix_out[3][1];  // out7

assign data_out[63:56]   = data_matrix_out[0][2];  // out8 
assign data_out[55:48]   = data_matrix_out[1][2];  // out9 
assign data_out[47:40]   = data_matrix_out[2][2];  // out10 
assign data_out[39:32]   = data_matrix_out[3][2];  // out11

assign data_out[31:24]   = data_matrix_out[0][3];  // out12 
assign data_out[23:16]   = data_matrix_out[1][3];  // out13 
assign data_out[15:8]    = data_matrix_out[2][3];  // out14
assign data_out[7:0]     = data_matrix_out[3][3];  // out15 

endmodule