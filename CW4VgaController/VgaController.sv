// VGA controller
// Coursework activity 4
// November 2022

module VgaController
(
	input	logic	Clock,
	input	logic	Reset,
	output	logic	blank_n,
	output	logic	sync_n,
	output	logic	hSync_n,
	output	logic 	vSync_n,
	output	logic	[10:0] nextX,
	output	logic	[ 9:0] nextY
);

	// use this signal as counter for the horizontal axis 
	logic [10:0] hCount;

	// use this signal as counter for the vertical axis
	logic [ 9:0] vCount;
	
	
	// add here your code for the VGA controller
	always_ff @(posedge Clock, posedge Reset)
	begin
		// Reset
		if (Reset) begin
				hCount <= '0;
				vCount <= '0;
		
		// Check if vCount,hCount have reached the end, if not increment
		end else if(hCount >= 1039) begin
			// If reached the end of the line: Set to 0
			hCount <= '0;		
			// Check vCount
			if(vCount>=665) begin 
				vCount <= '0;
			end else begin
				vCount <= vCount + 1; // Increment vCount
			end			
		end else begin
			hCount <= hCount + 1; // Increment hCount
		end
	end
	
	always_comb
	begin
		//nextxy
		if (hCount < 800)
			nextX <= hCount;
		else
			nextX <= '0;
		
		if (vCount < 600)
			nextY <= vCount;
		else
			nextY <= '0;
			
		//blank_n
		if ((hCount >= 800) && (vCount >= 600))
			blank_n = '0;
		else
			blank_n = '1;
	
		// sync pulse
		//Horizontal
		if((hCount >= 856) && (hCount < 976))
			hSync_n <= '0;
		else
			hSync_n <= '1;
			
		//Vertical
		if((vCount >= 637) && (vCount < 643))
			vSync_n <= '0;
		else
			vSync_n <= '1;
			
		//sync_n
		if(((hCount >= 856) && (hCount < 976))||((vCount >= 637) && (vCount < 643)))
			sync_n = '0;
		else
			sync_n = '1;
	end
	
		
	
	
endmodule
