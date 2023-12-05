////////////////////////////////////////////////////////////////////////////////////////
// Authors: Michal Rajzer(mr2207), Ben Green(bg651)
// Date: 27/11/2023
// Module name: ProgramCounter
// Description: ProgramCounter testbench file, used to test the microprocessor's PC
////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module ProgramCounterTestBench();

	// These are the signals that connect to the program counter
	logic 				Clock = '0;
	logic 				Reset;
	logic signed [15:0] LoadValue;
	logic               LoadEnable;
	logic signed [8:0]  Offset;
	logic 			    OffsetEnable;
	logic signed [15:0] CounterValue;

	// this is another method to create an instantiation of the program counter

	ProgramCounter uut (
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
		
	always  #10  Clock++; // clock speed is 50MHz, as 2 increments/cycle needed as clock pulses on posedge, so 20e-9 second period, which is 50MHz

	initial
	begin
		// default incrementing test, should produce value of 9
		// -------------------------------------------
		Reset = 0;
		OffsetEnable = 0;
		LoadEnable = 0;
		LoadValue = 0;
		##20; 
		$display("CounterValue = %d, should be 5", CounterValue);
		// -------------------------------------------

		// load value test, should produce a value of 1111000011110000
		// -------------------------------------------
		LoadValue = 15'b1111000011110000;
		LoadEnable = 1;
		##2; 
		$display("CounterValue = %d, should be 1111000011110000", CounterValue);
		// -------------------------------------------

		// -------------------------------------------
		LoadEnable = 0;
		##2;
		// -------------------------------------------

		// reset test, should produce value of 0
		// -------------------------------------------
		Reset = 1;
		##2;
		$display("CounterValue = %d, should be 0", CounterValue);
		// -------------------------------------------

		// -------------------------------------------
		Reset = 0;
		##2;
		// -------------------------------------------

		// offset test, should produce value of 000111000
		// -------------------------------------------
		OffsetEnable = 1;
		Offset = 8'b000110111;
		##2;
		$display("CounterValue = %d, should be b000111000", CounterValue) ;
		// -------------------------------------------

		$stop
	end
endmodule
	
