// Created by Kavan Heppenstall, 01/09/2024


`ifdef regfile_v
`define regfile_v


`include "../multiplexer/multiplexer.v"
`include "../demultiplexer/demux.v"
`include "../register/register.v"
`include "../line_decoder/decoder.v"

`endif

`ifndef regfile_v
`define regfile_v

// `include "../multiplexer/multiplexer.v"
// `include "../demultiplexer/demux.v"
// `include "../register/register.v"
// `include "../line_decoder/decoder.v"

module regfile(DEST, SRC0, SRC1, clk, w_in, w_en, reset, op0, op1, dest_out);

input [2:0] DEST, SRC0, SRC1;

input [15:0] w_in;

input w_en, reset, clk;

output [15:0] op0, op1, dest_out;

wire [7:0] reg_en;

wire [15:0] write_int;

wire [15:0] in0, in1, in2, in3, in4, in5, in6, in7;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;

wire latch, reset_latch;

reg initial_reg;

// dflipflop W_LATCH(.D(w_en), .clk(clk), .en(1'b1), .reset(reset), .Q(latch));

// dflipflop RESET_LATCH(.D(initial_reg), .clk(clk), .en(1'b1), .reset(reset), .Q(reset_latch));

multiplexer16bit WRITE_MUX(.A(16'h0000), .B(w_in), .sel(reset), .Q(write_int));

decoder3to8 D0(.A(DEST), .en(1'b1), .D(reg_en));

//demultiplexer8bit DMUX0(.A(w_in), .sel(A[11:9]), .Q(in0), .R(in1), .S(in2), .T(in3), .U(in4), .V(in5), .W(in6), .X(in7));

register16bit R7(.D(16'h0000), .clk(clk), .en(1'b1 | reset), .reset(reset), .Q(r7));
register16bit R6(.D(write_int), .clk(clk), .en((reg_en[1] & w_en) | reset), .reset(reset), .Q(r6));
register16bit R5(.D(write_int), .clk(clk), .en((reg_en[2] & w_en) | reset), .reset(reset), .Q(r5));
register16bit R4(.D(write_int), .clk(clk), .en((reg_en[3] & w_en) | reset), .reset(reset), .Q(r4));
register16bit R3(.D(write_int), .clk(clk), .en((reg_en[4] & w_en) | reset), .reset(reset), .Q(r3));
register16bit R2(.D(write_int), .clk(clk), .en((reg_en[5] & w_en) | reset), .reset(reset), .Q(r2));
register16bit R1(.D(write_int), .clk(clk), .en((reg_en[6] & w_en) | reset), .reset(reset), .Q(r1));
register16bit R0(.D(write_int), .clk(clk), .en((reg_en[7] & w_en) | reset), .reset(reset), .Q(r0));

multiplexer8to3 MUX0(.A(r7), .B(r6), .C(r5), .D(r4), .E(r3), .F(r2), .G(r1), .H(r0), .sel0(SRC0), .sel1(SRC1), .sel2(DEST), .Q0(op0), .Q1(op1), .Q2(dest_out));


endmodule

`endif