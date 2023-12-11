`timescale 1ns / 1ps

import InstructionSetPkg::*;

// This module implements a set of tests that 
// partially verify the ALU operation.
module AluTb();

	eOperation Operation;
	
	sFlags    InFlags;
	sFlags    OutFlags;
	
	logic signed [ImmediateWidth-1:0] InImm = '0;
	
	logic	signed [DataWidth-1:0] InSrc  = '0;
	logic signed [DataWidth-1:0] InDest = '0;
	
	logic signed [DataWidth-1:0] OutDest;

	ArithmeticLogicUnit uut (.*);

	initial
	begin
		InFlags = sFlags'(0);
		
		
		$display("Start of NAND tests");
		Operation = NAND;
		
		InDest = 16'h0000;
		InSrc  = 16'ha5a5;      
	   #1 if (OutDest != 16'hFFFF) $display("Error in NAND operation at time %t",$time);
		
		#10 InDest = 16'h9999; 
	   #1 if (OutDest != 16'h7E7E) $display("Error in NAND operation at time %t",$time);
		
		#10 InDest = 16'hFFFF; 
	   #1 if (OutDest != 16'h5a5a) $display("Error in NAND operation at time %t",$time);
		
		#10 InDest = 16'h1234; 
	   #1 if (OutDest != 16'hFFDB) $display("Error in NAND operation at time %t",$time);
		
		#10 InSrc = 16'h0000;   
		InDest = 16'ha5a5;     
	   #1 if (OutDest != 16'hFFFF) $display("Error in NAND operation at time %t",$time);
		
		#10 InSrc = 16'h9999;  
	   #1 if (OutDest != 16'h7E7E) $display("Error in NAND operation at time %t",$time);
		
		#10 InSrc = 16'hFFFF; 
	   #1 if (OutDest != 16'h5a5a) $display("Error in NAND operation at time %t",$time);
		
		#10 InSrc = 16'h1234;  
	   #1 if (OutDest != 16'hFFDB) $display("Error in NAND operation at time %t",$time);
		#50;

				
		
		$display("Start of ADC tests");
		Operation = ADC;
		
		InDest = 16'h0000;
		InSrc = 16'ha5a5;   
	   #1 
		if (OutDest != 16'ha5a5) $display("Error in ADC operation at time %t",$time);
	   if (OutFlags != sFlags'(12)) $display("Error (flags) in ADC operation at time %t",$time);
		
		#10 InFlags.Carry = '1;
	   #1 
		if (OutDest != 16'ha5a6) $display("Error in ADC operation at time %t",$time);
	   if (OutFlags != sFlags'(12)) $display("Error (flags) in ADC operation at time %t",$time);

		#10 InDest = 16'h5a5a; 
	   #1 
		if (OutDest != 16'h0000) $display("Error in ADC operation at time %t",$time);
	   if (OutFlags != sFlags'(11)) $display("Error (flags) in ADC operation at time %t",$time);
		
		#10 InDest = 16'h8000;
		InFlags.Carry = '0;
		InSrc = 16'hffff;      
	   #1 
		if (OutDest != 16'h7fff) $display("Error in ADC operation at time %t",$time);
	   if (OutFlags != sFlags'(17)) $display("Error (flags) in ADC operation at time %t",$time);
		
		#10 InDest = 16'h7fff;
		InSrc = 16'h0001;     
	   #1 
		if (OutDest != 16'h8000) $display("Error in ADC operation at time %t",$time);
	   if (OutFlags != sFlags'(20)) $display("Error (flags) in ADC operation at time %t",$time);
		#50;

		
		$display("Start of LIU tests");
		Operation = LIU;
		
		InDest = 16'h0000;
		InImm = 6'h3F;          
	   #1 if (OutDest != 16'hF800) $display("Error in LIU operation at time %t",$time);
		
		#10 InImm = 6'h0F;      
	   #1 if (OutDest != 16'h03C0) $display("Error in LIU operation at time %t",$time);
		
		#10 InDest = 16'hAAAA;  		
	   #1 if (OutDest != 16'h03EA) $display("Error in LIU operation at time %t",$time);
		
		#10 InImm = 6'h3F;      
	   #1 if (OutDest != 16'hFAAA) $display("Error in LIU operation at time %t",$time);

	

		// Put your code here to verify the instructions.
		
		// already implemented so should work
		// -------------------------------------------
		ROL 
		NAND
		LIL
		LIU
		// -------------------------------------------

		// MOVE - Copies the content of register Src to register Dest.
		// -------------------------------------------
		Operation = MOVE;
		InSrc = 16'hF0F0
		if (OutDest != 16'hF0F0) $display("Error in MOVE operation at time %t",$time);
		// -------------------------------------------

		// NOR - Outputs NOR of values in InSrc and InDest registers
		// -------------------------------------------
		Operation = NOR;		
		InDest = 16'h0000;
		InSrc  = 16'ha5a5;  
 
	   #1 if (OutDest != 16'h5a5a) $display("Error in NOR operation at time %t",$time);
		
		#10 InDest = 16'h9999; 
	   #1 if (OutDest != 16'h6666) $display("Error in NAND operation at time %t",$time);
		
		#10 InDest = 16'hFFFF; 
	   #1 if (OutDest != 16'h0000) $display("Error in NOR operation at time %t",$time);
		
		#10 InDest = 16'h1234; 
	   #1 if (OutDest != 16'hedcb) $display("Error in NOR operation at time %t",$time);
		
		#10 InSrc = 16'h0000;   
		InDest = 16'ha5a5;     
	   #1 if (OutDest != 16'5a5a) $display("Error in NOR operation at time %t",$time);
		
		#10 InSrc = 16'h9999;  
	   #1 if (OutDest != 16'h2424) $display("Error in NOR operation at time %t",$time);
		
		#10 InSrc = 16'hFFFF; 
	   #1 if (OutDest != 16'h0000) $display("Error in NOR operation at time %t",$time);
		
		#10 InSrc = 16'h1234;  
	   #1 if (OutDest != 16'h484A) $display("Error in NOR operation at time %t",$time);
		#50;

		// -------------------------------------------

		// ROR - Right bit Shift
		// -------------------------------------------
		Operation = ROR;

		InSrc  = 16'h0FF0;
		InFlags = sFlags'(1);

		#1 
		if (OutDest != 16'h87f8) $display("Error in ROR operation at time %t",$time);
		if (OutFlags != sFlags'(0)) $display("Error (flags) in ROR operation at time %t",$time);

		#10 InSrc  = 16'000F;
		if (OutDest != 16'h8007) $display("Error in ROR operation at time %t",$time);
		if (OutFlags != sFlags'(1)) $display("Error (flags) in ROR operation at time %t",$time);

		#10 InFlags = sFlags'(0);
		if (OutDest != 16'h0007) $display("Error in ROR operation at time %t",$time);
		if (OutFlags != sFlags'(1)) $display("Error (flags) in ROR operation at time %t",$time);
		#50;
		// -------------------------------------------

		// SUB - Subtraction. Flags are set according to the result.
		// -------------------------------------------
		Operation = SUB;
		InFlags = sFlags'(0);
		InDest = 16'd1024;
		InSrc = 16'd16;
		#1
		if (OutDest != 16'd1008) $display("Error in SUB operation at time %t",$time);
		if (OutFlags != sFlags'(8)) $display("Error (flags) in SUB operation at time %t",$time);
		// tests generic subtraction

		InFlags = sFlags'(0);
		InDest = 16'd16;
		InSrc = 16'd1024;
		#1
		if (OutDest != -16'd1008) $display("Error in SUB operation at time %t",$time);
		if (OutFlags != sFlags'(4)) $display("Error (flags) in SUB operation at time %t",$time);
		// tests subtraction that results in negative

		InFlags = sFlags'(0);
		InDest = 16'd0;
		InSrc = 16'd0;
		#1
		if (OutDest != 16'd0) $display("Error in SUB operation at time %t",$time);
		if (OutFlags != sFlags'(10)) $display("Error (flags) in SUB operation at time %t",$time);
		// tests subtraction that ends in 0

		InFlags = sFlags'(0);
		InDest = -16'd32768;
		InSrc = 16'd2;
		#1
		//if (OutDest != -16'd1008) $display("Error in SUB operation at time %t",$time);
		if (OutFlags != sFlags'(28)) $display("Error (flags) in SUB operation at time %t",$time);
		// tests overflow flag

		/*
		InFlags = sFlags'(0);
		InDest = 16'd0;
		InSrc = 16'd0;
		#1
		if (OutDest != 16'd0) $display("Error in SUB operation at time %t",$time);
		if (OutFlags != sFlags'(10)) $display("Error (flags) in SUB operation at time %t",$time);
		// tests subtraction that involving carry flag
		*/ 
		// not implemented
		// -------------------------------------------

		// DIV - Result of integer signed division
		// -------------------------------------------
		Operation = DIV;
		InSrc = 16'h000A;
		InDest = 16'h0000;
		InFlags = sFlags'(0);

		#1 
		if (OutDest != 16'h0000) $display("Error in DIV operation at time %t",$time);
		if (OutFlags != sFlags'(10)) $display("Error (flags) in DIV operation at time %t",$time); // Zero, Parity Flag Check

		#10 InDest = 16'hFFCE;
		if (OutDest != 16'hFFFB) $display("Error in DIV operation at time %t",$time);
		if (OutFlags != sFlags'(4)) $display("Error (flags) in DIV operation at time %t",$time); // Negative

		#10 InDest = 16'h0032;
		if (OutDest != 16'h0005) $display("Error in DIV operation at time %t",$time);
		if (OutFlags != sFlags'(8)) $display("Error (flags) in DIV operation at time %t",$time); // Parity Check
		#50;
		// -------------------------------------------

		// MOD - Remainder of integer signed division
		// -------------------------------------------
		Operation = MOD;
		InSrc = 16'h000A;
		InDest = 16'h000A;
		InFlags = sFlags'(0);

		#1 
		if (OutDest != 16'h0000) $display("Error in DIV operation at time %t",$time);
		if (OutFlags != sFlags'(10)) $display("Error (flags) in DIV operation at time %t",$time); // Zero, Parity Flag Check

		#10 InDest = 16'hFAAD;
		if (OutDest != 16'h0003) $display("Error in DIV operation at time %t",$time);
		if (OutFlags != sFlags'(0)) $display("Error (flags) in DIV operation at time %t",$time);

		#10 InDest = 16'h0AAC;
		if (OutDest != 16'h0002) $display("Error in DIV operation at time %t",$time);
		if (OutFlags != sFlags'(8)) $display("Error (flags) in DIV operation at time %t",$time);
		#50;
		// -------------------------------------------

		// MUL - Lower half of integer signed multiplication
		// -------------------------------------------
		Operation = MUL;
		InDest = 16'd16;
		InSrc = 16'd16;
		#1
		if (OutDest != 16'h0010) $display("Error in MUL operation at time %t",$time);
		if (OutFlags != sFlags'(0)) $display("Error (flags) in MUL operation at time %t",$time);

		#1
		InDest = 16'd0;
		InSrc = 16'd0;
		if (OutDest != 16'h0000) $display("Error in MUL operation at time %t",$time);
		if (OutFlags != sFlags'(10)) $display("Error (flags) in MUL operation at time %t",$time);

		#1
		InDest = -16'd16;
		InSrc = 16'd16;
		if (OutDest != 16'hFF00) $display("Error in MUL operation at time %t",$time);
		if (OutFlags != sFlags'(12)) $display("Error (flags) in MUL operation at time %t",$time);
		// -------------------------------------------

		// MUH - High half of integer signed multiplication
		// -------------------------------------------
		Operation = MUH;
		InDest = 16'd1024;
		InSrc = 16'd64;
		#1
		if (OutDest != 16'h0001) $display("Error in MUH operation at time %t",$time);
		if (OutFlags != sFlags'(0)) $display("Error (flags) in MUH operation at time %t",$time);

		#1
		InDest = 16'd2;
		InSrc = 16'd1;
		if (OutDest != 16'h0000) $display("Error in MUH operation at time %t",$time);
		if (OutFlags != sFlags'(10)) $display("Error (flags) in MUH operation at time %t",$time);

		#1
		InDest = -16'd2048;
		InSrc = 16'd128;
		if (OutDest != 16'hFFFC) $display("Error in MUH operation at time %t",$time);
		if (OutFlags != sFlags'(12)) $display("Error (flags) in MUH operation at time %t",$time);

		#1
		InDest = 16'd0;
		InSrc = 16'd0;
		if (OutDest != 16'h0000) $display("Error in MUH operation at time %t",$time);
		if (OutFlags != sFlags'(10)) $display("Error (flags) in MUH operation at time %t",$time);

		#1
		InDest = 16'd4095;
		InSrc = 14095;
		if (OutDest != 16'h00FF) $display("Error in MUH operation at time %t",$time);
		if (OutFlags != sFlags'(8)) $display("Error (flags) in MUH operation at time %t",$time);
		// -------------------------------------------

		// End of instruction simulation


		$display("End of tests");
	end
endmodule