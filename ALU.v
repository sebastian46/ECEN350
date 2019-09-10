`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    parameter n = 64;

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    reg     [n-1:0] BusW;
    reg Zero;
    
  	// checks what control was given as input and performs operation
    always @(ALUCtrl or BusA or BusB) begin
        Zero = 0; // reset to zero at the start
        case(ALUCtrl)
            `AND: begin
              	BusW[63:0] <= #20 BusA[63:0] & BusB[63:0];
              	if(BusW[63:0] == 64'b0)
                    Zero = 1; // if BusW = 0, then Zero is true
            end
            `OR: begin
                BusW[63:0] <= #20 BusA[63:0] | BusB[63:0];
              	if(BusW[63:0] == 64'b0)
                    Zero = 1; // if BusW = 0, then Zero is true
            end
            `ADD: begin
                BusW[63:0] <= #20 BusA[63:0] + BusB[63:0];
              	if(BusW[63:0] == 64'b0)
                    Zero = 1; // if BusW = 0, then Zero is true
            end
            `SUB: begin
                BusW[63:0] <= #20 BusA[63:0] - BusB[63:0];
              	if(BusW[63:0] == 64'b0)
                    Zero = 1; // if BusW = 0, then Zero is true
            end
            `PassB: begin
                BusW[63:0] <= #20 BusB[63:0];
              	if(BusW[63:0] == 64'b0)
                    Zero = 1; // if BusW = 0, then Zero is true
            end
        endcase
    end
                    
endmodule
