// Created by Kavan Heppenstall, 28/08/2024

module instructiondecoder(A, OP, Q0, Q1, DEST, IMMEDIATE, flag_en, immed_sel);

input [15:0] A;

output [3:0] OP;
output [2:0] Q0, Q1, DEST;
output [5:2] IMMEDIATE;
output flag_en, immed_sel;

assign OP = A[15:12];

assign DEST = A[11:9];

assign Q0 = A[8:6];

assign Q1 = A[5:3];

assign IMMEDIATE = A[5:2];

assign flag_en = A[1];
assign immed_sel = A[0];

endmodule