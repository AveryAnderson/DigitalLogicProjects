module LFSR( clock, enable, rand);
	input clock, enable;
	output reg [8:0] rand;
	
	initial rand = 0;
	
	wire feedback = (rand[8] ^ rand[4]) || (rand == 0);
	
	always @ (posedge clock)
	begin
		if(enable)
		begin
			rand <= {rand[7:0],feedback};
		end
	end
	
endmodule 