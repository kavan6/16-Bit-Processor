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


module datapath(reset, pc_reset, reg_reset, flag_reset);

input reset, pc_reset, reg_reset, flag_reset;

wire [15:0] mem1_int, mem0_int, decoder_int, OP0_out, OP1_out, ALU_in1, ALU_out, immed_sxt, WRITE_int, PC_int, MAR_int, ADDR_int;
wire [15:0] PC_out, INCREMENT_out;

wire CLK, immed_sel, write_en, flag_en, mem_sel, mem_en, pc_sel, rw, ir_en;

wire [3:0] alu_func, OP_int, immed_int;
wire [2:0] Q0_int, Q1_int, DEST_int;
wire [3:0] flag_int0, flag_int1, flag_out;

assign immed_sxt = { 12'b0, immed_int};


reg start;


multiplexer4bit FLAG_MUX(.A(4'b0000), .B(flag_int0), .sel(flag_reset), .Q(flag_int1));

register16bit IR(.D(mem1_int), .clk(CLK), .en(ir_en), .reset(reset), .Q(decoder_int));

register16bit PC(.D(PC_int), .clk(CLK), .en(1'b1), .reset(pc_reset), .Q(ADDR_int));

//register16bit MAR(.D(PC_out), .clk(CLK), .en(1'b1), .reset(reset), .Q(ADDR_int));

register4bit FLAGS(.D(flag_int1), .clk(CLK), .en(1'b1), .Q(flag_out), .reset(reset));

pcincrementer INCREMENTER(.A(PC_out), .clk(CLK), .Q(INCREMENT_out));

instructiondecoder DECODER(.A(decoder_int), .OP(OP_int), .Q0(Q0_int), .Q1(Q1_int), .DEST(DEST_int), .IMMEDIATE(immed_int), .flag_en(flag_en), .immed_sel(immed_sel));

controlunit CONTROL(.OP(OP_int), .en(1'b1), .clk_out(CLK), .immed_sel(immed_sel), .w_en(write_en), .alu_func(alu_func), .flag_en(flag_en), .mem_sel(mem_sel), .mem_en(mem_en), .pc_sel(pc_sel), .read_write(rw), .ir_en(ir_en));

regfile REGISTER_FILE(.DEST(DEST_int), .SRC0(Q0_int), .SRC1(Q1_int), .clk(CLK), .w_in(WRITE_int), .w_en(write_en), .mem(mem_en), .reset(reg_reset), .op0(OP0_out), .op1(OP1_out));

multiplexer16bit REG_MEM_MUX(.A(mem1_int), .B(ALU_out), .sel(mem_sel), .Q(WRITE_int));

multiplexer16bit IMMED_MUX(.A(immed_sxt), .B(OP1_out), .sel(immed_sel), .Q(ALU_in1));

multiplexer16bit PC_MUX(.A(ALU_out), .B(INCREMENT_out), .sel(pc_sel), .Q(PC_int));

RAM RAM_MEMORY(.A(ALU_out), .addr(ADDR_int), .en(mem_en), .rw(rw), .Q(mem1_int));

alu ALU(.func(alu_func), .OP0(OP0_out), .OP1(ALU_in1), .flag_en(flag_en), .flag_in(flag_out), .Q(ALU_out), .flag_out(flag_int0));

endmodule