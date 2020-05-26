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
	output sel_mux_din_reg2,
	output sel_mux_output,
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
wire otp = instr[15]&instr[14]&instr[13]&instr[12]&~instr[11];

wire regwork = instr[15]&instr[14]&instr[13]&instr[12]&instr[11];
wire inp = regwork&~instr[10]&instr[9]&~instr[8];

assign extra = (lda | ldn | stn | adn | otp);
assign extra2 = (ldn | adn);
assign pc_cnt_en = exec1&~(jeq&eq | jmp) | exec1&(ldi|pls|sta|inp) | exec2&(lda|stn|otp) | exec3&(ldn|adn) | exec1&regwork;
assign pc_sload = exec1&(jeq&eq | jmp);
assign wrenreg = exec2&lda | exec3&ldn | exec3&adn | exec1&ldi | exec1&inp;
assign sel_mux_adr_rom = exec1&jeq&eq | exec1&jmp;
assign sel_mux_adr_ram = exec2&lda | exec2&ldn | exec3&ldn | exec2&stn | exec2&adn | exec3&adn | exec2&otp;
assign wrenram = sta&exec1 | stn&exec2 | pls&exec1;
assign sel_mux_din_reg = adn;
assign sel_mux_lds = ldi;
assign sel_mux_din_reg2 = inp;
assign sel_mux_output = otp&exec2;
assign sel_mux_din_ram = pls;
endmodule