// ProgramCounterTestBench
//
//
// This module implements a testbench for 
// the Program Counter to be created in the
// Digital Systems Design tutorial.
// 
// You need to add the code to test the
// functionality of your PC
//

module ProgramCounterTestBench();

	// These are the signals that connect to 
	// the program counter
	logic              	Clock = '0;
	logic              	Reset;
	logic signed       [15:0]	LoadValue;
	logic				LoadEnable;
	logic signed  [8:0]	Offset;
	logic 					OffsetEnable;
	logic signed  [15:0]	CounterValue;

	// this is another method to create an instantiation
	// of the program counter
	ProgramCounter uut
	(
		.Clock,
		.Reset,
		.LoadValue,
		.LoadEnable,
		.Offset,
		.OffsetEnable,
		.CounterValue
	);
	

	default clocking @(posedge Clock);
	endclocking
		
	always  #10  Clock++;

	initial
	begin
	Reset = 0;
	OffseEnable = 0;
	LoadEnable = 0;
	
	// add your code here to test the functionality
	// of your program counter


	
	end
endmodule
	
