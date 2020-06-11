module lvn2sxtn
(
input [10:0] in,
output [15:0] out
);

assign out[15] = 0;
assign out[14] = 0;
assign out[13] = 0;
assign out[12] = 0;
assign out[11] = 0;
assign out[10:0] = in[10:0];

endmodule