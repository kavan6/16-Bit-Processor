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

module regfile(DEST, SRC0, SRC1, clk, w_in, w_en, mem, reset, op0, op1);

input [2:0] DEST, SRC0, SRC1;

input [15:0] w_in;

input w_en, reset, clk, mem;

output [15:0] op0, op1;

wire [7:0] reg_en;

wire [15:0] in0, in1, in2, in3, in4, in5, in6, in7;

wire [15:0] out0, out1, out2, out3, out4, out5, out6, out7;

wire latch;

dflipflop W_LATCH(.D(w_en), .clk(clk), .en(1'b1), .reset(reset), .Q(latch));


decoder3to8 D0(.A(DEST), .en(1'b1), .D(reg_en));

//demultiplexer8bit DMUX0(.A(w_in), .sel(A[11:9]), .Q(in0), .R(in1), .S(in2), .T(in3), .U(in4), .V(in5), .W(in6), .X(in7));

register16bit R0(.D(w_in), .clk(clk), .en(reg_en[0] & (latch | mem)), .reset(reset), .Q(out0));
register16bit R1(.D(w_in), .clk(clk), .en(reg_en[1] & (latch | mem)), .reset(reset), .Q(out1));
register16bit R2(.D(w_in), .clk(clk), .en(reg_en[2] & (latch | mem)), .reset(reset), .Q(out2));
register16bit R3(.D(w_in), .clk(clk), .en(reg_en[3] & (latch | mem)), .reset(reset), .Q(out3));
register16bit R4(.D(w_in), .clk(clk), .en(reg_en[4] & (latch | mem)), .reset(reset), .Q(out4));
register16bit R5(.D(w_in), .clk(clk), .en(reg_en[5] & (latch | mem)), .reset(reset), .Q(out5));
register16bit R6(.D(w_in), .clk(clk), .en(reg_en[6] & (latch | mem)), .reset(reset), .Q(out6));
register16bit R7(.D(w_in), .clk(clk), .en(reg_en[7] & (latch | mem)), .reset(reset), .Q(out7));

multiplexer8to2 MUX0(.A(out0), .B(out1), .C(out2), .D(out3), .E(out4), .F(out5), .G(out6), .H(out7), .sel0(SRC0), .sel1(SRC1), .Q0(op0), .Q1(op1));


endmodule

`endif