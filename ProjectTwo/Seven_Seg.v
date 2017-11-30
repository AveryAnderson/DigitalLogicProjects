module Seven_Seg(
	input [3:0] val,
	input noDecimal,
	input [1:0] enable,
	output reg [7:0] HEXX
	);
	
	//Whenever anything changes, run through all sixteen possible numbers that can
	//be represented by the 3 bit number val.  Then using the standard sevenseg display
	//binary representations, store the appropriate value in the passed Hex register
	always @ (*)
	begin
		if(enable == 1)
		begin
			case(val)
				0:  HEXX [7:0] = {noDecimal,7'b1000000};
				1:  HEXX [7:0] = {noDecimal,7'b1111001};
				2:  HEXX [7:0] = {noDecimal,7'b0100100};
				3:  HEXX [7:0] = {noDecimal,7'b0110000};
				4:  HEXX [7:0] = {noDecimal,7'b0011001};
				5:  HEXX [7:0] = {noDecimal,7'b0010010};
				6:  HEXX [7:0] = {noDecimal,7'b0000010};
				7:  HEXX [7:0] = {noDecimal,7'b1111000};
				8:  HEXX [7:0] = {noDecimal,7'b0000000};
				9:  HEXX [7:0] = {noDecimal,7'b0010000};
				10: HEXX [7:0] = {noDecimal,7'b0001000};
				11: HEXX [7:0] = {noDecimal,7'b0000011};
				12: HEXX [7:0] = {noDecimal,7'b1000110};
				13: HEXX [7:0] = {noDecimal,7'b0100001};
				14: HEXX [7:0] = {noDecimal,7'b0000110};
				15: HEXX [7:0] = {noDecimal,7'b0001110};
			endcase
		end
		
		else
		begin
			HEXX [7:0] = 8'b11111111;
		end
	end
		
endmodule