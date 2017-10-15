module myTop(SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR,ADC_CLK_10,KEY);
input [9:0] SW;
output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output [9:0] LEDR;
input ADC_CLK_10;
input [1:0] KEY;
wire [3:0] X,Y;


assign X = SW[3:0];
assign Y = SW[7:4];

reg [1:0] buttonSel = 0;
reg [1:0] switchSel = 0;

always @ (SW[9:8])
begin
	switchSel[0] <= SW[8];
	switchSel[1] <= SW[9];
end

always @ (posedge KEY[0])
begin
	buttonSel <= buttonSel + 1;
end

wire [7:0] COut,LOut,AOut,MOut, Out;
Comparison(X, Y, buttonSel, COut);
Logical(X,Y, buttonSel, LOut);
Arithmetic(X,Y, buttonSel, AOut);
assign MOut = 0;

Mux(COut,LOut,AOut,MOut,switchSel,Out);


SevenSegment(X, HEX0);
SevenSegment(Y, HEX1);
SevenSegment(switchSel, HEX2);
SevenSegment(buttonSel, HEX3);
SevenSegment(Out[3:0], HEX4);
SevenSegment(Out[7:4], HEX5);

//SevenSegment(buttonSel,HEX0);

endmodule






/*
This is Joe's stuff
module Project1_Top(Button, Switch, Clock);

input [1:0] Button;
input [3:0] Switch;
input Clock;

reg slow = 0;
reg [4:0]  counter = 0;

always @(posedge Clock)
begin
	counter <= counter + 1;
	if ( counter == 20)
		begin
			counter <= 0;
			slow <= ~slow;
		end
end

always @( Button or Switch)
begin



end
*/
