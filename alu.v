module alu
(
input [15:0] instr,
input [15:0] inreg1,
input [15:0] inreg2,
input [15:0] inp,
input carryin,
output [15:0] aluout,
output carryout,
output carryen,
output wenout
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
wire [7:0] op = instr[15:8];
wire [1:0] rd = instr[7:6];
wire [1:0] rm = instr[5:4];
wire [1:0] rn = instr[3:2];
wire carrynbl = instr[1];
wire cin = instr[0]? carryin : 0;

always @(*)
	begin
		case (op)
			
			8'b11111000 : alusum = {1'b0,inreg1} + {1'b0,inreg2} + cin;
			8'b11111001 : alusum = {1'b0,inreg1} - {1'b0,inreg2} + cin;
			8'b11111010 : alusum = {1'b0,inreg1} + 1;
			8'b11111011 : alusum = {1'b0,inreg1} - 1;
			8'b11111100 : alusum = {1'b0,inp};
			8'b11111101 :
				begin
					mul0 = inreg1[0] ? inreg2 : 0;
					mul1 = inreg1[1] ? inreg2 << 1 : 0;
					mul2 = inreg1[1] ? inreg2 << 2 : 0;
					mul3 = inreg1[1] ? inreg2 << 3 : 0;
					mul4 = inreg1[1] ? inreg2 << 4 : 0;
					mul5 = inreg1[1] ? inreg2 << 5 : 0;
					mul6 = inreg1[1] ? inreg2 << 6 : 0;
					mul7 = inreg1[1] ? inreg2 << 7 : 0;
					mul8 = inreg1[1] ? inreg2 << 8 : 0;
					mul9 = inreg1[1] ? inreg2 << 9 : 0;
					mul10 = inreg1[1] ? inreg2 << 10 : 0;
					mul11 = inreg1[1] ? inreg2 << 11 : 0;
					mul12 = inreg1[1] ? inreg2 << 12 : 0;
					mul13 = inreg1[1] ? inreg2 << 13 : 0;
					mul14 = inreg1[1] ? inreg2 << 14 : 0;
					mul15 = inreg1[1] ? inreg2 << 15 : 0;
					mul = mul0 + mul1 + mul2 + mul3 + mul4 + mul5 + mul6 + mul7 + mul8 + mul9 + mul10 + mul11 + mul12 + mul13 + mul14 + mul15; 
					alusum = mul[16:0];				
				end 
			
	endcase
	
	end

assign alucout = alusum [16]; // carry bit from sum, or shift if OP = 011
assign aluout = alusum [15:0];

	
endmodule
	