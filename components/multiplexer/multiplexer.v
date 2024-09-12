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

module multiplexer4bit(A, B, sel, Q);

input [3:0] A, B;
input sel;

output [3:0] Q;

assign Q =  (sel) ? A:
            (~sel) ? B:
            4'bXXXX;

endmodule

module multiplexer16bit(A, B, sel, Q);

input [15:0] A, B;
input sel;

output [15:0] Q;

assign Q =  (sel) ? A:
            (~sel) ? B:
            16'hXXXX;

endmodule

module multiplexer3to1(A, B, C, sel, Q);

input [15:0] A, B, C;
input [1:0] sel;

output [15:0] Q;

assign Q =  (sel == 2'b11) ? A:
            (sel == 2'b10) ? A:
            (sel == 2'b01) ? B:
            (sel == 2'b00) ? C:
            16'hXXXX;

endmodule


module multiplexer8to3(A, B, C, D, E, F, G, H, sel0, sel1, sel2, Q0, Q1, Q2);

input [15:0] A, B, C, D, E, F, G, H;
input [2:0] sel0, sel1, sel2;

output [15:0] Q0, Q1, Q2;

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

assign Q2 =  (sel2 == 3'b111) ? A:
            (sel2 == 3'b110) ? B:
            (sel2 == 3'b101) ? C:
            (sel2 == 3'b100) ? D:
            (sel2 == 3'b011) ? E:
            (sel2 == 3'b010) ? F:
            (sel2 == 3'b001) ? G:
            (sel2 == 3'b000) ? H:
            16'hXXXX;   

endmodule