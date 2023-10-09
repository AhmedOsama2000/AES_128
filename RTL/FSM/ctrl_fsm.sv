module FSM (
	input  logic rst_n,
	input  logic CLK,
	input  logic Valid,
	output logic En_Func,
	output logic En_Exp,
	output logic Busy,
	output logic Done
);

logic [1:0] CS;
logic [1:0] NS; 

logic [3:0] n_rnds;

localparam IDLE 	  = 2'b00;
localparam RND_FUNC   = 2'b01;
localparam CYPHER_TXT = 2'b11;
localparam FINISH 	  = 2'b10;

// Round Counter
always @(posedge CLK,negedge rst_n) begin
	if (!rst_n) begin
		n_rnds <= 4'b0000;
	end
	else if (CS == IDLE || n_rnds == 4'b1010) begin
		n_rnds <= 4'b0000;
	end
	else begin
		n_rnds++;
	end
end

// Regsitering state
always @(posedge CLK,negedge rst_n) begin
	if (!rst_n) begin
		CS <= IDLE;
	end
	else begin
		CS <= NS;
	end
end


// States Logic
always @(*) begin
	case (CS)
		IDLE: begin
			if (Valid) begin
				NS = RND_FUNC;
			end
			else begin
				NS = IDLE;
			end
		end
		RND_FUNC: begin
			if (n_rnds == 4'b1000) begin
				NS = CYPHER_TXT;
			end
			else begin
				NS = RND_FUNC;
			end
		end
		CYPHER_TXT: begin
			NS = FINISH;
		end
		FINISH: begin
			if (Valid) begin
				NS = RND_FUNC;
			end
			else begin
				NS = IDLE;
			end
		end
		default: NS = IDLE;
	endcase
end

// State Output
always @(*) begin
	Done    = 1'b0;
	En_Func = 1'b0;
	Busy    = 1'b0;
	En_Exp  = 1'b0;
	if (CS == IDLE) begin
		Done    = 1'b0;
		En_Func = 1'b0;
		En_Exp  = 1'b0;
	end
	else if (CS == RND_FUNC) begin
		En_Func = 1'b1;
		En_Exp  = 1'b1;
		Busy    = 1'b1;
	end
	else if (CS ==  CYPHER_TXT) begin
		Busy    = 1'b1;
	end
	else if (CS == FINISH) begin
		Done    = 1'b1;
	end
	else begin
		Done    = 1'b0;
		En_Func = 1'b0;
		En_Exp  = 1'b0;
	end
end

endmodule