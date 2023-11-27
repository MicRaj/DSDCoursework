////////////////////////////////////////////////////////////////////////////////////////
// Authors: Michal Rajzer(mr2207), Ben Green(bg651)
// Date: 27/11/2023
// Module name: Register
// Description: Design of a Program Counter (PC) that will be part of a microprocessor
////////////////////////////////////////////////////////////////////////////////////////
module RegisterFile
//Define IO
(
input logic Clock,
input logic [5:0] AddressA,
output logic [15:0] ReadDataA,
input logic [15:0] WriteData,
input logic WriteEnable,
input logic [5:0] AddressB,
output logic [15:0] ReadDataB
);
//Register Array, 64 Registers that are 16 bits wide Registers[12][5:2] 13th register bit 5-2
logic [15:0] Registers [64];


always_ff @(posedge Clock)
begin
	if(writeEnable)
		Registers[AddressA] <= WriteData;//Write Data on clock cycle if WriteEnable Pin High
end

always_comb
begin
	ReadDataB <= Registers[AddressA]; //Read Data Asynchronously
	ReadDataB <= Registers[AddressB]; 
end

endmodule