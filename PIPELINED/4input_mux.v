module fourinputmux (

input a,                 // 4-bit input called a
input b,                 // 4-bit input called b
input c,                 // 4-bit input called c
input d,                 // 4-bit input called d
input [1:0] sel,               // input sel used to select between a,b,c,d
output out);             // 4-bit output based on input sel
 
   
   assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a); 
 
endmodule


