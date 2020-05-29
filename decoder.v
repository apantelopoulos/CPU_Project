module decoder
(
	input [15:0] instr,
	input fetch,
	input exec1,
	input exec2,
	input exec3,
	input eq,
	output extra,
	output extra2,
	output pc_cnt_en,
	output pc_sload,
	output wrenreg,
	output sel_mux_adr_rom,
	output sel_mux_adr_ram,
	output wrenram,
	output sel_mux_din_reg,
	output sel_mux_lds,
	output sel_mux_din_ram
);

wire lda = ~instr[15]&~instr[14]&~instr[13];
wire sta = ~instr[15]&~instr[14]&instr[13];
wire ldn = ~instr[15]&instr[14]&~instr[13];
wire stn = ~instr[15]&instr[14]&instr[13];
wire ldi = instr[15]&~instr[14]&~instr[13];
wire adn = instr[15]&~instr[14]&instr[13];
wire jeq = instr[15]&instr[14]&~instr[13];

wire jmp = instr[15]&instr[14]&instr[13]&~instr[12]&~instr[11];
wire pls = instr[15]&instr[14]&instr[13]&~instr[12]&instr[11];
wire stp = instr[15]&instr[14]&instr[13]&instr[12]&~instr[11];

wire regwork = instr[15]&instr[14]&instr[13]&instr[12]&instr[11];


assign extra = (lda | ldn | stn | adn);
assign extra2 = (ldn | adn);
assign pc_cnt_en = ~stp&(exec1&~(jeq&eq | jmp) | exec1&(ldi|pls|sta) | exec2&(lda|stn) | exec3&(ldn|adn) | exec1&regwork);
assign pc_sload = exec1&(jeq&eq | jmp);
assign wrenreg = exec2&lda | exec3&ldn | exec3&adn | exec1&ldi;
assign sel_mux_adr_rom = exec1&jeq&eq | exec1&jmp;
assign sel_mux_adr_ram = exec2&lda | exec2&ldn | exec3&ldn | exec2&stn | exec2&adn | exec3&adn;
assign wrenram = sta&exec1 | stn&exec2 | pls&exec1;
assign sel_mux_din_reg = adn;
assign sel_mux_lds = ldi;
assign sel_mux_din_ram = pls;
endmodule