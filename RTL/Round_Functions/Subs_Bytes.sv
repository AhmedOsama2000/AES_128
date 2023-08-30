module Subs_Bytes (
	input  logic [127:0] data_in,
	output logic [127:0] data_out
);

logic [0:3][7:0] matrix_in  [0:3];
logic [0:3][7:0] matrix_out [0:3];

// Convert the input to an 4x4 Matrix
assign matrix_in[0][0]   = data_in[127:120]; // in0
assign matrix_in[1][0]   = data_in[119:112]; // in1
assign matrix_in[2][0]   = data_in[111:104]; // in2
assign matrix_in[3][0]   = data_in[103:96];  // in3

assign matrix_in[0][1]   = data_in[95:88];   // in4
assign matrix_in[1][1]   = data_in[87:80];   // in5
assign matrix_in[2][1]   = data_in[79:72];   // in6
assign matrix_in[3][1]   = data_in[71:64];   // in7

assign matrix_in[0][2]   = data_in[63:56];   // in8 
assign matrix_in[1][2]   = data_in[55:48];   // in9 
assign matrix_in[2][2]   = data_in[47:40];   // in10 
assign matrix_in[3][2]   = data_in[39:32];   // in11

assign matrix_in[0][3]   = data_in[31:24];   // in12 
assign matrix_in[1][3]   = data_in[23:16];   // in13 
assign matrix_in[2][3]   = data_in[15:8];    // in14
assign matrix_in[3][3]   = data_in[7:0]; 	 // in15 

S_BOX S_BOX_1 (
	.box_sel(matrix_in[0][0]),
	.box_out(matrix_out[0][0])
);

S_BOX S_BOX_2 (
	.box_sel(matrix_in[0][1]),
	.box_out(matrix_out[0][1])
);

S_BOX S_BOX_3 (
	.box_sel(matrix_in[0][2]),
	.box_out(matrix_out[0][2])
);

S_BOX S_BOX_4 (
	.box_sel(matrix_in[0][3]),
	.box_out(matrix_out[0][3])
);

S_BOX S_BOX_5 (
	.box_sel(matrix_in[1][0]),
	.box_out(matrix_out[1][0])
);

S_BOX S_BOX_6 (
	.box_sel(matrix_in[1][1]),
	.box_out(matrix_out[1][1])
);

S_BOX S_BOX_7 (
	.box_sel(matrix_in[1][2]),
	.box_out(matrix_out[1][2])
);

S_BOX S_BOX_8 (
	.box_sel(matrix_in[1][3]),
	.box_out(matrix_out[1][3])
);

S_BOX S_BOX_9 (
	.box_sel(matrix_in[2][0]),
	.box_out(matrix_out[2][0])
);

S_BOX S_BOX_10 (
	.box_sel(matrix_in[2][1]),
	.box_out(matrix_out[2][1])
);

S_BOX S_BOX_11 (
	.box_sel(matrix_in[2][2]),
	.box_out(matrix_out[2][2])
);

S_BOX S_BOX_12 (
	.box_sel(matrix_in[2][3]),
	.box_out(matrix_out[2][3])
);

S_BOX S_BOX_13 (
	.box_sel(matrix_in[3][0]),
	.box_out(matrix_out[3][0])
);

S_BOX S_BOX_14 (
	.box_sel(matrix_in[3][1]),
	.box_out(matrix_out[3][1])
);

S_BOX S_BOX_15 (
	.box_sel(matrix_in[3][2]),
	.box_out(matrix_out[3][2])
);

S_BOX S_BOX_16 (
	.box_sel(matrix_in[3][3]),
	.box_out(matrix_out[3][3])
);

// Convert the matrix to output
assign data_out[127:120] = matrix_out[0][0];  // out0
assign data_out[119:112] = matrix_out[1][0];  // out1
assign data_out[111:104] = matrix_out[2][0];  // out2
assign data_out[103:96]  = matrix_out[3][0];  // out3

assign data_out[95:88]   = matrix_out[0][1];  // out4
assign data_out[87:80]   = matrix_out[1][1];  // out5
assign data_out[79:72]   = matrix_out[2][1];  // out6
assign data_out[71:64]   = matrix_out[3][1];  // out7

assign data_out[63:56]   = matrix_out[0][2];  // out8 
assign data_out[55:48]   = matrix_out[1][2];  // out9 
assign data_out[47:40]   = matrix_out[2][2];  // out10 
assign data_out[39:32]   = matrix_out[3][2];  // out11

assign data_out[31:24]   = matrix_out[0][3];  // out12 
assign data_out[23:16]   = matrix_out[1][3];  // out13 
assign data_out[15:8]    = matrix_out[2][3];  // out14
assign data_out[7:0]     = matrix_out[3][3];  // out15 

endmodule