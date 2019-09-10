module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       input [63:0] CurrentPC, SignExtImm64; 
       input Branch, ALUZero, Uncondbranch; 
       output [63:0] NextPC; 
              
       
       reg [63:0] NextPC;
     reg [63:0] tempVal;
       // establish cases
       // default (0) if b = 0 and ub = 0
       // b (1) if b = 1 and ub = 0
       // cb (2) if b = 0 and ub = 1
       // defaultv2 (3) if b = 1 and ub = 1
       reg [1:0] tempValTwo;
  always@(Branch or Uncondbranch)
       begin
            if(Branch == 1 && Uncondbranch == 0)
                tempValTwo = 2'b01; // conditional branch
         if(Uncondbranch == 1)
                tempValTwo = 2'b00; // unconditional branch
         if(Branch == 0 && Uncondbranch == 0)
                tempValTwo = 2'b10;
       end
  
  
       parameter a_branch = 2'b00,
                 b_cb = 2'b01,
                 c_default = 2'b10;
  
              
       always@(*)begin
            case(tempValTwo)
              
            a_branch: // B case
                begin
                  tempVal = SignExtImm64[63:0] << 2;
                  NextPC <= #3 CurrentPC + tempVal;
                end
              
            b_cb: // CB case
                begin
                  if(ALUZero == 1) // if B and Zero are true
                    begin
                      tempVal = SignExtImm64 << 2;
                      NextPC <= #3 CurrentPC + tempVal;
                    end
                  if(ALUZero == 0)
                      NextPC <= #3 CurrentPC +4;
                end
              
            c_default:
              begin // for default case
                  NextPC <= #3 CurrentPC +4;
              end
            endcase
       end   
endmodule
