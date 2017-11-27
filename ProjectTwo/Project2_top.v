module Project2_top( Clk_10M, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	input 		  Clk_10M;
	output [7:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input	 [1:0]  KEY;
	output [9:0]  LEDR;
	input  [9:0]  SW;
	
endmodule