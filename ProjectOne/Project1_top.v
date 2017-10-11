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
