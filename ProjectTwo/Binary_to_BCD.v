module Binary_to_BCD(binary, BCD);
	input   [19:0] binary;
	output  [19:0] BCD;
	
	wire  	  [3:0]  BCD1,BCD2,BCD3,BCD4,BCD5;
	wire  				c1,c2,c3,c4,c5;
	
	convert cvt1(binary[ 3: 0],0 ,BCD1,c1);
	convert cvt2(binary[ 7: 4],c1,BCD2,c2); 
	convert cvt3(binary[11: 8],c2,BCD3,c3);
	convert cvt4(binary[15:12],c3,BCD4,c4);
	convert cvt5(binary[19:16],c4,BCD5,c5);
	
	assign BCD = {BCD5,BCD4,BCD3,BCD2,BCD1};
	
endmodule

module convert(binaryIn, carryIn, BCDOut, carryOut);
	 input      [3:0] binaryIn;
	 input 	         carryIn;
	 
	 output reg [3:0] BCDOut;
	 output reg       carryOut;
	 
	always @ (*)
	begin
		if((binaryIn + carryIn) > 16)
		begin
			carryOut = 1;
			BCDOut   = binaryIn + carryIn;
		end
		
		else if((binaryIn + carryIn) > 9)
		begin
			carryOut = 1;
			BCDOut   = binaryIn + carryIn + 6;
		end
		
		else
		begin
			carryOut = 0;
			BCDOut   = binaryIn + carryIn;
		end
		
	end
	 
	  
	 
	 
endmodule