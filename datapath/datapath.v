// Created by Kavan Heppenstall, 28/08/2024

`include "../components/adder/adder.v"
`include "../components/alu/alu.v"
`include "../components/adder/incrementer.v"
`include "../components/control/control.v"
`include "../components/control/instruction_decoder/idecoder.v"
`include "../components/demultiplexer/demux.v"
`include "../components/line_decoder/decoder.v"
`include "../components/multiplexer/multiplexer.v"
`include "../components/register/register.v"
`include "../components/register_file/regfile.v"
`include "../components/control/control.v"
`include "../components/shifter/shifter.v"
`include "../memory/memory.v"


module datapath(init);

input init;

wire [15:0] D_MEMORY, D_DATA, I_MEMORY, I_MEMORY_OUT, PC_OUT, PC_OUT_OUT, PC_INT, PC_IN, PC_IN_OUT, PC_PLUS1, ALU_OUT, WRITE_IN, WRITE_IN_OUT, I_IN,I_IN_OUT, OP0, OP1, DEST_OUT, IMMED_SXT, IMMED_B_SXT;

wire [10:0] IMMED_B;

wire [3:0] OP, IMMED, ALU_FUNC, FLAG_RESET, FLAG_IN, FLAG_OUT;

wire [2:0] DEST, SRC0, SRC1;

wire [1:0] IMMED_SEL;

wire CLK, FLAG_EN, WRITE_SEL, WRITE_EN, PC_SEL, READ_WRITE, D_EN, I_SEL, B_SEL, F_EN, FETCH, DECODE, EXECUTE, B_OUT;

reg [15:0] OP1_reg;

assign IMMED_SXT = { 12'b0, IMMED };
assign IMMED_B_SXT = { 5'b0, IMMED_B} ;


always @(*) begin
    if (I_MEMORY_OUT == 16'hFFFF) begin
        $display("Return register value: ");
        $display("Program terminated");
        $finish;
    end
end

// PIPE LINE BARRIERS

register16bit FETCH_BARRIER0(.D(I_IN), .clk(CLK), .en(FETCH), .reset(init), .Q(I_IN_OUT));

// CONTROL

controlunit CONTROL(.init(init), .OP(OP), .en(1'b1), .immed_in(I_SEL), .b_immed_in(B_SEL), .flag_in(F_EN), .b_in(B_OUT), .clk_out(CLK), .immed_sel(IMMED_SEL), .w_en(WRITE_EN), .alu_func(ALU_FUNC), .flag_en(FLAG_EN), .write_sel(WRITE_SEL), .mem_en(D_EN), .pc_sel_out(PC_SEL), .read_write(READ_WRITE), .fetch(FETCH), .decode(DECODE), .execute(EXECUTE));

// Multiplexer for reseting/initialising flag register
multiplexer4bit FLAG_MUX(.A(4'b0000), .B(FLAG_OUT), .sel(init), .Q(FLAG_RESET));

register4bit FLAGS(.D(FLAG_RESET), .clk(CLK), .en(1'b1), .Q(FLAG_IN), .reset(init));

register16bit IR(.D(I_MEMORY_OUT), .clk(CLK), .en(1'b1), .reset(init), .Q(I_IN));

register16bit PC(.D(PC_IN), .clk(CLK), .en(FETCH), .reset(init | B_OUT), .Q(PC_OUT));

pcincrementer INCREMENTER(.A(PC_OUT), .clk(EXECUTE), .Q(PC_PLUS1));

multiplexer16bit PC_MUX(.A(ALU_OUT), .B(PC_PLUS1), .sel(PC_SEL), .Q(PC_IN));

instructiondecoder DECODER(.A(I_IN_OUT), .OP(OP), .Q0(SRC0), .Q1(SRC1), .DEST(DEST), .IMMEDIATE(IMMED), .IMMEDIATE_B(IMMED_B), .flag_en(F_EN), .immed_sel(I_SEL), .b_immed_sel(B_SEL));

multiplexer16bit WRITE_MUX(.A(D_MEMORY), .B(ALU_OUT), .sel(WRITE_SEL), .Q(WRITE_IN));

regfile REGISTER_FILE(.DEST(DEST), .SRC0(SRC0), .SRC1(SRC1), .clk(CLK), .w_in(WRITE_IN), .w_en(WRITE_EN), .reset(init), .op0(OP0), .op1(D_DATA), .dest_out(DEST_OUT));

multiplexer3to1 IMMED_MUX(.A(IMMED_B_SXT), .B(IMMED_SXT), .C(D_DATA), .sel(IMMED_SEL), .Q(OP1));

alu ALU(.func(ALU_FUNC), .OP0(OP0), .OP1(OP1), .clk(DECODE), .flag_en(FLAG_EN), .flag_in(FLAG_IN), .b_sel(I_SEL), .Q(ALU_OUT), .flag_out(FLAG_OUT), .b_out(B_OUT));

RAM RAM_MEMORY(.A(DEST_OUT), .addr(ALU_OUT), .en(D_EN), .rw(READ_WRITE), .Q(D_MEMORY));

ROM ROM_MEMORY(.addr(PC_OUT), .en(1'b1), .Q(I_MEMORY));

// Insert a NOP if take branch
multiplexer16bit NOP_MUX(.A(16'h3FC1), .B(I_MEMORY), .sel(B_OUT), .Q(I_MEMORY_OUT));

endmodule;

