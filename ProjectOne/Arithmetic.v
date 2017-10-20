
//This module adds, subtracts, multiplies and divides X and Y
module Arithmetic(X,Y, sel, out, LEDR);
	input [3:0] X,Y;
	input [1:0] sel;
	output [7:0] out;
	output reg [9:0] LEDR;

	//Initialize the operation outputs
	wire [4:0] Add,Subt;
	wire [8:0] Mult,Div;

	//Initialize the holder possible output LED variables
	wire [9:0] ALED, SLED, MLED, DLED;
	fourbitadder(X,Y,0,Add,ALED);
	subtract(X,Y,Subt,SLED);
	multiply({Y,X},Mult,MLED);
	divide({Y,X},Div,DLED);
	
	//We only want to send one set of LED information at a time, this case
	//statement chooses the one we want.
	always @ (sel)
	begin
		case (sel)
			0: LEDR <= ALED;
			1: LEDR <= ~SLED;
			2: LEDR <= MLED;
			3: LEDR <= DLED;
		endcase
	end
		
	//The multiplexer chooses the correct operation output
	Mux(Add, Subt, Mult, Div, sel, out);
  
endmodule 

//The fourfourbitadder uses two bit adders to find the sum.
module fourbitadder(x, y, cin, sum, ALED);
	input [3:0] x,y;
	input cin;
	output [4:0] sum;
	output reg [9:0] ALED;
	wire c1, c2, c3, cout;
	  
	//Call each of the individual 2 bit adders and their respective carries
	Twobitfulladder s1(x[0], y[0], cin, sum[0], c1);
	Twobitfulladder s2(x[1], y[1], c1, sum[1], c2);
	Twobitfulladder s3(x[2], y[2], c2, sum[2], c3);
	Twobitfulladder s4(x[3], y[3], c3, sum[3], cout);
	
	//Return the extra carry bit which overflows our number.  Toggle the LED if
	//this overflow exists.
	assign sum[4] = cout;
	always @ (~(cout ^ c3))
	begin
		if(cout)
		begin
			ALED <= 10'b1111111111;
		end
		else
		begin
			ALED <= 10'b0000000000;
		end
	end
  
endmodule


//The two bit full adder.
module Twobitfulladder(x,y,cin,sout,cout);
  input x, y, cin;
  output sout, cout;
  wire s1, c1, c2;
  
  assign s1 = x^y;
  assign c1 = x&y;
  assign c2 = s1&cin;
  assign sout = s1^cin;
  assign cout = c1|c2;
  
endmodule


//The subtract module uses the four bit full adder to subtract x from y
module subtract(x,y,minus, SLED);
  input [3:0] x,y;
  output [3:0] minus;
  output [9:0] SLED;
  wire [3:0] ynew;
  
  //This method of subtraction requires the two's complement of y
  assign ynew[0] = y[0]^1;
  assign ynew[1] = y[1]^1;
  assign ynew[2] = y[2]^1;
  assign ynew[3] = y[3]^1;
    
  //Call the four bit adder. 
  fourbitadder( .x(x), .y(ynew), .cin(1), .sum(minus), .ALED(SLED));
  assign SLED = ~SLED;
 
endmodule

//The multiply module uses a right shift to multiply the number by two
module multiply(z,prod,MLED);
  input [7:0] z;
  output [7:0] prod;
  output reg [9:0] MLED;
  wire [8:0] check;
  
  //Right shift the number to multiply it by two
  assign check = z << 1;
  
  //If the far right bit was a 1, it has now overflown, turn on the LEDs
  always @ (z)
  begin
    if (z[7])
	 begin
      MLED <= 10'b1111111111;
	 end
	 else
	 begin
		MLED <= 10'b0000000000;
	 end
  end
  
  //assign the output
  assign prod = check;
  
endmodule

//The divide module is exactly the same as the multiply, except it uses a left shift
module divide(z,divided,DLED);
  input [7:0] z;
  output [7:0] divided;
  output reg [9:0] DLED;
  wire [7:0] check;
  
  //Divide the number by two 
  assign check = z >> 1;
  
  //Check to see if the far right bit (the one we lose) was a one.
  always @ (z)
  begin
    if (z[0])
	 begin
      DLED <= 10'b1111111111;
	 end
	 else
	 begin
		DLED <= 10'b0000000000;
	 end
  end
 
  assign divided = check;
  
endmodule
