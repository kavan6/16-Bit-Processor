// Created by Kavan Heppenstall, 22/08/2024

module adder1bit(A, B, C_in, S, C_out);

input A, B, C_in;
output S, C_out;

assign S = A + B + C_in;

assign C_out = (A & B) | (A & C_in) | (B & C_in);

endmodule

module adder4bit(A, B, C_in, S, C_out);

input [3:0] A, B;
input C_in;

output [3:0] S;
output C_out;

wire [3:0] C_internal;

adder1bit A0(.A(A[0]), .B(B[0]), .C_in(C_in), .S(S[0]), .C_out(C_internal[0]));

adder1bit A1(.A(A[1]), .B(B[1]), .C_in(C_internal[0]), .S(S[1]), .C_out(C_internal[1]));

adder1bit A2(.A(A[2]), .B(B[2]), .C_in(C_internal[1]), .S(S[2]), .C_out(C_internal[2]));

adder1bit A3(.A(A[3]), .B(B[3]), .C_in(C_internal[2]), .S(S[3]), .C_out(C_out));


endmodule

module adder16bit(A, B, C_in, S, C_out);

    input [15:0] A, B;
    input C_in;

    output [15:0] S;
    output C_out;

    wire [3:0] C_internal;

    adder4bit A0(.A(A[3:0]), .B(B[3:0]), .C_in(C_in), .S(S[3:0]), .C_out(C_internal[0]));
    
    adder4bit A1(.A(A[7:4]), .B(B[7:4]), .C_in(C_internal[0]), .S(S[7:4]), .C_out(C_internal[1]));
    
    adder4bit A2(.A(A[11:8]), .B(B[11:8]), .C_in(C_internal[1]), .S(S[11:8]), .C_out(C_internal[2]));
    
    adder4bit A3(.A(A[15:12]), .B(B[15:12]), .C_in(C_internal[2]), .S(S[15:12]), .C_out(C_out));


endmodule