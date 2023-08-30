// S_Box
// Used for bytes substitution
module S_BOX (
	input  logic [7:0] box_sel,
	output logic [7:0] box_out
);

always @(*) begin
	case (box_sel)
		/********************   1   ********************/
		8'h00              : box_out =  8'h63;
		8'h01              : box_out =  8'h7c;
		8'h02              : box_out =  8'h77;
		8'h03              : box_out =  8'h7b;
		8'h04              : box_out =  8'hf2;
		8'h05              : box_out =  8'h6b;
		8'h06              : box_out =  8'h6f;
		8'h07              : box_out =  8'hc5;
		8'h08              : box_out =  8'h30;
		8'h09              : box_out =  8'h01;
		8'h0a              : box_out =  8'h67;
		8'h0b              : box_out =  8'h2b;
		8'h0c              : box_out =  8'hfe;
		8'h0d              : box_out =  8'hd7;
		8'h0e              : box_out =  8'hab;
		8'h0f              : box_out =  8'h76;
		/********************   2   ********************/
		8'h10              : box_out =  8'hca;
		8'h11              : box_out =  8'h82;
		8'h12              : box_out =  8'hc9;
		8'h13              : box_out =  8'h7d;
		8'h14              : box_out =  8'hfa;
		8'h15              : box_out =  8'h59;
		8'h16              : box_out =  8'h47;
		8'h17              : box_out =  8'hf0;
		8'h18              : box_out =  8'had;
		8'h19              : box_out =  8'hd4;
		8'h1a              : box_out =  8'ha2;
		8'h1b              : box_out =  8'haf;
		8'h1c              : box_out =  8'h9c;
		8'h1d              : box_out =  8'ha4;
		8'h1e              : box_out =  8'h72;
		8'h1f              : box_out =  8'hc0;
		/********************   3   ********************/
		8'h20              : box_out =  8'hb7;
		8'h21              : box_out =  8'hfd;
		8'h22              : box_out =  8'h93;
		8'h23              : box_out =  8'h26;
		8'h24              : box_out =  8'h36;
		8'h25              : box_out =  8'h3f;
		8'h26              : box_out =  8'hf7;
		8'h27              : box_out =  8'hcc;
		8'h28              : box_out =  8'h34;
		8'h29              : box_out =  8'ha5;
		8'h2a              : box_out =  8'he5;
		8'h2b              : box_out =  8'hf1;
		8'h2c              : box_out =  8'h71;
		8'h2d              : box_out =  8'hd8;
		8'h2e              : box_out =  8'h31;
		8'h2f              : box_out =  8'h15;
		/********************   4   ********************/
		8'h30              : box_out =  8'h04;
		8'h31              : box_out =  8'hc7;
		8'h32              : box_out =  8'h23;
		8'h33              : box_out =  8'hc3;
		8'h34              : box_out =  8'h18;
		8'h35              : box_out =  8'h96;
		8'h36              : box_out =  8'h05;
		8'h37              : box_out =  8'h9a;
		8'h38              : box_out =  8'h07;
		8'h39              : box_out =  8'h12;
		8'h3a              : box_out =  8'h80;
		8'h3b              : box_out =  8'he2;
		8'h3c              : box_out =  8'heb;
		8'h3d              : box_out =  8'h27;
		8'h3e              : box_out =  8'hb2;
		8'h3f              : box_out =  8'h75;
		/********************   5   ********************/
		8'h40              : box_out =  8'h09;
		8'h41              : box_out =  8'h83;
		8'h42              : box_out =  8'h2c;
		8'h43              : box_out =  8'h1a;
		8'h44              : box_out =  8'h1b;
		8'h45              : box_out =  8'h6e;
		8'h46              : box_out =  8'h5a;
		8'h47              : box_out =  8'ha0;
		8'h48              : box_out =  8'h52;
		8'h49              : box_out =  8'h3b;
		8'h4a              : box_out =  8'hd6;
		8'h4b              : box_out =  8'hb3;
		8'h4c              : box_out =  8'h29;
		8'h4d              : box_out =  8'he3;
		8'h4e              : box_out =  8'h2f;
		8'h4f              : box_out =  8'h84;
		/********************   6   ********************/
		8'h50              : box_out =  8'h53;
		8'h51              : box_out =  8'hd1;
		8'h52              : box_out =  8'h00;
		8'h53              : box_out =  8'hed;
		8'h54              : box_out =  8'h20;
		8'h55              : box_out =  8'hfc;
		8'h56              : box_out =  8'hb1;
		8'h57              : box_out =  8'h5b;
		8'h58              : box_out =  8'h6a;
		8'h59              : box_out =  8'hcb;
		8'h5a              : box_out =  8'hbe;
		8'h5b              : box_out =  8'h39;
		8'h5c              : box_out =  8'h4a;
		8'h5d              : box_out =  8'h4c;
		8'h5e              : box_out =  8'h58;
		8'h5f              : box_out =  8'hcf;
		/********************   7   ********************/
		8'h60              : box_out =  8'hd0;
		8'h61              : box_out =  8'hef;
		8'h62              : box_out =  8'haa;
		8'h63              : box_out =  8'hfb;
		8'h64              : box_out =  8'h43;
		8'h65              : box_out =  8'h4d;
		8'h66              : box_out =  8'h33;
		8'h67              : box_out =  8'h85;
		8'h68              : box_out =  8'h45;
		8'h69              : box_out =  8'hf9;
		8'h6a              : box_out =  8'h02;
		8'h6b              : box_out =  8'h7f;
		8'h6c              : box_out =  8'h50;
		8'h6d              : box_out =  8'h3c;
		8'h6e              : box_out =  8'h9f;
		8'h6f              : box_out =  8'ha8;
		/********************   8   ********************/
		8'h70              : box_out =  8'h51;
		8'h71              : box_out =  8'ha3;
		8'h72              : box_out =  8'h40;
		8'h73              : box_out =  8'h8f;
		8'h74              : box_out =  8'h92;
		8'h75              : box_out =  8'h9d;
		8'h76              : box_out =  8'h38;
		8'h77              : box_out =  8'hf5;
		8'h78              : box_out =  8'hbc;
		8'h79              : box_out =  8'hb6;
		8'h7a              : box_out =  8'hda;
		8'h7b              : box_out =  8'h21;
		8'h7c              : box_out =  8'h10;
		8'h7d              : box_out =  8'hff;
		8'h7e              : box_out =  8'hf3;
		8'h7f              : box_out =  8'hd2;
		/********************   9   ********************/
		8'h80              : box_out =  8'hcd;
		8'h81              : box_out =  8'h0c;
		8'h82              : box_out =  8'h13;
		8'h83              : box_out =  8'hec;
		8'h84              : box_out =  8'h5f;
		8'h85              : box_out =  8'h97;
		8'h86              : box_out =  8'h44;
		8'h87              : box_out =  8'h17;
		8'h88              : box_out =  8'hc4;
		8'h89              : box_out =  8'ha7;
		8'h8a              : box_out =  8'h7e;
		8'h8b              : box_out =  8'h3d;
		8'h8c              : box_out =  8'h64;
		8'h8d              : box_out =  8'h5d;
		8'h8e              : box_out =  8'h19;
		8'h8f              : box_out =  8'h73;
		/********************   10   ********************/
		8'h90              : box_out =  8'h60;
		8'h91              : box_out =  8'h81;
		8'h92              : box_out =  8'h4f;
		8'h93              : box_out =  8'hdc;
		8'h94              : box_out =  8'h22;
		8'h95              : box_out =  8'h2a;
		8'h96              : box_out =  8'h90;
		8'h97              : box_out =  8'h88;
		8'h98              : box_out =  8'h46;
		8'h99              : box_out =  8'hee;
		8'h9a              : box_out =  8'hb8;
		8'h9b              : box_out =  8'h14;
		8'h9c              : box_out =  8'hde;
		8'h9d              : box_out =  8'h5e;
		8'h9e              : box_out =  8'h0b;
		8'h9f              : box_out =  8'hdb;
		/********************   11   ********************/
		8'ha0              : box_out =  8'he0;
		8'ha1              : box_out =  8'h32;
		8'ha2              : box_out =  8'h3a;
		8'ha3              : box_out =  8'h0a;
		8'ha4              : box_out =  8'h49;
		8'ha5              : box_out =  8'h06;
		8'ha6              : box_out =  8'h24;
		8'ha7              : box_out =  8'h5c;
		8'ha8              : box_out =  8'hc2;
		8'ha9              : box_out =  8'hd3;
		8'haa              : box_out =  8'hac;
		8'hab              : box_out =  8'h62;
		8'hac              : box_out =  8'h91;
		8'had              : box_out =  8'h95;
		8'hae              : box_out =  8'he4;
		8'haf              : box_out =  8'h79;
		/********************   12   ********************/
		8'hb0              : box_out =  8'he7;
		8'hb1              : box_out =  8'hc8;
		8'hb2              : box_out =  8'h37;
		8'hb3              : box_out =  8'h6d;
		8'hb4              : box_out =  8'h8d;
		8'hb5              : box_out =  8'hd5;
		8'hb6              : box_out =  8'h4e;
		8'hb7              : box_out =  8'ha9;
		8'hb8              : box_out =  8'h6c;
		8'hb9              : box_out =  8'h56;
		8'hba              : box_out =  8'hf4;
		8'hbb              : box_out =  8'hea;
		8'hbc              : box_out =  8'h65;
		8'hbd              : box_out =  8'h7a;
		8'hbe              : box_out =  8'hae;
		8'hbf              : box_out =  8'h08;
		/********************   13   ********************/
		8'hc0              : box_out =  8'hba;
		8'hc1              : box_out =  8'h78;
		8'hc2              : box_out =  8'h25;
		8'hc3              : box_out =  8'h2e;
		8'hc4              : box_out =  8'h1c;
		8'hc5              : box_out =  8'ha6;
		8'hc6              : box_out =  8'hb4;
		8'hc7              : box_out =  8'hc6;
		8'hc8              : box_out =  8'he8;
		8'hc9              : box_out =  8'hdd;
		8'hca              : box_out =  8'h74;
		8'hcb              : box_out =  8'h1f;
		8'hcc              : box_out =  8'h4b;
		8'hcd              : box_out =  8'hbd;
		8'hce              : box_out =  8'h8b;
		8'hcf              : box_out =  8'h8a;
		/********************   14   ********************/
		8'hd0              : box_out =  8'h70;
		8'hd1              : box_out =  8'h3e;
		8'hd2              : box_out =  8'hb5;
		8'hd3              : box_out =  8'h66;
		8'hd4              : box_out =  8'h48;
		8'hd5              : box_out =  8'h03;
		8'hd6              : box_out =  8'hf6;
		8'hd7              : box_out =  8'h0e;
		8'hd8              : box_out =  8'h61;
		8'hd9              : box_out =  8'h35;
		8'hda              : box_out =  8'h57;
		8'hdb              : box_out =  8'hb9;
		8'hdc              : box_out =  8'h86;
		8'hdd              : box_out =  8'hc1;
		8'hde              : box_out =  8'h1d;
		8'hdf              : box_out =  8'h9e;
		/********************   15   ********************/
		8'he0              : box_out =  8'he1;
		8'he1              : box_out =  8'hf8;
		8'he2              : box_out =  8'h98;
		8'he3              : box_out =  8'h11;
		8'he4              : box_out =  8'h69;
		8'he5              : box_out =  8'hd9;
		8'he6              : box_out =  8'h8e;
		8'he7              : box_out =  8'h94;
		8'he8              : box_out =  8'h9b;
		8'he9              : box_out =  8'h1e;
		8'hea              : box_out =  8'h87;
		8'heb              : box_out =  8'he9;
		8'hec              : box_out =  8'hce;
		8'hed              : box_out =  8'h55;
		8'hee              : box_out =  8'h28;
		8'hef              : box_out =  8'hdf;
		/********************   16   ********************/
		8'hf0              : box_out =  8'h8c;
		8'hf1              : box_out =  8'ha1;
		8'hf2              : box_out =  8'h89;
		8'hf3              : box_out =  8'h0d;
		8'hf4              : box_out =  8'hbf;
		8'hf5              : box_out =  8'he6;
		8'hf6              : box_out =  8'h42;
		8'hf7              : box_out =  8'h68;
		8'hf8              : box_out =  8'h41;
		8'hf9              : box_out =  8'h99;
		8'hfa              : box_out =  8'h2d;
		8'hfb              : box_out =  8'h0f;
		8'hfc              : box_out =  8'hb0;
		8'hfd              : box_out =  8'h54;
		8'hfe              : box_out =  8'hbb;
		8'hff              : box_out =  8'h16;
		default            : box_out =  8'h00; 
	endcase
end

endmodule