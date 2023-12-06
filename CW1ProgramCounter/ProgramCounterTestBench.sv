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
		if (CounterValue != 16'd9) $display("Error in default increment operation at time %t",$time);
		// -------------------------------------------

		// load value test, should produce a value of 1111000011110000
		// -------------------------------------------
		LoadValue = 15'hF0F0;
		LoadEnable = 1;
		##2; 
		if (CounterValue != 16'hF0F0) $display("Error in load operation at time %t",$time);
		// -------------------------------------------

		// -------------------------------------------
		LoadEnable = 0;
		##2;
		// -------------------------------------------

		// reset test, should produce value of 0
		// -------------------------------------------
		Reset = 1;
		##2;
		if (CounterValue != 16'd0) $display("Error in reset operation at time %t",$time);
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
		if (CounterValue != 16'b000111000) $display("Error in offset test operation at time %t",$time);
		// -------------------------------------------

		$stop
	end
endmodule
	
