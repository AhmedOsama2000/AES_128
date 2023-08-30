module Mix_Cols (
	input  logic [127:0] data_in,
	output logic [127:0] data_out
);

// Counters for loops
integer rw;
integer cl;
integer thrd;

logic [0:3][7:0] matrix_in  [0:3];
logic [0:3][7:0] matrix_out [0:3];
logic [0:3][7:0] mul_coef   [0:3];

// Multiplication Result
logic [7:0] mul_res [0:3];
logic [7:0] mul_mod [0:3];

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

// Multiplication Coefficient
// Col_1
assign mul_coef[0][0] = 8'b0000_0010;
assign mul_coef[1][0] = 8'b0000_0001;
assign mul_coef[2][0] = 8'b0000_0001;
assign mul_coef[3][0] = 8'b0000_0011;

// Col_2
assign mul_coef[0][1] = 8'b0000_0011;
assign mul_coef[1][1] = 8'b0000_0010;
assign mul_coef[2][1] = 8'b0000_0001;
assign mul_coef[3][1] = 8'b0000_0001;

// Col_3
assign mul_coef[0][2] = 8'b0000_0001;
assign mul_coef[1][2] = 8'b0000_0011;
assign mul_coef[2][2] = 8'b0000_0010;
assign mul_coef[3][2] = 8'b0000_0001;

// Col_4
assign mul_coef[0][3] = 8'b0000_0001;
assign mul_coef[1][3] = 8'b0000_0001;
assign mul_coef[2][3] = 8'b0000_0011;
assign mul_coef[3][3] = 8'b0000_0010;

always @(*) begin
	for (rw = 0;rw < 4;rw++) begin

		for (cl = 0;cl < 4;cl++) begin

			for (thrd = 0;thrd < 4;thrd++) begin

				if (mul_coef[rw][thrd] == 8'b0000_0010) begin
					mul_res[thrd] = {matrix_in[thrd][cl][6:0],1'b0};
					if (matrix_in[thrd][cl][7] == 1'b1) begin
						mul_mod[thrd] = mul_res[thrd] ^ 8'b0001_1011;
					end
					else begin
						mul_mod[thrd] = mul_res[thrd];
					end
				end
				else if (mul_coef[rw][thrd] == 8'b0000_0011) begin
					mul_res[thrd] = {matrix_in[thrd][cl][6:0],1'b0} ^ matrix_in[thrd][cl];
					if (matrix_in[thrd][cl][7] == 1'b1) begin
						mul_mod[thrd] = mul_res[thrd] ^ 8'b0001_1011;
					end
					else begin
						mul_mod[thrd] = mul_res[thrd];
					end 
				end
				else begin
					mul_res[thrd] = matrix_in[thrd][cl];
					mul_mod[thrd] = mul_res[thrd]; 
				end
			end
			matrix_out[rw][cl] = mul_mod[0] ^ mul_mod[1] ^ mul_mod[2] ^ mul_mod[3];
		end
	end
end

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