// Created by Kavan Heppenstall, 28/08/2024

module instructiondecoder(A, OP, Q0, Q1, DEST);

input [15:0] A;

output [3:0] OP, Q0, Q1, DEST;

assign OP = A[15:12];

assign DEST = A[11:8];

assign Q0 = A[7:4];

assign Q1 = A[3:0];

endmodule