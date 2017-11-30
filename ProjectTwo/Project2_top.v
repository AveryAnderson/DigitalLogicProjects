module Project2_top( Clk_10M, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	input 		      Clk_10M;
	output     [7:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input	     [1:0]  KEY;
	output reg [9:0]  LEDR;
	input      [9:0]  SW;
	/**** DECLARATION OF VARIABLES ****/
	
	//Flag that limits change of state to the release of a button
	reg deltaKEY;
	
	//The 1kHz Clock
	wire  Clk_1K;
	
	//The state of the machine
	reg  [1:0] state;
	
	//Initialize random countdown time and the switch that determines our shutoff.
	wire [8:0] countdown;
	reg  [2:0] shifted;
	
	//Flag that we have finished counting down and can enter the third state
	wire endCD;
	
	//The Highscore and current score of the system
	reg  [19:0] BCDHighScore = 99999;
	wire [19:0] BCDCurrentScore;
	
	//Only one score can be displayed at a time, so the display wire and register control the HEXoutput
	reg  [19:0] Display;
	wire [19:0] DISPLAY;
	assign DISPLAY = Display;
	
	//The GOBUFFS module generates outputs for each hex display
	wire [7:0]  GBH0, GBH1, GBH2, GBH3, GBH4, GBH5;
	
	/**** MODULE CALLS ****/
	
	//Generate the 1kHz clock from the 10MHz
	Clock_divider cdiv1(Clk_10M, Clk_1K);
	
	//Call LFSR to generate random countdown number
	LFSR rand1(Clk_1K, state, countdown);
	
	//From that random number, determine the random LED that we need to turn off
	always @ (countdown)
	begin
	
		case(countdown[8:5])
			0: shifted = 0;
			1: shifted = 1;
			2: shifted = 2;
			3: shifted = 3;
			4: shifted = 4;
			5: shifted = 5;
			6: shifted = 6;
			7: shifted = 7;
		endcase
		
		//shifted = 0;
	end
	
	//When in state two, countdown and set the endCD pin
	Count_down cdow1(Clk_1K, countdown, state, endCD);
	
	//When in state three continually increment current score
	Count_up   cup1(Clk_1K, state, BCDCurrentScore);
	
	
	
	/****  SCORE DISPLAY  ****/
		
	//Using SW[9], distinguish between the highscore and the current score
	always @ (SW[9])
	begin
		if(SW[9])
		begin
			Display = BCDHighScore;
		end
		
		else
		begin
			Display = BCDCurrentScore;
		end
	end
	
	//Generate the GOBUFFS HEXes
	GOBUFFS  GB(Clk_1K, GBH0, GBH1, GBH2, GBH3, GBH4, GBH5);
	
	//Both GOBUFFS
	//Pass the DisplayScore into the appropriate Hex displays
	Seven_Seg SS0(DISPLAY[ 3: 0],1,state,HEX0);
	Seven_Seg SS1(DISPLAY[ 7: 4],1,state,HEX1);
	Seven_Seg SS2(DISPLAY[11: 8],1,state,HEX2);
	Seven_Seg SS3(DISPLAY[15:12],0,state,HEX3);
	Seven_Seg SS4(DISPLAY[19:16],1,state,HEX4);
	
	//Show State on last seven seg for debug purposes
	Seven_Seg SS5(state,1,1,HEX5);
	
	
	
	
	
	
	/****  State Machine  ****/
	always @ (*)
	begin
		//Reset Button
		if (!KEY[1])
		begin
			state = 1;
			LEDR = 0;
		end
	
		//Sko Buffs State
		else if(state == 0)
		begin
			BCDHighScore = 99999;
			state = 1;
		end
		
		//LSFR (Default) State
		else if(state == 1)
		begin
			LEDR = 0;
			//transition when button is pressed
			if(!KEY[0])
			begin
				deltaKEY = 1;
			end
			
			if(KEY[0] && deltaKEY)
			begin
				deltaKEY = 0;
				state   = 2;
			end
		end
		
		//Countdown State
		else if(state == 2)
		begin
			LEDR = 0;
			if(endCD && !(SW & 1 << shifted))
			begin
				state = 3;
			end
		end
		
		//Countup state
		else if(state == 3)
		begin			
			// theoretical alternarte method
			// (seems like the version she would prefer but whatever)
			//LEDR = 0;
			
			//LEDR[shifted] = 1;
			LEDR = 1  << shifted;

			if(SW & 1 << shifted)
			begin 
				//return to base
				state = 1;
				
				if(BCDHighScore > BCDCurrentScore)
				begin
					BCDHighScore = BCDCurrentScore;
					if(BCDHighScore == 0)
						BCDHighScore = 99999;
				end
			end
			
		end
	end
endmodule 