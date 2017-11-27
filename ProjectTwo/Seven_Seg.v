module Seven_Seg(
	input [3:0] val,
	output reg [7:0] HEXX
	);
	
	//Whenever anything changes, run through all sixteen possible numbers that can
	//be represented by the 3 bit number val.  Then using the standard sevenseg display
	//binary representations, store the appropriate value in the passed Hex register
	always @ (*)
		case(val)
			0:  HEXX [7:0] = 8'b11000000;
			1:  HEXX [7:0] = 8'b11111001;
			2:  HEXX [7:0] = 8'b10100100;
			3:  HEXX [7:0] = 8'b10110000;
			4:  HEXX [7:0] = 8'b10011001;
			5:  HEXX [7:0] = 8'b10010010;
			6:  HEXX [7:0] = 8'b10000010;
			7:  HEXX [7:0] = 8'b11111000;
			8:  HEXX [7:0] = 8'b10000000;
			9:  HEXX [7:0] = 8'b10010000;
			10: HEXX [7:0] = 8'b10001000;
			11: HEXX [7:0] = 8'b10000011;
			12: HEXX [7:0] = 8'b11000110;
			13: HEXX [7:0] = 8'b10100001;
			14: HEXX [7:0] = 8'b10000110;
			15: HEXX [7:0] = 8'b10001110;
			endcase
	
endmodule