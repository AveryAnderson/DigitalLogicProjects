module myTop(SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR,ADC_CLK_10,KEY);
//Initialization of all of the inputs and outputs of the system
input [9:0] SW;
output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output reg [9:0] LEDR;
input ADC_CLK_10;
input [1:0] KEY;

//Create X and Y variables based off of the proper switches
wire [3:0] X,Y;
assign X = SW[3:0];
assign Y = SW[7:4];

//Initialize the output selection registers
reg [1:0] buttonSel = 0;
reg [1:0] switchSel = 0;

//Assign the proper switches to control the switchSel register
always @ (SW[9:8])
begin
	switchSel[0] <= SW[8];
	switchSel[1] <= SW[9];
end

//Increment the value of the buttonSel register whenever it is pressed
always @ (posedge KEY[0])
begin
	buttonSel <= buttonSel + 1;
end

//Create and store the proper values for each of the main outputs
wire [7:0] COut,LOut,AOut,MOut, Out;
wire [9:0] ALED, MLED;
Comparison(X, Y, switchSel, COut);
Logical(X,Y, switchSel, LOut);
Arithmetic(X,Y, switchSel, AOut, ALED[9:0]);
Magic(ADC_CLK_10, MLED[9:0], switchSel);
assign MOut = 0;

//Use Mux to assign the proper output value to the total output
Mux(COut,LOut,AOut,MOut,buttonSel,Out);

//We can only have one system controlling the LEDs at a time.
//For that reason we need to control the driving of the LEDS using the buttonSEl
always @ (buttonSel)
begin
case(buttonSel)
	0: LEDR <= 0;
	1: LEDR <= 0;
	2: LEDR <= ALED;
	3: LEDR <= MLED;
endcase
end

//Write every number to the sevenseg display.
SevenSegment(X, HEX0);
SevenSegment(Y, HEX1);
SevenSegment(buttonSel, HEX2);
SevenSegment(switchSel, HEX3);
SevenSegment(Out[3:0], HEX4);
SevenSegment(Out[7:4], HEX5);

endmodule
