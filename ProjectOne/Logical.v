module Logical(X,Y,sel,out);

input [3:0] X,Y;
input [1:0] sel;
wire [7:0] AOut,OOut,EXOut,NOut;
output [7:0] out;

//Use the built in and, or xor and not functions to assign wire holders
assign AOut  = {4'b0000,X&Y};
assign OOut  = {4'b0000,X|Y};
assign EXOut = {4'b0000,X^Y};
assign NOut  = ~{Y,X};

//use a MUX to assign the proper output of the function
Mux(AOut, OOut, EXOut, NOut, sel, out);

endmodule 