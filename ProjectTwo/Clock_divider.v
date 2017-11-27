//We are passing in a 10MHz clock and outputting a 1kHz clock
module Clock_divider(inClock, outClock);
	input inClock;
	output reg outClock;
	
	//Dividing a 10MHz signal by 10,000 will produce a 1kHz signal
	reg countTo = 0;
	
	//In order to make this division, toggle the outClock each time we
	//pass half of the desired period.  So count to 5,000. Include zero
	//as one of the counts.
	always @ (posedge inClock) 
	begin
		countTo <= countTo + 1;
		if(countTo == 4999)
		begin
			countTo  <= 0;
			outClock <= ~outClock;
		end
	end
	
endmodule