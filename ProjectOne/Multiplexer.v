module Mux(A, B, C, D, Select, Out);

input [3:0] A, B, C, D;
input [1:0] Select;
output[3:0] Out;
reg [3:0] rOut;

always @(Select)
begin
if(Select[0] == 0)
	begin
		if(Select[1] == 0)
			begin
				 rOut = A;
			end
		else
			begin
				 rOut = B;
			end
	end
else
	begin
	if(Select[1] == 0)
			begin
				 rOut = C;
			end
		else
			begin
				 rOut = D;
			end
	end
end	
assign Out = rOut;


endmodule
