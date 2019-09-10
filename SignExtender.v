// 26 to 64 bit instruction (does extend)
// copying narrow to wider, it is zero extended
module SignExtender(BusImm, inst, Ctrl);
	output [63:0] BusImm;
	input [31:0] inst; 
  input [2:0] Ctrl; // 4 possible inputs. I-type = 00. D-type = 01. B-Type = 10. CB Type = 11.

  	reg [25:0] tempreg = 26'b0; // temprorary register to store bits
	reg extBit = 0; // which value to sign extend by
  reg [63:0]BusImm;
	
	parameter I = 3'b000, // cases
	          D = 3'b001,
	          B = 3'b010,
	          CB = 3'b011,
  			  IM = 3'b100;
  
  // sign extend using 0 if last bit is 0.
  // sign extend using 1 if last bit is 1.
  // check what kind of input it is first
  // determine what bits to read
  
    
    //summary of this part of code
    // checks Ctrl (which says what type of instruction the input is)
    // goes to appropiate case
    // desides which value to extend by
    //      This is done by checking last bit of immediate 
  
  reg [8:0]temp_val;
	always@(*)
	begin
	   extBit = 0;
	   tempreg = 26'b0;
	   case(Ctrl)
	        I:  // I-Type
			begin
              tempreg[11:0] = inst[21:10];
			    if(tempreg[11] == 1)
			         begin
			             extBit = 1;
			             tempreg = {{14{extBit}}, tempreg[11:0]}; // fill in last 14bits with 1's
			         end
              BusImm = {{38{extBit}}, tempreg[25:0]};
			end
            D: // D-Type
			begin
                tempreg[8:0] = inst[20:12];
                if(tempreg[8] == 1)
                     begin
                         extBit = 1;
                         tempreg = {{17{extBit}}, tempreg[8:0]}; // fill in last 17 bits with 1's
                     end
              BusImm = {{38{extBit}}, tempreg[25:0]};
			end
            B: // B-Type
			begin
                tempreg[25:0] = inst[25:0];
                if(tempreg[25] == 1)
                    begin
                        extBit = 1;
                    end
              BusImm = {{38{extBit}}, tempreg[25:0]};
			end
            CB: //CB-Type
			begin
                tempreg[18:0] = inst[23:5];
             	if(tempreg[18] == 1)
                    begin
                        extBit = 1;
                        tempreg = {{7{extBit}}, tempreg[18:0]}; // fill in last 7 bits with 1's
                    end
              BusImm = {{38{extBit}}, tempreg[25:0]};
				end
         	IM: //MOVZ
            begin
              tempreg[15:0] = inst[20:5];
              BusImm = {{38{extBit}}, tempreg[25:0]};
              temp_val = inst[22:21] << 4;
              BusImm = BusImm << temp_val;
            end
        endcase
	end
	
endmodule