module LFSR( clock, state, rando);
	input 			  clock;
	input 	  [1:0] state;
	output reg [8:0] rando;
	
	initial rando = 0;
	
	wire feedback = (rando[8] ^ rando[4]) || (rando == 0);
	
	always @ (posedge clock)
	begin
		if(state == 1)
		begin
			rando <= {rando[7:0],feedback};
		end
	end
	
endmodule 