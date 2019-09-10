module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
	output [63:0] BusA;
	output [63:0] BusB;
	input [63:0] BusW;
	input [4:0] RA;
	input [4:0] RB;
	input [4:0] RW;
	input RegWr;
	input Clk;
  
    reg [63:0] register [31:0]; // register file 32x64
  
  	assign #2 BusA = register[RA]; // assign RA to BusA
	assign #2 BusB = register[RB]; // assign RB to BusB

	
  always@(posedge Clk)
    begin
      register[5'b11111] <= 0;
    end

	always@(negedge Clk) // only want change @ negedge clk
	begin
      register[5'b11111] <= 0;
		if(RegWr == 1) 
		begin
          if(RW != 5'b11111)
            register[RW] <= #3 BusW;
		end
	end
  
endmodule
