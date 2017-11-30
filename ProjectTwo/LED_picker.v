/*module LED_picker(Clock,LEDR,state);
input Clock;
output reg [8:0] LEDR;
input [1:0] state;

reg [9:0] fakeLED = 1;


//count will allow us to know when we have reached both ends of the board
reg [4:0] count = 0;

//When ever the slow clock ticks, change the state of the leds
always @ (posedge Clock)
begin
	if(1)//state != 3)
	begin
		//Increment the count, and assign LEDR to be the value of fakeLED
		count <= count + 1;
		LEDR <= fakeLED;
		
		//If the bit of fakeLED has not yet reached the left most LED, move it one
		//space over (left shift it until we count to nine)
		if(count < 8)
		begin
			fakeLED <= fakeLED*2;
		end
		
		//Between 9 and 19, right shift fakeLED
		else
		begin
			fakeLED <= fakeLED/2;
		end
		
		//If count is ninteen, reset count and fakeLED to one
		if(count == 17)
		begin
			count <= 0;
			fakeLED <= 1;
		end
	end
	
end

endmodule*/
