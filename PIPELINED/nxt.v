module nxt
(
input [2:0] S,
input E,
input E2,
output [2:0] NS
);

assign NS[2] = 0;
assign NS[1] = ( E & ~S[1] & S[0] & ~S[2]) | ( E2 & S[1] & ~S[0] & ~S[2] ) ; 
assign NS[0] = ~S[2]&~S[1]&~S[0] | ~E&~S[2]&~S[1]&S[0] | ~E2&~S[2]&S[1]&~S[0] | E2&~S[2]&S[1]&~S[0] | ~S[2]&S[1]&S[0] ;

endmodule