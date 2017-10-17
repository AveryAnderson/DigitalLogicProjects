module Comparison(X, Y, Select, Out);

input [3:0] X,Y;
input [1:0] Select;
output[7:0] Out;
wire [7:0] EQ, GR, LT, MX;

EQUAL E (.X(X), .Y(Y), .Z(EQ));
GREATER G (.X(X), .Y(Y), .Z(GR));
LESS_THAN L (.X(X), .Y(Y), .Z(LT));
MAX M (.X(X), .Y(Y), .Z(MX));

Mux MU ({4'b0000,EQ}, {4'b0000,GR}, {4'b0000,LT}, {4'b0000,MX}, Select, Out); 

//	//begin
//		if (Select[0]==0)
//			begin
//				if(Select[1] == 0)
//					begin
//						EQUAL E (X, Y,rOut);
//					end
//				else //if(Select[1] == 1)
//					begin
//						GREATER G (X, Y, rOut);
//					end
//			end
//		else
//			begin
//				if(Select[1] == 0)
//					begin
//						LESS_THAN LT (X, Y, rOut);
//					end
//				else //if (Select[1] == 1)
//					begin
//						MAX M (X,Y, rOut);
//					end
//		 end
//	//end
//	
//assign Out = rOut;

endmodule

module EQUAL(X, Y, Z);

input [3:0] X,Y;
output Z;
wire[3:0] W;
wire out1, out2;

EQUALS_gate E1 (X[3], Y[3], W[3]);
EQUALS_gate E2 (X[2], Y[2], W[2]);
EQUALS_gate E3 (X[1], Y[1], W[1]);
EQUALS_gate E4 (X[0], Y[0], W[0]);

AND_gate A1 (W[3], W[2], out1);
AND_gate A2 (W[1], W[0], out2);
AND_gate A3 (out1, out2, Z);


endmodule



module GREATER(X, Y, Z);

input [3:0] X,Y;
output Z;
wire [3:0] G, S;
wire[4:0] W;
wire OR1, OR2;

BIT_GREATER BG1 (X[3], Y[3], G[3], S[3]);
BIT_GREATER BG2 (X[2], Y[2], G[2], S[2]);
BIT_GREATER BG3 (X[1], Y[1], G[1], S[1]);
BIT_GREATER BG4 (X[0], Y[0], G[0], S[0]);

AND_gate AND1 (S[3], G[2], W[0]);
AND_gate AND2 (S[3], S[2], W[1]);
AND_gate AND3 (W[1], G[1], W[2]);
AND_gate AND4 (W[1], S[1], W[3]);
AND_gate AND5 (W[3], G[0], W[4]);

OR_gate O1 (G[3],W[0], OR1);
OR_gate O2 (W[2], W[4], OR2);
OR_gate O3 (OR1, OR2, Z);

endmodule



module LESS_THAN(X,Y,Z);

input [3:0] X,Y;
output Z;
wire [2:0] W;

EQUAL E1(X,Y, W[0]);
GREATER G1(X,Y,W[1]);
OR_gate O1 (W[0], W[1], W[2]);
NOT_gate N1(W[2], Z);



endmodule



module MAX(X, Y, Z);
input [3:0] X,Y;
output [3:0] Z;
wire GT, NGT;
wire [3:0] XGT, YNGT;

GREATER G1 (X, Y, GT);
NOT_gate N1 (GT, NGT);

AND_gate A1 (GT, X[0], XGT[0]);
AND_gate A2 (GT, X[1], XGT[1]);
AND_gate A3 (GT, X[2], XGT[2]);
AND_gate A4 (GT, X[3], XGT[3]);

AND_gate A5 (NGT, Y[0], YNGT[0]);
AND_gate A6 (NGT, Y[1], YNGT[1]);
AND_gate A7 (NGT, Y[2], YNGT[2]);
AND_gate A8 (NGT, Y[3], YNGT[3]);

OR_gate O1 (XGT[0], YNGT[0], Z[0]);
OR_gate O2 (XGT[1], YNGT[1], Z[1]);
OR_gate O3 (XGT[2], YNGT[2], Z[2]);
OR_gate O4 (XGT[3], YNGT[3], Z[3]);

endmodule



module BIT_GREATER(X, Y, X_GREATER, BITS_SAME);

input X, Y;
output X_GREATER, BITS_SAME;
wire W1, W2, W3, W4;

AND_gate AND1 (X,Y, W1);

OR_gate OR1 (X, Y, W2);

NOT_gate NOT1 (W2, W3);

OR_gate OR2 (W1, W3, BITS_SAME);

NOT_gate NOT2 (Y, W4);

AND_gate AND2 (X, W4, X_GREATER);

endmodule





module OR_gate(x,y,z);
input x,y;
output z;
assign z = x|y;
endmodule

module AND_gate(x,y,z);
input x,y;
output z;
assign z = x&y;
endmodule

module XOR_gate(x,y,z);
input x,y;
output z;
assign z = x^y;
endmodule

module NOT_gate(x, z);
input x;
output z;
assign z = ~x;
endmodule

module EQUALS_gate(x, y, z);
input x, y;
output z;
wire[3:0] w;
AND_gate A1 (x, y, w[0]);
NOT_gate N1 (x, w[1]);
NOT_gate N2 (y, w[2]);
AND_gate A2 (w[1],w[2],w[3]);
OR_gate O1(w[3],w[0],z);
endmodule