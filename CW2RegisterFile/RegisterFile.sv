////////////////////////////////////////////////////////////////////////////////////////
// Authors: Michal Rajzer(mr2207), Ben Green(bg651)
// Date: 14/12/2023
// Module name: RegisterFile
// Description: Design of a Register File (RF) to be used in a microprocessor
////////////////////////////////////////////////////////////////////////////////////////
module RegisterFile
//Define IO
(
input logic Clock,
input logic [5:0] AddressA,
output logic [15:0] ReadDataA = 0,
input logic [15:0] WriteData,
input logic WriteEnable,
input logic [5:0] AddressB,
output logic [15:0] ReadDataB = 0
);
//Register Array, 64 Registers that are 16 bits wide
logic [15:0] Registers [64]= '{default: '0};


always_ff @(posedge Clock)
begin
	if(WriteEnable)
		Registers[AddressA] <= WriteData;// Write Data on clock cycle if WriteEnable Pin High
end

always_comb
begin
	ReadDataA <= Registers[AddressA]; //Read Data Asynchronously
	ReadDataB <= Registers[AddressB]; 
end

endmodule