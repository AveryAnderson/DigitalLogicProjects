module Magic(ADC_CLK_10,LEDR,sel);
input ADC_CLK_10;
output reg [9:0] LEDR;
input [1:0] sel;

//Initialize clock slowing toggle and counter
reg slow = 0;
reg [16:0]  counter = 0;
reg [9:0] fakeLED = 1;


//Whenever there is a clock signal increment the counter
always @(posedge ADC_CLK_10)
begin
	counter <= counter + 1;
	if ( counter == 16'b1111111111111111)
		begin
			counter <= 0;
			slow <= ~slow;
		end
end

reg [4:0] count = 0;


always @ (posedge slow)
begin
	if(sel == 3)
	begin
		count <= count + 1;
		LEDR <= fakeLED;
		if(count < 9)
		begin
			fakeLED <= fakeLED*2;
		end
		else
		begin
			fakeLED <= fakeLED/2;
		end
		if(count == 19)
		begin
			count <= 0;
			fakeLED <= 1;
		end
		
		if(LEDR == 1024)
		begin
			LEDR <= 0;
			fakeLED = 1;
		end
	end
	else
	begin
		LEDR <= 0;
	end
end

endmodule
