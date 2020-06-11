module alu
(
input [15:0] instr,
input [15:0] inreg1,
input [15:0] inreg2,
input carrystatus,
input exec1,
output [15:0] aluout,
output [1:0] regM,
output sel_mux_mem_alu,
output sel_mux_inp,
output output_en,
output carryout,
output carryen,
output wenout,
output [1:0] RegN,
output [1:0] RegD,
output sel_mux_regD
);

reg [31:0] mul0;
reg [31:0] mul1;
reg [31:0] mul2;
reg [31:0] mul3;
reg [31:0] mul4;
reg [31:0] mul5;
reg [31:0] mul6;
reg [31:0] mul7;
reg [31:0] mul8;
reg [31:0] mul9;
reg [31:0] mul10;
reg [31:0] mul11;
reg [31:0] mul12;
reg [31:0] mul13;
reg [31:0] mul14;
reg [31:0] mul15;
reg [31:0] mul;

reg [16:0] alusum;
wire regwork = instr[15]&instr[14]&instr[13]&instr[12]&instr[11];
wire [7:0] op = instr[15:8];
wire [1:0] rd = instr[7:6];
wire [1:0] rm = instr[5:4];
wire [1:0] rn = instr[3:2];
wire carrynbl = instr[1];
wire cin = instr[0]? carrystatus : 0;


assign regM = rm;
assign RegN = rn;
assign RegD = rd;

assign sel_mux_mem_alu = regwork;
assign sel_mux_inp = exec1&instr[15]&instr[14]&instr[13]&instr[12]&instr[11]&instr[10]&~instr[9]&~instr[8];
assign sel_mux_regD = regwork;

assign output_en = exec1&instr[15]&instr[14]&instr[13]&instr[12]&instr[11]&instr[10]&~instr[9]&instr[8];
assign carryen = exec1&carrynbl;
assign wenout = exec1&regwork&~(instr[15]&instr[14]&instr[13]&instr[12]&instr[11]&instr[10]&~instr[9]&instr[8]);





always @(*)
	begin
		case (op)
			
			8'b11111000 : alusum = {1'b0,inreg1} + {1'b0,inreg2} + cin;
			8'b11111001 : alusum = {1'b0,inreg1} - {1'b0,inreg2} + cin;
			8'b11111010 : alusum = {1'b0,inreg1} + 1;
			8'b11111011 : alusum = {1'b0,inreg1} - 1;
			8'b11111110 :
				begin
					mul0 = inreg1[0] ? inreg2 : 0;
					mul1 = inreg1[1] ? inreg2 << 1 : 0;
					mul2 = inreg1[2] ? inreg2 << 2 : 0;
					mul3 = inreg1[3] ? inreg2 << 3 : 0;
					mul4 = inreg1[4] ? inreg2 << 4 : 0;
					mul5 = inreg1[5] ? inreg2 << 5 : 0;
					mul6 = inreg1[6] ? inreg2 << 6 : 0;
					mul7 = inreg1[7] ? inreg2 << 7 : 0;
					mul8 = inreg1[8] ? inreg2 << 8 : 0;
					mul9 = inreg1[9] ? inreg2 << 9 : 0;
					mul10 = inreg1[10] ? inreg2 << 10 : 0;
					mul11 = inreg1[11] ? inreg2 << 11 : 0;
					mul12 = inreg1[12] ? inreg2 << 12 : 0;
					mul13 = inreg1[13] ? inreg2 << 13 : 0;
					mul14 = inreg1[14] ? inreg2 << 14 : 0;
					mul15 = inreg1[15] ? inreg2 << 15 : 0;
					mul = mul0 + mul1 + mul2 + mul3 + mul4 + mul5 + mul6 + mul7 + mul8 + mul9 + mul10 + mul11 + mul12 + mul13 + mul14 + mul15; 
					alusum = mul[16:0];				
				 
				end 
			8'b11111111 : alusum = {1'b0,inreg1} >> instr[3:0];
			
	endcase
	
	end

assign carryout = alusum [16]; 
assign aluout = alusum [15:0];

	
endmodule
	