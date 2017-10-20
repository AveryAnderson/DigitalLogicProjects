module Magic(ADC_CLK_10,LEDR,sel);
input ADC_CLK_10;
output reg [9:0] LEDR;
input [1:0] sel;

//Initialize clock slowing toggle and counter
reg slow = 0;
reg [16:0]  counter = 0;
reg [9:0] fakeLED = 1;


//Whenever there is a clock signal increment the counter. Use this counter to create
//a much slower wave named slow.
always @(posedge ADC_CLK_10)
begin
	counter <= counter + 1;
	if ( counter == 16'b1111111111111111)
		begin
			counter <= 0;
			slow <= ~slow;
		end
end

//count will allow us to know when we have reached both ends of the board
reg [4:0] count = 0;

//When ever the slow clock ticks, change the state of the leds
always @ (posedge slow)
begin
	
	//Increment the count, and assign LEDR to be the value of fakeLED
	count <= count + 1;
	LEDR <= fakeLED;
	
	//If the bit of fakeLED has not yet reached the left most LED, move it one
	//space over (left shift it until we count to nine)
	if(count < 9)
	begin
		fakeLED <= fakeLED*2;
	end
	
	//Between 9 and 19, right shift fakeLED
	else
	begin
		fakeLED <= fakeLED/2;
	end
	
	//If count is ninteen, reset count and fakeLED to one
	if(count == 19)
	begin
		count <= 0;
		fakeLED <= 1;
	end
		
	
end

endmodule
