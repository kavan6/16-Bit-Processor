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

wire [15:0] D_MEMORY, D_DATA, I_MEMORY, PC_OUT, PC_OUT_OUT, PC_INT, PC_IN, PC_IN_OUT, PC_PLUS1, ALU_OUT, WRITE_IN, WRITE_IN_OUT, I_IN,I_IN_OUT, OP0, OP1, DEST_OUT, IMMED_SXT, IMMED_SXT_OUT;

wire [3:0] OP, IMMED, ALU_FUNC, FLAG_RESET, FLAG_IN, FLAG_OUT;

wire [2:0] DEST, SRC0, SRC1;

wire CLK, FLAG_EN, IMMED_SEL, WRITE_SEL, WRITE_EN, PC_SEL, READ_WRITE, D_EN, I_SEL, F_EN, FETCH, DECODE, EXECUTE;

assign IMMED_SXT = { 12'b0, IMMED };

// PIPE LINE BARRIERS

register16bit FETCH_BARRIER0(.D(I_IN), .clk(CLK), .en(FETCH), .reset(init), .Q(I_IN_OUT));

// register16bit DECODE_BARRIER0(.D(IMMED_SXT), .clk(CLK), .en(DECODE), .reset(init), .Q(IMMED_SXT_OUT));
// register3bit DECODE_BARRIER1(.D(DEST), .clk(CLK), .en(DECODE), .reset(init), .Q(DEST_OUT));
// register3bit DECODE_BARRIER2(.D(SRC0), .clk(CLK), .en(DECODE), .reset(init), .Q(SRC0_OUT));
// register3bit DECODE_BARRIER3(.D(SRC1), .clk(CLK), .en(DECODE), .reset(init), .Q(SRC1_OUT));

//register16bit FETCH_BARRIER1(.D(PC_IN), .clk(CLK), .en(FETCH), .reset(init), .Q(PC_IN_OUT));

// register16bit EXECUTE_BARRIER0(.D(PC_OUT), .clk(CLK), .en(EXECUTE), .reset(init), .Q(PC_OUT_OUT));

register16bit EXECUTE_BARRIER0(.D(WRITE_IN), .clk(CLK), .en(EXECUTE), .reset(init), .Q(WRITE_IN_OUT));


// CONTROL

controlunit CONTROL(.init(init), .OP(OP), .en(1'b1), .immed_in(I_SEL), .flag_in(F_EN), .clk_out(CLK), .immed_sel(IMMED_SEL), .w_en(WRITE_EN), .alu_func(ALU_FUNC), .flag_en(FLAG_EN), .write_sel(WRITE_SEL), .mem_en(D_EN), .pc_sel(PC_SEL), .read_write(READ_WRITE), .fetch(FETCH), .decode(DECODE), .execute(EXECUTE));

// Multiplexer for reseting/initialising flag register
multiplexer4bit FLAG_MUX(.A(4'b0000), .B(FLAG_OUT), .sel(init), .Q(FLAG_RESET));

register4bit FLAGS(.D(FLAG_RESET), .clk(CLK), .en(1'b1), .Q(FLAG_IN), .reset(init));

register16bit IR(.D(I_MEMORY), .clk(CLK), .en(1'b1), .reset(init), .Q(I_IN));

register16bit PC(.D(PC_IN), .clk(CLK), .en(FETCH), .reset(init), .Q(PC_OUT));

pcincrementer INCREMENTER(.A(PC_OUT), .clk(EXECUTE), .Q(PC_PLUS1));

multiplexer16bit PC_MUX(.A(ALU_OUT), .B(PC_PLUS1), .sel(PC_SEL), .Q(PC_IN));

instructiondecoder DECODER(.A(I_IN_OUT), .OP(OP), .Q0(SRC0), .Q1(SRC1), .DEST(DEST), .IMMEDIATE(IMMED), .flag_en(F_EN), .immed_sel(I_SEL));

multiplexer16bit WRITE_MUX(.A(D_MEMORY), .B(ALU_OUT), .sel(WRITE_SEL), .Q(WRITE_IN));

regfile REGISTER_FILE(.DEST(DEST), .SRC0(SRC0), .SRC1(SRC1), .clk(CLK), .w_in(WRITE_IN_OUT), .w_en(WRITE_EN), .reset(init), .op0(OP0), .op1(D_DATA), .dest_out(DEST_OUT));

multiplexer16bit IMMED_MUX(.A(IMMED_SXT), .B(D_DATA), .sel(IMMED_SEL), .Q(OP1));

alu ALU(.func(ALU_FUNC), .OP0(OP0), .OP1(OP1), .flag_en(FLAG_EN), .flag_in(FLAG_IN), .Q(ALU_OUT), .flag_out(FLAG_OUT));

RAM RAM_MEMORY(.A(DEST_OUT), .addr(ALU_OUT), .en(D_EN), .rw(READ_WRITE), .Q(D_MEMORY));

ROM ROM_MEMORY(.addr(PC_OUT), .en(1'b1), .Q(I_MEMORY));

endmodule;

// module datapath(reset, pc_reset, reg_reset, flag_reset);

// input reset, pc_reset, reg_reset, flag_reset;

// wire [15:0] mem1_int, mem0_int, decoder_int, OP0_out, OP1_out, ALU_in1, ALU_out, immed_sxt, WRITE_int, PC_int, MAR_int, ADDR_int;
// wire [15:0] PC_out, INCREMENT_out;

// wire CLK, immed_sel, write_en, flag_en, mem_sel, mem_en, pc_sel, rw, ir_en;

// wire [3:0] alu_func, OP_int, immed_int;
// wire [2:0] Q0_int, Q1_int, DEST_int;
// wire [3:0] flag_int0, flag_int1, flag_out;

// assign immed_sxt = { 12'b0, immed_int};


// reg start;


// multiplexer4bit FLAG_MUX(.A(4'b0000), .B(flag_int0), .sel(flag_reset), .Q(flag_int1));

// register16bit IR(.D(mem1_int), .clk(CLK), .en(ir_en), .reset(reset), .Q(decoder_int));

// register16bit PC(.D(PC_int), .clk(CLK), .en(1'b1), .reset(pc_reset), .Q(ADDR_int));

// //register16bit MAR(.D(PC_out), .clk(CLK), .en(1'b1), .reset(reset), .Q(ADDR_int));

// register4bit FLAGS(.D(flag_int1), .clk(CLK), .en(1'b1), .Q(flag_out), .reset(reset));

// pcincrementer INCREMENTER(.A(PC_out), .clk(CLK), .Q(INCREMENT_out));

// instructiondecoder DECODER(.A(decoder_int), .OP(OP_int), .Q0(Q0_int), .Q1(Q1_int), .DEST(DEST_int), .IMMEDIATE(immed_int), .flag_en(flag_en), .immed_sel(immed_sel));

// controlunit CONTROL(.OP(OP_int), .en(1'b1), .clk_out(CLK), .immed_sel(immed_sel), .w_en(write_en), .alu_func(alu_func), .flag_en(flag_en), .mem_sel(mem_sel), .mem_en(mem_en), .pc_sel(pc_sel), .read_write(rw), .ir_en(ir_en));

// regfile REGISTER_FILE(.DEST(DEST_int), .SRC0(Q0_int), .SRC1(Q1_int), .clk(CLK), .w_in(WRITE_int), .w_en(write_en), .mem(mem_en), .reset(reg_reset), .op0(OP0_out), .op1(OP1_out));

// multiplexer16bit REG_MEM_MUX(.A(mem1_int), .B(ALU_out), .sel(mem_sel), .Q(WRITE_int));

// multiplexer16bit IMMED_MUX(.A(immed_sxt), .B(OP1_out), .sel(immed_sel), .Q(ALU_in1));

// multiplexer16bit PC_MUX(.A(ALU_out), .B(INCREMENT_out), .sel(pc_sel), .Q(PC_int));

// RAM RAM_MEMORY(.A(ALU_out), .addr(ADDR_int), .en(mem_en), .rw(rw), .Q(mem1_int));

// alu ALU(.func(alu_func), .OP0(OP0_out), .OP1(ALU_in1), .flag_en(flag_en), .flag_in(flag_out), .Q(ALU_out), .flag_out(flag_int0));

// endmodule