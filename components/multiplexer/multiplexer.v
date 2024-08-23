// Created by Kavan Heppenstall, 23/08/2024

module multiplexer1bit(A, B, sel, Q);

input A, B, sel;

output Q;

assign Q =  (sel) ? A:
            (~sel) ? B:
            1'bX;

endmodule

module multiplexer2bit(A, B, C, D, sel, Q);

input A, B, C, D;
input [1:0] sel;

output Q;

assign Q =  (~sel[1] & ~sel[0]) ? A:
            (~sel[1] & sel[0]) ? B:
            (sel[1] & ~sel[0]) ? C:
            (sel[1] & sel[0]) ? D:
            1'bX;

endmodule

module multiplexer16bit(A, B, sel, Q);

input [15:0] A, B;
input sel;

output [15:0] Q;

assign Q =  (sel) ? A:
            (~sel) ? B:
            16'hXXXX;

endmodule