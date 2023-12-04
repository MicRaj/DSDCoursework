// ArithmeticLogicUnit
// This is a basic implementation of the essential operations needed
// in the ALU. Adding futher instructions to this file will increase 
// your marks.

// Load information about the instruction set. 
import InstructionSetPkg::*;

// Define the connections into and out of the ALU.
module ArithmeticLogicUnit
(
	// The Operation variable is an example of an enumerated type and
	// is defined in InstructionSetPkg.
	input eOperation Operation,
	
	// The InFlags and OutFlags variables are examples of structures
	// which have been defined in InstructionSetPkg. They group together
	// all the single bit flags described by the Instruction set.
	input  sFlags    InFlags,
	output sFlags    OutFlags,
	
	// All the input and output busses have widths determined by the 
	// parameters defined in InstructionSetPkg.
	input  signed [ImmediateWidth-1:0] InImm,
	
	// InSrc and InDest are the values in the source and destination
	// registers at the start of the instruction.
	input  signed [DataWidth-1:0] InSrc,
	input  signed [DataWidth-1:0]	InDest,
	
	// OutDest is the result of the ALU operation that is written 
	// into the destination register at the end of the operation.
	output logic signed [DataWidth-1:0] OutDest
);

	// This block allows each OpCode to be defined. Any opcode not
	// defined outputs a zero. The names of the operation are defined 
	// in the InstructionSetPkg. 
	always_comb
	begin
	
		// By default the flags are unchanged. Individual operations
		// can override this to change any relevant flags.
		OutFlags  = InFlags;
		
		// The basic implementation of the ALU only has the NAND and
		// ROL operations as examples of how to set ALU outputs 
		// based on the operation and the register / flag inputs.
		case(Operation)		
		
			ROL:     {OutFlags.Carry,OutDest} = {InSrc,InFlags.Carry};	
			
			NAND:    OutDest = ~(InSrc & InDest);

			LIL:	 OutDest = $signed(InImm);

			LIU:
				begin
					if (InImm[ImmediateWidth - 1] ==  1)
						OutDest = {InImm[ImmediateWidth - 2:0], InDest[ImmediateHighStart - 1:0]};
					else if  (InImm[ImmediateWidth - 1] ==  0)	
						OutDest = $signed({InImm[ImmediateWidth - 2:0], InDest[ImmediateMidStart - 1:0]});
					else
						OutDest = InDest;	
				end


			// ***** ONLY CHANGES BELOW THIS LINE ARE ASSESSED *****
			// Put your instruction implementations here.
			
			MOVE: OutDest = InSrc; // Copies the content of register Src to register Dest.
			
			NOR: OutDest = ~(InSrc || InDest); // Outputs NOR of values in InSrc and InDest registers
			
			ROR: {OutDest,OutFlags.Carry} = {InFlags.Carry,InSrc}; // Right bit Shift
			
			ADC: // Sum of Src, Dest and carry flag. Flags are set according to the result.
				begin
					OutDest = InSrc + InDest + OutFlags.Carry;
					// Carry
					if(InSrc+InDest+OutFlags.Carry >= 2**DataWidth)
						OutFlags.Carry = 1;
					else
						OutFlags.Carry = 0;
					// Zero Flag
					if(OutDest == 0) 
						OutFlags.Zero = 1;
					else
						OutFlags.Zero = 0;
					// Negative Flag
					if(OutDest[DataWidth-1]== 1) begin
						OutFlags.Negative = 1;
					end else begin
						OutFlags.Negative = 0;
					end
					// Overflow

					if((~(InSrc[DataWidth-1]) && ~(InDest[DataWidth-1]) && OutDest[DataWidth-1]) || 
					(InSrc[DataWidth-1] && InDest[DataWidth-1] && ~(OutDest[DataWidth-1])))
						OutFlags.Overflow = 1;
					else begin
						OutFlags.Overflow = 0;
					end
					// Parity
					OutFlags.Parity = ~(^(OutDest));					
				end
				
			SUB: // Subtraction. Flags are set according to the result.
				begin
					OutDest = InDest - (InSrc + OutFlags.Carry);		
					// Carry
					OutFlags.Carry = (InDest<(InSrc + OutFlags.Carry));
					// Zero Flag
					if(OutDest == 0) 
						OutFlags.Zero = 1;
					else
						OutFlags.Zero = 0;
					// Negative Flag
					if(OutDest[DataWidth-1]== 1)
						OutFlags.Negative = 1;
					else
						OutFlags.Negative = 0;
					// Overflow
					if(((InSrc[DataWidth-1]) && ~(InDest[DataWidth-1]) && OutDest[DataWidth-1]) || 
					(~(InSrc[DataWidth-1]) && InDest[DataWidth-1] && ~(OutDest[DataWidth-1])))
						OutFlags.Overflow = 1;
					else begin
						OutFlags.Overflow = 0;
					end
					// Parity
					OutFlags.Parity = ~(^(OutDest));		
				end
				
			DIV: // Result of integer signed division
				begin
					OutDest = InDest/InSrc;
					// Zero Flag
					if(OutDest == 0) 
						OutFlags.Zero = 1;
					else
						OutFlags.Zero = 0;
					// Negative Flag
					if(OutDest[DataWidth-1]== 1)
						OutFlags.Negative = 1;
					else begin
						OutFlags.Negative = 0;
					end
					// Parity
					OutFlags.Parity = ~(^(OutDest));		
				end
				
			MOD: // Remainder of integer signed division
				begin
					OutDest = InDest%InSrc;
					// Zero Flag
					if(OutDest == 0) 
						OutFlags.Zero = 1;
					else
						OutFlags.Zero = 0;
					// Negative Flag
					if(OutDest[DataWidth-1]== 1)
						OutFlags.Negative = 1;
					else begin
						OutFlags.Negative = 0;
					end
					// Parity
					OutFlags.Parity = ~(^(OutDest));	
				end
			
			MUL: // Lower half of integer signed multiplication
				begin
					logic signed [31:0] multResult; // Variable to hold 32bit multiplication output
					multResult = InDest * InSrc;
					OutDest = multResult[DataWidth-1:0]; // Lower 16 Bits			
					// Zero Flag
						if(OutDest == 0) 
							OutFlags.Zero = 1;
						else
							OutFlags.Zero = 0;
					// Negative Flag
					if(OutDest[DataWidth-1]== 1)
						OutFlags.Negative = 1;
					else begin
						OutFlags.Negative = 0;
					end
					// Parity
					OutFlags.Parity = ~(^(OutDest));	
				end
			MUH: // High half of integer signed multiplication
				begin
					logic signed [31:0] multResult;
					multResult = InDest * InSrc;
					OutDest = multResult[2*DataWidth-1:DataWidth]; // Upper 16 Bits		
					// Zero Flag
						if(OutDest == 0) 
							OutFlags.Zero = 1;
						else
							OutFlags.Zero = 0;
					// Negative Flag
					if(OutDest[DataWidth-1]== 1)
						OutFlags.Negative = 1;
					else begin
						OutFlags.Negative = 0;
					end
					// Parity
					OutFlags.Parity = ~(^(OutDest));	
				end				
//			// ***** ONLY CHANGES ABOVE THIS LINE ARE ASSESSED	*****		
//			
			default:	OutDest = '0;
			
		endcase;
	end

endmodule
