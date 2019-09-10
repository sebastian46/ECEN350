`timescale 1ns / 1ps
/*
 * Module: InstructionMemory
 *
 * Implements read-only instruction memory
 * 
 */
module InstructionMemory(Data, Address);
   parameter T_rd = 20;
   parameter MemSize = 40;
   
   output [31:0] Data;
   input [63:0]  Address;
   reg [31:0] 	 Data;
   
   /*
    * ECEN 350 Processor Test Functions
    * Texas A&M University
    */
   
   always @ (Address) begin
      case(Address)

	/* Test Program 1:
	 * Program loads constants from the data memory. Uses these constants to test
	 * the following instructions: LDUR, ORR, AND, CBZ, ADD, SUB, STUR and B.
	 * 
	 * Assembly code for test:
	 * 
	 * 0: LDUR X9, [XZR, 0x0]    //Load 1 into x9
	 * 4: LDUR X10, [XZR, 0x8]   //Load a into x10
	 * 8: LDUR X11, [XZR, 0x10]  //Load 5 into x11
	 * C: LDUR X12, [XZR, 0x18]  //Load big constant into x12
	 * 10: LDUR X13, [XZR, 0x20]  //load a 0 into X13
	 * 
	 * 14: ORR X10, X10, X11  //Create mask of 0xf
	 * 18: AND X12, X12, X10  //Mask off low order bits of big constant
	 * 
	 * loop:
	 * 1C: CBZ X12, end  //while X12 is not 0
	 * 20: ADD X13, X13, X9  //Increment counter in X13
	 * 24: SUB X12, X12, X9  //Decrement remainder of big constant in X12
	 * 28: B loop  //Repeat till X12 is 0
	 * 2C: STUR X13, [XZR, 0x20]  //store back the counter value into the memory location 0x20
	 */
	

	63'h000: Data = 32'hF84003E9;
	63'h004: Data = 32'hF84083EA;
	63'h008: Data = 32'hF84103EB;
	63'h00c: Data = 32'hF84183EC;
	63'h010: Data = 32'hF84203ED;
	63'h014: Data = 32'hAA0B014A;
	63'h018: Data = 32'h8A0A018C;
	63'h01c: Data = 32'hB400008C;
	63'h020: Data = 32'h8B0901AD;
	63'h024: Data = 32'hCB09018C;
	63'h028: Data = 32'h17FFFFFD;
	63'h02c: Data = 32'hF80203ED;
	63'h030: Data = 32'hF84203ED;  //One last load to place stored value on memdbus for test checking.

        /* 0: MOVZ X9, 64'h1234, LSL 48 // put the last 16 bits into x9
           4: MOVZ X10, 64'h5678, LSL 32 // put middle 16 bits into X10
           8: MOVZ X11, 64'h9abc, LSL 16 // put middle 16 bits into X11
           C: MOVZ X12, 64'hdef0 // put last 16 bits in X12
           
           10: ADD X13, X9, X10; // add upper 32 bits
           14: ADD X14, X11, X12; // add lower 32 bits
           18: ADD X9, X13, X14; // the full constant is now loaded in
           
           1C: STUR X9, [XZR, 0x28]; // store in 0x28 memory 
           20: LDUR X10, [XZR, 0x28]; // load in register x10
        */
     63'h050: Data = 32'hD2E24689;
     63'h054: Data = 32'hD2CACF0A;
     63'h058: Data = 32'hD2B3578B;
     63'h05c: Data = 32'hD29BDE0C;
     63'h060: Data = 32'h8B0A012D;
     63'h064: Data = 32'h8B0C016E;
     63'h068: Data = 32'h8B0E01A9;
     63'h06c: Data = 32'hF80283E9;
     63'h070: Data = 32'hF84283EA;

			
	default: Data = 32'hXXXXXXXX;
      endcase
   end
endmodule
