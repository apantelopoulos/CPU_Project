module sxtn2lvn
(
input [15:0] in,
output [10:0] out
);

assign out = in[10:0];

endmodule