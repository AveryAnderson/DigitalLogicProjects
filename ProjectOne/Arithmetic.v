
module Arithmetic(A,B,Cin,Pout,Mout,Sout,Dout);
input A, B, Cin;
output Pout, Mout, Sout, Dout;
wire ;

endmodule

module fourbitAdder(x,y,sum,cin,cout); 
input [3:0] x,y;
input cin;
output [3:0] sum;
output cout;
wire c1, c2, c3;

Twobitfulladder s1(x[0], y[0], cin, sum[0], c1);
Twobitfulladder s2(x[1], y[1], c1, sum[1], c2);
Twobitfulladder s3(x[2], y[2], c2, sum[2], c3);
Twobitfulladder s4(x[3], y[3], c3, sum[3], cout);

endmodule

module Twobitfulladder(x,y,cin,sout,cout);
input x, y, cin;
output sout, cout;
wire s1, c1, c2;

assign s1 = x^y;
assign c1 = x&y;
assign c2 = s1&cin;
assign sout = s1^cin;
assign cout = c1|c2;

endmodule

module subtract(x,y,minus,cin,cout);
input [3:0] x,y;
input cin;
output [3:0] minus;
output cout;
wire c1, c2, c3, ynew;

assign ynew = x^y;

fourbitAdder subtract(x,ynew,minus,cin,cout)
endmodule

module 

module multiply(z,cin,prod,cout);
input [7:0] z;
input cin;
output [7:0] prod;
output cout;

assign prod = z<<;

endmodule

module divide(z,cin,quotient,remain);
input [7:0] z;
input cin;
output [7:0] quotient;
output remain;

assign quotient = z>>;

endmodule
