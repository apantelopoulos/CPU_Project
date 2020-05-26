module alu
(
input [15:0] instr,
input [15:0] inreg1,
input [15:0] inreg2,
input carrryin,
output [15:0] aluout,
output carryout,
output carryen,
output wenout
);




reg [16:0] alusum;
wire [7:0] op = [15:8] instr;
wire [1:0] rd = [7:6] instr;
wire [1:0] rm = [5:4] instr;
wire [1:0] rn = [3:2] instr;
wire carryen = instr[1];
wire cin = instr[0]? carryin : 0;

always @(*)
	begin
		case (op)
			
			8'b11111000 : alusum = {1'b0,inreg1} + {1'b0,inreg2} + cin;
			8'b11111001 : alusum = {1'b0,inreg1} - {1'b0,inreg2} + cin;
			8'b11111010 : alusum = {1'b0,inreg1} + 1;
			8'b11111011 : alusum = {1'b0,inreg1} - 1;
			
	endcase
	
	end
	
	
	