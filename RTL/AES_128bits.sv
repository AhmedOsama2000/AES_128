module AES_128bits (
	input  logic 		rst_n,
	input  logic 		CLK,
	input  logic 	    Valid,
	input  logic [127:0] Key,
	input  logic [127:0] Plain_txt,

	output logic [127:0] Cypher_txt,
	output logic         Done,
	output logic         Busy
);

logic En_Func;
logic En_Exp;
logic [127:0] key_rnd0;
logic [127:0] key_rndn;

FSM Control_FSM (
	.rst_n(rst_n),
	.CLK(CLK),
	.Valid(Valid),
	.En_Func(En_Func),
	.En_Exp(En_Exp),
	.Busy(Busy),
	.Done(Done)
);

Rnd_Func Round_Function (
	.rst_n(rst_n),
	.CLK(CLK),
	.Valid(Valid),
	.En_Func(En_Func),
	.Plain_txt(Plain_txt),
	.key_rnd0(key_rnd0),
	.key_rndn(key_rndn),
	.Cypher_txt(Cypher_txt)
);

Key_Expansion Key_Exp (
	.rst_n(rst_n),
	.CLK(CLK),
	.Valid(Valid),
	.Key_in(Key),
	.En_Exp(En_Exp),
	.key_rnd0(key_rnd0),
	.key_rndn(key_rndn)
);

endmodule