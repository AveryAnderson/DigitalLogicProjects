//G: 8'b10001100
//O: 8'b10000001
//B: 8'b11100000
//U: 8'b11000001
//F: 8'b10111000
//S: 8'b10100100
//Space: 8'b11111111

module Buffs(
clk,HEX1, HEX2, HEX3, HEX4,HEX5, HEX6
);
input clk;
output reg [7:0]HEX1, HEX2, HEX3, HEX4,HEX5, HEX6; 
reg counter = 16'b0000000000000000;
always @(clk)
	begin
	counter = counter +1;
		if(counter % 4500 >= 0 && counter % 4500 <= 499)
		begin
			//GO BUF
			HEX1 = 8'b10001100;
			HEX2 = 8'b10000001;
			HEX3 = 8'b11111111;
			HEX4 = 8'b11100000;
			HEX5 = 8'b11000001;
			HEX6 = 8'b10111000;
		end
			if(counter % 4500 >= 500 && counter % 4500 <= 999)
		begin
			//O BUFF
			HEX1 = 8'b10000001;
			HEX2 = 8'b11111111;
			HEX3 = 8'b11100000;
			HEX4 = 8'b11000001;
			HEX5 = 8'b10111000;
			HEX6 = 8'b10111000;
		end
		if(counter % 4500 >= 1000 && counter % 4500 <= 1499)
		begin
			// BUFFS
			HEX1 = 8'b11111111;
			HEX2 = 8'b11100000;
			HEX3 = 8'b11000001;
			HEX4 = 8'b10111000;
			HEX5 = 8'b10111000;
			HEX6 = 8'b10100100;
		end
		if(counter % 4500 >= 1500 && counter % 4500 <= 1999)
		begin
			//BUFFS 
			HEX1 = 8'b11100000;
			HEX2 = 8'b11000001;
			HEX3 = 8'b10111000;
			HEX4 = 8'b10111000;
			HEX5 = 8'b10100100;
			HEX6 = 8'b11111111;
		end
		if(counter % 4500 >= 2000 && counter % 4500 <= 2499)
		begin
			//UFFS G 
			HEX1 = 8'b11000001;
			HEX2 = 8'b10111000;
			HEX3 = 8'b10111000;
			HEX4 = 8'b10100100;
			HEX5 = 8'b11111111;
			HEX6 = 8'b10001100;
		end
		if(counter % 4500 >= 2500 && counter % 4500 <= 2999)
		begin
			//FFS GO 
			HEX1 = 8'b10111000;
			HEX2 = 8'b10111000;
			HEX3 = 8'b10100100;
			HEX4 = 8'b11111111;
			HEX5 = 8'b10001100;
			HEX6 = 8'b10000001;
		end
		if(counter % 4500 >= 3000 && counter % 4500 <= 3499)
		begin
			//FS GO  
			HEX1 = 8'b10111000;
			HEX2 = 8'b10100100;
			HEX3 = 8'b11111111;
			HEX4 = 8'b10001100;
			HEX5 = 8'b10000001;
			HEX6 = 8'b11111111;
		end
		if(counter % 4500 >= 3500 && counter % 4500 <= 3999)
		begin
			//S GO B 
			HEX1 = 8'b10100100;
			HEX2 = 8'b11111111;
			HEX3 = 8'b10001100;
			HEX4 = 8'b10000001;
			HEX5 = 8'b11111111;
			HEX6 = 8'b11100000;
		end
		if(counter % 4500 >= 4000 && counter % 4500 <= 4499)
		begin
			// GO BU 
			HEX1 = 8'b11111111;
			HEX2 = 8'b10001100;
			HEX3 = 8'b10000001;
			HEX4 = 8'b11111111;
			HEX5 = 8'b11100000;
			HEX6 = 8'b11000001;
		end				
	end

endmodule