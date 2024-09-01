// Created by Kavan Heppenstall, 01/09/2024

module demultiplexer1bit(A, sel, Q, R);

input A, sel;

output Q, R;

assign Q =  (sel) ? A:
            (~sel) ? Q:
            1'bX;

assign R =  (~sel) ? A:
            (sel) ? Q:
            1'bX;

endmodule

module demultiplexer8bit(A, sel, Q, R, S, T, U, V, W, X);

input [15:0] A;
input [2:0] sel;

output [15:0] Q, R, S, T, U, V, W, X;

assign Q =  (sel == 3'b111) ? A:
            Q;

assign R =  (sel == 3'b110) ? A:
            R;

assign S =  (sel == 3'b101) ? A:
            S;

assign T =  (sel == 3'b100) ? A:
            T;

assign U =  (sel == 3'b011) ? A:
            U;

assign V =  (sel == 3'b010) ? A:
            V;

assign W =  (sel == 3'b001) ? A:
            W;

assign X =  (sel == 3'b000) ? A:
            X;

endmodule