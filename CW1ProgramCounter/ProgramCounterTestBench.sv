`timescale 1ns / 1ps

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
		
	always  #10  Clock++; // clock speed is 20ns, as 2 increments/cycle needed as clock pulses on posedge

	initial
	begin
	Reset = 0;
	OffsetEnable = 0;
	LoadEnable = 0;
	LoadValue = 0;
	##20; // default incrementing test - PC should increment to 9 if starting at 0

	$display("CounterValue = %d, should be 9", CounterValue);
	LoadValue = 15'b1111000011110000;
	LoadEnable = 1;
	##1; // load value test, should be at 1111000011110000

	LoadEnable = 0;
	$display("CounterValue = %d, should be 1111000011110000", CounterValue);
	##1 

	Reset = 1;
	##1 // reset test

	Reset = 0;
	$display("CounterValue = %d, should be 0", CounterValue);
	##1

	OffsetEnable = 1;
	Offset = 8'b000110111;
	##1 // offset test, should be at 000111000
	
	OffsetEnable = 0;
	$display("CounterValue = %d, should be b000111000", CounterValue) ;

	$stop
	end
endmodule
	
