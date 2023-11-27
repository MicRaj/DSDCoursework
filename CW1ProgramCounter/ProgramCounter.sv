////////////////////////////////////////////////////////////////////////////////////////
// Authors: Michal Rajzer, Ben Green
// Date: 27/11/2023
// Module name: ProgramCounter
// Description: Design of a Program Counter (PC) that will be part of a microprocessor
////////////////////////////////////////////////////////////////////////////////////////
module ProgramCounter
//Define IO
(
logic input Clock,
logic input Reset,
logic signed input [15:0] LoadValue,//signed
logic input LoadEnable,
logic signed input [8:0] Offset, //signed
logic input OffsetEnable,
logic signed output [15:0] CounterValue //signed
);

always_ff @(posedge Clock, posedge Reset)
begin
		if (Reset)
			CounterValue <= ’0;
		else if(LoadEnable)
			CounterValue <= LoadValue
		else if(OffsetEnable)
			CounterValue <= CounterValue

end

endmodule