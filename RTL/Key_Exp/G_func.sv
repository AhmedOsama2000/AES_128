module G_func (
	input  logic [3:0]  rnd_num,
	input  logic [31:0] word_in,
	output logic [31:0] word_out
);

integer i;
logic  [7:0] RC [0:10];

logic  [7:0] Bytes_in0;
logic  [7:0] Bytes_in1; 
logic  [7:0] Bytes_in2; 
logic  [7:0] Bytes_in3;  

logic  [7:0] Bytes_shft0;
logic  [7:0] Bytes_shft1;
logic  [7:0] Bytes_shft2;
logic  [7:0] Bytes_shft3;

logic  [7:0] Bytes_subs0;
logic  [7:0] Bytes_subs1;
logic  [7:0] Bytes_subs2;
logic  [7:0] Bytes_subs3;

assign RC[0]  = 8'h00;
assign RC[1]  = 8'h01;
assign RC[2]  = 8'h02;
assign RC[3]  = 8'h04;
assign RC[4]  = 8'h08;
assign RC[5]  = 8'h10;
assign RC[6]  = 8'h20;
assign RC[7]  = 8'h40;
assign RC[8]  = 8'h80;
assign RC[9]  = 8'h1B;
assign RC[10] = 8'h36;

assign Bytes_in0 = word_in[31:24];
assign Bytes_in1 = word_in[23:16];
assign Bytes_in2 = word_in[15:8];
assign Bytes_in3 = word_in[7:0];

assign Bytes_shft0 = Bytes_in1;
assign Bytes_shft1 = Bytes_in2;
assign Bytes_shft2 = Bytes_in3;
assign Bytes_shft3 = Bytes_in0;

S_BOX S_BOX_1 (
	.box_sel(Bytes_shft0),
	.box_out(Bytes_subs0)
);

S_BOX S_BOX_2 (
	.box_sel(Bytes_shft1),
	.box_out(Bytes_subs1)
);

S_BOX S_BOX_3 (
	.box_sel(Bytes_shft2),
	.box_out(Bytes_subs2)
);

S_BOX S_BOX_4 (
	.box_sel(Bytes_shft3),
	.box_out(Bytes_subs3)
);

assign word_out[31:24] = Bytes_subs0 ^ RC[rnd_num];
assign word_out[23:16] = Bytes_subs1;
assign word_out[15:8]  = Bytes_subs2;
assign word_out[7:0]   = Bytes_subs3;

endmodule