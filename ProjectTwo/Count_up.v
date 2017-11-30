module Count_up(clock, state, count);
	input             clock;
	input 	  [ 1:0] state;
	output reg [19:0] count;

	
	always @ (posedge clock)
	begin
		if(state == 2)
		begin
			count = 0;
		end
		
		else if (state == 3)
		begin
			count = count + 1;
			
			if(count[3:0] == 10)
			begin
				count[3:0] = 0;
				count[7:4] = count[7:4] + 1;
			end
			
			if(count[7:4] == 10)
			begin
				count[7:4] = 0;
				count[11:8] = count[11:8] + 1;
			end
			
			if(count[11:8] == 10)
			begin
				count[11: 8] = 0;
				count[15:12] = count[15:12] + 1;
			end
			
			if(count[15:12] == 10)
			begin
				count[15:12] = 0;
				count[19:16] = count[19:16] + 1;
			end
			
			
			if(count[19:16] == 10)
			begin
				count[19:16] = 0;
			end
			
		end
		
	end
	
endmodule 