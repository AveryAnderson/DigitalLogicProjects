module Mux(A, B, C, D, Select, Out);

input [7:0] A, B, C, D;
input [1:0] Select;
output[7:0] Out;
reg [7:0] rOut;

//Whenever our select changes, our output changes as well
always @(Select)
begin

//If the MSB is a zero
if(Select[1] == 0)
	begin
	
		//The LSB being zero is the zeroth item. Return A. 01 assigns B
		if(Select[0] == 0)
			begin
				 rOut <= A;
			end
		else
			begin
				 rOut <= B;
			end
	end
	
//IF the MSB is 1, asign C for 10 and D for 11
else
	begin
	if(Select[0] == 0)
			begin
				 rOut <= C;
			end
		else
			begin
				 rOut <= D;
			end
	end
end	

//Assign the true output using our temporary output value
assign Out = rOut;


endmodule