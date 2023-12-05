////////////////////////////////////////////////////////////////////////////////////////
// Authors: Michal Rajzer(mr2207), Ben Green(bg651)
// Date: 27/11/2023
// Module name: Register
// Description: Register testbench file, used to test the microprocessor's registers
////////////////////////////////////////////////////////////////////////////////////////

module RegisterFileTb();

	// signals that connect to register
	logic        Clock = 0;
	logic [5:0]  AddressA;
	logic [15:0] ReadDataA;
	logic [15:0] WriteData;
	logic        WriteEnable;
	logic [5:0]  AddressB;
	logic [15:0] ReadDataB;

	// module instantiation
	RegisterFile uut (
		.Clock,
		.AddressA,
		.ReadDataA,
		.WriteData,
		.WriteEnable,
		.AddressB,
		.ReadDataB
	);
	
	default clocking @(posedge Clock);
	endclocking
		
	always  #10  Clock++; // clock speed is 50MHz, as 2 increments/cycle needed as clock pulses on posedge

	initial
	begin
		// read/write test for A and B
		// -------------------------------------------
		AddressA = 15;
		AddressB = 22;
		WriteEnable = 1;
		WriteData = 15'b1111000011110000;
		##2;
		$display("ReadDataA = %d, should be 1111000011110000", ReadDataA);
		$display("ReadDataB = %d, should be 0000000000000000", ReadDataB);
		// -------------------------------------------

		// overwrite data test
		// -------------------------------------------
		WriteData = 15'b0000000000000000;
		##2;
		$display("ReadDataA = %d, should be b0000000000000000", ReadDataA);
		// -------------------------------------------

		// write enable test
		// -------------------------------------------
		WriteEnable = 0;
		WriteData = 15'b1010101010101010;
		##2;
		$display("ReadDataA = %d, should be b0000000000000000", ReadDataA);
		// -------------------------------------------

		$stop
	end
endmodule
