module out
(
input [2:0] S,
output FETCH,
output EXEC1,
output EXEC2,
output EXEC3
);

assign FETCH = ~S[2]&~S[1]&~S[0] ; 
assign EXEC1 = ~S[2]&~S[1]&S[0] ;
assign EXEC2 = ~S[2]&S[1]&~S[0] ;
assign EXEC3 = ~S[2]&S[1]&S[0] ;

endmodule