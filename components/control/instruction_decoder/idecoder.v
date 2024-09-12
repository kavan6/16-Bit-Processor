// Created by Kavan Heppenstall, 28/08/2024

module instructiondecoder(A, OP, Q0, Q1, DEST, IMMEDIATE, IMMEDIATE_B, flag_en, immed_sel, b_immed_sel);

input [15:0] A;

output [3:0] OP;
output [2:0] Q0, Q1, DEST;
output [3:0] IMMEDIATE;
output [10:0] IMMEDIATE_B;
output immed_sel;
output flag_en;
output b_immed_sel;

assign OP = A[15:12];

assign DEST = A[11:9];

assign Q0 = A[8:6];

assign Q1 = A[5:3];

assign IMMEDIATE = A[5:2];
assign IMMEDIATE_B = A[11:1];

assign flag_en = A[1];
assign immed_sel = A[0];
assign b_immed_sel = ((A[15:12] == 4'b1011) | (A[15:12] == 4'b1100) | (A[15:12] == 4'b1101) | (A[15:12] == 4'b1110) | (A[15:12] == 4'b0000));

endmodule