module Shift_Rows (
	input  logic [127:0] data_in,
	output logic [127:0] data_out
);

logic [0:3][7:0]  matrix_in  [0:3];
logic [0:3][7:0]  byte_rows  [0:3];

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

// Row_1 is kept as it is
assign byte_rows[0][0]   = matrix_in[0][0];  // in0
assign byte_rows[0][1]   = matrix_in[0][1];  // in4
assign byte_rows[0][2]   = matrix_in[0][2];  // in8
assign byte_rows[0][3]   = matrix_in[0][3];  // in12

// Row_2 is rotated left one-time
assign byte_rows[1][0]   = matrix_in[1][1];  // in5
assign byte_rows[1][1]   = matrix_in[1][2];  // in9
assign byte_rows[1][2]   = matrix_in[1][3];  // in13
assign byte_rows[1][3]   = matrix_in[1][0];  // in1

// Row_3 is rotated left two-times
assign byte_rows[2][0]   = matrix_in[2][2];  // in10
assign byte_rows[2][1]   = matrix_in[2][3];  // in14 
assign byte_rows[2][2]   = matrix_in[2][0];  // in2 
assign byte_rows[2][3]   = matrix_in[2][1];  // in6

// Row_4 is rotated left three-times
assign byte_rows[3][0]   = matrix_in[3][3];  // in15 
assign byte_rows[3][1]   = matrix_in[3][0];  // in3 
assign byte_rows[3][2]   = matrix_in[3][1];  // in7
assign byte_rows[3][3]   = matrix_in[3][2];  // in11 


// Convert the matrix to output
assign data_out[127:120] = byte_rows[0][0];  // out0
assign data_out[119:112] = byte_rows[1][0];  // out1
assign data_out[111:104] = byte_rows[2][0];  // out2
assign data_out[103:96]  = byte_rows[3][0];  // out3

assign data_out[95:88]   = byte_rows[0][1];  // out4
assign data_out[87:80]   = byte_rows[1][1];  // out5
assign data_out[79:72]   = byte_rows[2][1];  // out6
assign data_out[71:64]   = byte_rows[3][1];  // out7

assign data_out[63:56]   = byte_rows[0][2];  // out8 
assign data_out[55:48]   = byte_rows[1][2];  // out9 
assign data_out[47:40]   = byte_rows[2][2];  // out10 
assign data_out[39:32]   = byte_rows[3][2];  // out11

assign data_out[31:24]   = byte_rows[0][3];  // out12 
assign data_out[23:16]   = byte_rows[1][3];  // out13 
assign data_out[15:8]    = byte_rows[2][3];  // out14
assign data_out[7:0]     = byte_rows[3][3];  // out15 

endmodule