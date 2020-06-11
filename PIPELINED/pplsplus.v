module pplplus
(
input [10:0] in,
input plus,
output [10:0] out
);

assign out = plus? in+1 : in;

endmodule