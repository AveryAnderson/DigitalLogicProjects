
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

module AddSubtract(A,B,Cin,SumorMinus,Cout);
  input [3:0] A,B;
  input Cin;
  output [3:0] SumorMinus;
  output Cout;
  wire [3:0] new;
  wire c1, c2, c3;
  
  always @(A or B or Cin)
  assign new[0] = B[0]^Cin;
  assign new[1] = B[1]^Cin;
  assign new[2] = B[2]^Cin;
  assign new[3] = B[3]^Cin;
  
  fourbitAdder addsub(x,new,SumorMinus,cin,cout);
endmodule

module multiply(z,cin,prod,cout);
input [7:0] z;
input cin;
output [7:0] prod;
output cout;

  always @(z)
assign prod = z<<;

endmodule

module divide(z,cin,quotient,remain);
input [7:0] z;
input cin;
output [7:0] quotient;
output remain;

  always @(z)
assign quotient = z>>;

endmodule
