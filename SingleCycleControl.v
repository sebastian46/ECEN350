`define OPCODE_ANDREG 11'b10001010000
`define OPCODE_ORRREG 11'b10101010000
`define OPCODE_ADDREG 11'b10001011000
`define OPCODE_SUBREG 11'b11001011000

`define OPCODE_ADDIMM 11'b1001000100x
`define OPCODE_SUBIMM 11'b1101000100x

`define OPCODE_MOVZ   11'b110100101xx

`define OPCODE_B      11'b000101xxxxx
`define OPCODE_CBZ    11'b10110100xxx

`define OPCODE_LDUR   11'b11111000010 
`define OPCODE_STUR   11'b11111000000

module control(
    output reg reg2loc,
    output reg alusrc,
    output reg mem2reg,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg branch,
    output reg uncond_branch,
    output reg [3:0] aluop,
    output reg [2:0] signop, // had to add 1 bit to this for extra type of instruction
    input [10:0] opcode
);

always @(*)
begin
    casex(opcode)

        /* Add cases here for each instruction your processor supports */
        `OPCODE_ANDREG:
        begin
            reg2loc       <= 1'b0;
            alusrc        <= 1'b0;
            mem2reg       <= 1'b0;
            regwrite      <= 1'b1;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0000;
            signop        <= 3'bxxx;
        end

        `OPCODE_ORRREG:
        begin
            reg2loc       <= 1'b0;
            alusrc        <= 1'b0;
            mem2reg       <= 1'b0;
            regwrite      <= 1'b1;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0001;
            signop        <= 3'bxxx;
        end

        `OPCODE_ADDREG:
        begin
            reg2loc       <= 1'b0;
            alusrc        <= 1'b0;
            mem2reg       <= 1'b0;
            regwrite      <= 1'b1;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0010;
            signop        <= 3'bxxx;
        end

        `OPCODE_SUBREG: 
        begin
            reg2loc       <= 1'b0;
            alusrc        <= 1'b0;
            mem2reg       <= 1'b0;
            regwrite      <= 1'b1;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0110;
            signop        <= 3'bxxx;
        end

        `OPCODE_ADDIMM: 
        begin
            reg2loc       <= 1'bx;
            alusrc        <= 1'b1;
            mem2reg       <= 1'b0;
            regwrite      <= 1'b1;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0010;
            signop        <= 3'b000;
        end

        `OPCODE_SUBIMM: 
        begin
            reg2loc       <= 1'bx;
            alusrc        <= 1'b1;
            mem2reg       <= 1'b0;
            regwrite      <= 1'b1;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0110;
            signop        <= 3'b000;
        end

        `OPCODE_MOVZ:       
        begin           
            reg2loc       <= 1'bx;           // we dont use this
            alusrc        <= 1'b1;           // want to pass sign extended immediate
            mem2reg       <= 1'b0;           // we want the alu result 
            regwrite      <= 1'b1;           // want to write to memory
            memread       <= 1'b0;           // wont read memory
            memwrite      <= 1'b0;      // we wont write to memory     
            branch        <= 1'b0;           // not c-branch
            uncond_branch <= 1'b0;           // not ubranch
            aluop         <= 4'b0111;       // pass b     
            signop        <= 3'b100;       
        end


        `OPCODE_B:
        begin
            reg2loc       <= 1'bx;
            alusrc        <= 1'bx;
            mem2reg       <= 1'bx;
            regwrite      <= 1'b0;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'bx;
            uncond_branch <= 1'b1;
            aluop         <= 4'bxxxx;
            signop        <= 3'b010;
        end

        `OPCODE_CBZ:
        begin
            reg2loc       <= 1'b1;
            alusrc        <= 1'b0;
            mem2reg       <= 1'bx;
            regwrite      <= 1'b0;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b1;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0111; 
            signop        <= 3'b011;
        end

        `OPCODE_LDUR:
        begin
            reg2loc       <= 1'bx;
            alusrc        <= 1'b1;
            mem2reg       <= 1'b1;
            regwrite      <= 1'b1;
            memread       <= 1'b1;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0010;
            signop        <= 3'b001;
        end

        `OPCODE_STUR:
        begin
            reg2loc       <= 1'b1;
            alusrc        <= 1'b1;
            mem2reg       <= 1'bx;
            regwrite      <= 1'b0;
            memread       <= 1'b0;
            memwrite      <= 1'b1;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'b0010;
            signop        <= 3'b001;
        end

        default:
        begin
            reg2loc       <= 1'bx;
            alusrc        <= 1'bx;
            mem2reg       <= 1'bx;
            regwrite      <= 1'b0;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'bxxxx;
            signop        <= 3'bxxx;
        end
    endcase
end

endmodule

