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


module multiplexer8to2(A, B, C, D, E, F, G, H, sel0, sel1, Q0, Q1);

input [15:0] A, B, C, D, E, F, G, H;
input [2:0] sel0, sel1;

output [15:0] Q0, Q1;

assign Q0 =  (sel0 == 3'b111) ? A:
            (sel0 == 3'b110) ? B:
            (sel0 == 3'b101) ? C:
            (sel0 == 3'b100) ? D:
            (sel0 == 3'b011) ? E:
            (sel0 == 3'b010) ? F:
            (sel0 == 3'b001) ? G:
            (sel0 == 3'b000) ? H:
            16'hXXXX;

assign Q1 =  (sel1 == 3'b111) ? A:
            (sel1 == 3'b110) ? B:
            (sel1 == 3'b101) ? C:
            (sel1 == 3'b100) ? D:
            (sel1 == 3'b011) ? E:
            (sel1 == 3'b010) ? F:
            (sel1 == 3'b001) ? G:
            (sel1 == 3'b000) ? H:
            16'hXXXX;            

endmodule