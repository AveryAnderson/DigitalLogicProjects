module Count_down(clock, start, state, done);

	//Function parameters
	input    		clock; //The 1kHz clock
	input    [8:0] start; //The LFSR generated number we count down from
	input    [1:0] state; //The state of the machine
	output reg     done;  //The flag that our counting is done
		
	reg      [8:0] count;    //The number we will actually be counting with
	
	//Whenever our LFSR output changes, change the count to match the output
	//Whenever we are not in state two, reset done to 0;
	/*always @ (start or state)
	begin
		if(state == 1)
		begin
			count = start;
		end
		
		if(state != 2)
		begin
			done = 0;
		end
		
	end*/
	
	//Every time the clock rises, we want to count down one.  When we reach zero, we
	//are done. Set the boolean so the higher level logic can change the state.
	always @ (posedge clock)
	begin
		if(state == 1)
		begin
			count = start;
		end
		
		if(state != 2)
		begin
			done = 0;
		end
	
	
		if(state == 2)
		begin
			if(count == 0)
			begin
				done = 1;
			end
			
			else
			begin
				count = count - 1;
			end
		end
	end
	
	
endmodule 