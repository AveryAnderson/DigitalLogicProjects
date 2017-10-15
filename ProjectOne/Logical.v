module Logical(X,Y,sel,out);

input [3:0] X,Y;
input [1:0] sel;
wire [7:0] AOut,OOut,EXOut,NOut;
output [7:0] out;

assign AOut  = {4'b0000,X&Y};
assign OOut  = {4'b0000,X|Y};
assign EXOut = {4'b0000,X^Y};
assign NOut  = ~{Y,X};

Mux(AOut, OOut, EXOut, NOut, sel, out);

endmodule
