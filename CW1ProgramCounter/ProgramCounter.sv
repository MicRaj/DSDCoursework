////////////////////////////////////////////////////////////////////////////////////////
// Authors: Michal Rajzer, Ben Green
// Date: 27/11/2023
// Module name: ProgramCounter
// Description: Design of a Program Counter (PC) that will be part of a microprocessor
////////////////////////////////////////////////////////////////////////////////////////
module ProgramCounter
//Define IO
(
input logic Clock,
input logic Reset,
input logic signed [15:0] LoadValue,//signed
input logic LoadEnable,
input logic signed [8:0] Offset, //signed
input logic OffsetEnable,
output logic signed [15:0] CounterValue //signed
);

always_ff @(posedge Clock, posedge Reset)
begin
		if (Reset)
			CounterValue <= '0;
		else if(LoadEnable)
			CounterValue <= LoadValue;
		else if(OffsetEnable)
			CounterValue <= CounterValue + Offset;
		else
			CounterValue <= CounterValue + 1;
		
end

endmodule