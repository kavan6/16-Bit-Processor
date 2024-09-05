// Created by Kavan Heppenstall, 27/08/2004

// `include "../multiplexer/multiplexer.v"

module leftshifter16bit(A, mag, Q);


input [15:0] A;
input [3:0] mag;

output [15:0] Q;

wire [15:0] int1, int2, int3;

multiplexer1bit M0(1'b0, A[0], mag[0], int1[0]);
multiplexer1bit M1(A[0], A[1], mag[0], int1[1]);
multiplexer1bit M2(A[1], A[2], mag[0], int1[2]);
multiplexer1bit M3(A[2], A[3], mag[0], int1[3]);
multiplexer1bit M4(A[3], A[4], mag[0], int1[4]);
multiplexer1bit M5(A[4], A[5], mag[0], int1[5]);
multiplexer1bit M6(A[5], A[6], mag[0], int1[6]);
multiplexer1bit M7(A[6], A[7], mag[0], int1[7]);
multiplexer1bit M8(A[7], A[8], mag[0], int1[8]);
multiplexer1bit M9(A[8], A[9], mag[0], int1[9]);
multiplexer1bit M10(A[9], A[10], mag[0], int1[10]);
multiplexer1bit M11(A[10], A[11], mag[0], int1[11]);
multiplexer1bit M12(A[11], A[12], mag[0], int1[12]);
multiplexer1bit M13(A[12], A[13], mag[0], int1[13]);
multiplexer1bit M14(A[13], A[14], mag[0], int1[14]);
multiplexer1bit M15(A[14], A[15], mag[0], int1[15]);

multiplexer1bit M0_0(1'b0, int1[0], mag[1], int2[0]);
multiplexer1bit M1_1(1'b0, int1[1], mag[1], int2[1]);
multiplexer1bit M2_2(int1[0], int1[2], mag[1], int2[2]);
multiplexer1bit M3_3(int1[1], int1[3], mag[1], int2[3]);
multiplexer1bit M4_4(int1[2], int1[4], mag[1], int2[4]);
multiplexer1bit M5_5(int1[3], int1[5], mag[1], int2[5]);
multiplexer1bit M6_6(int1[4], int1[6], mag[1], int2[6]);
multiplexer1bit M7_7(int1[5], int1[7], mag[1], int2[7]);
multiplexer1bit M8_8(int1[6], int1[8], mag[1], int2[8]);
multiplexer1bit M9_9(int1[7], int1[9], mag[1], int2[9]);
multiplexer1bit M10_10(int1[8], int1[10], mag[1], int2[10]);
multiplexer1bit M11_11(int1[9], int1[11], mag[1], int2[11]);
multiplexer1bit M12_12(int1[10], int1[12], mag[1], int2[12]);
multiplexer1bit M13_13(int1[11], int1[13], mag[1], int2[13]);
multiplexer1bit M14_14(int1[12], int1[14], mag[1], int2[14]);
multiplexer1bit M15_15(int1[13], int1[15], mag[1], int2[15]);

multiplexer1bit M0_0_0(1'b0, int2[0], mag[2], int3[0]);
multiplexer1bit M1_1_1(1'b0, int2[1], mag[2], int3[1]);
multiplexer1bit M2_2_2(1'b0, int2[2], mag[2], int3[2]);
multiplexer1bit M3_3_3(1'b0, int2[3], mag[2], int3[3]);
multiplexer1bit M4_4_4(int2[0], int2[4], mag[2], int3[4]);
multiplexer1bit M5_5_5(int2[1], int2[5], mag[2], int3[5]);
multiplexer1bit M6_6_6(int2[2], int2[6], mag[2], int3[6]);
multiplexer1bit M7_7_7(int2[3], int2[7], mag[2], int3[7]);
multiplexer1bit M8_8_8(int2[4], int2[8], mag[2], int3[8]);
multiplexer1bit M9_9_9(int2[5], int2[9], mag[2], int3[9]);
multiplexer1bit M10_10_10(int2[6], int2[10], mag[2], int3[10]);
multiplexer1bit M11_11_11(int2[7], int2[11], mag[2], int3[11]);
multiplexer1bit M12_12_12(int2[8], int2[12], mag[2], int3[12]);
multiplexer1bit M13_13_13(int2[9], int2[13], mag[2], int3[13]);
multiplexer1bit M14_14_14(int2[10], int2[14], mag[2], int3[14]);
multiplexer1bit M15_15_15(int2[11], int2[15], mag[2], int3[15]);

multiplexer1bit M0_0_0_0(1'b0, int3[0], mag[3], Q[0]);
multiplexer1bit M1_1_1_1(1'b0, int3[1], mag[3], Q[1]);
multiplexer1bit M2_2_2_2(1'b0, int3[2], mag[3], Q[2]);
multiplexer1bit M3_3_3_3(1'b0, int3[3], mag[3], Q[3]);
multiplexer1bit M4_4_4_4(1'b0, int3[4], mag[3], Q[4]);
multiplexer1bit M5_5_5_5(1'b0, int3[5], mag[3], Q[5]);
multiplexer1bit M6_6_6_6(1'b0, int3[6], mag[3], Q[6]);
multiplexer1bit M7_7_7_7(1'b0, int3[7], mag[3], Q[7]);
multiplexer1bit M8_8_8_8(int3[0], int3[8], mag[3], Q[8]);
multiplexer1bit M9_9_9_9(int3[1], int3[9], mag[3], Q[9]);
multiplexer1bit M10_10_10_10(int3[2], int3[10], mag[3], Q[10]);
multiplexer1bit M11_11_11_11(int3[3], int3[11], mag[3], Q[11]);
multiplexer1bit M12_12_12_12(int3[4], int3[12], mag[3], Q[12]);
multiplexer1bit M13_13_13_13(int3[5], int3[13], mag[3], Q[13]);
multiplexer1bit M14_14_14_14(int3[6], int3[14], mag[3], Q[14]);
multiplexer1bit M15_15_15_15(int3[7], int3[15], mag[3], Q[15]);


endmodule

module rightshifter16bit(A, mag, Q);

input [15:0] A;
input [3:0] mag;

output [15:0] Q;

wire [15:0] int1, int2, int3;


multiplexer1bit M15(1'b0, A[15], mag[0], int1[15]);
multiplexer1bit M14(A[15], A[14], mag[0], int1[14]);
multiplexer1bit M13(A[14], A[13], mag[0], int1[13]);
multiplexer1bit M12(A[13], A[12], mag[0], int1[12]);
multiplexer1bit M11(A[12], A[11], mag[0], int1[11]);
multiplexer1bit M10(A[11], A[10], mag[0], int1[10]);
multiplexer1bit M9(A[10], A[9], mag[0], int1[9]);
multiplexer1bit M8(A[9], A[8], mag[0], int1[8]);
multiplexer1bit M7(A[8], A[7], mag[0], int1[7]);
multiplexer1bit M6(A[7], A[6], mag[0], int1[6]);
multiplexer1bit M5(A[6], A[5], mag[0], int1[5]);
multiplexer1bit M4(A[5], A[4], mag[0], int1[4]);
multiplexer1bit M3(A[4], A[3], mag[0], int1[3]);
multiplexer1bit M2(A[3], A[2], mag[0], int1[2]);
multiplexer1bit M1(A[2], A[1], mag[0], int1[1]);
multiplexer1bit M0(A[1], A[0], mag[0], int1[0]);

multiplexer1bit M15_15(1'b0, int1[15], mag[1], int2[15]);
multiplexer1bit M14_14(1'b0, int1[14], mag[1], int2[14]);
multiplexer1bit M13_13(int1[15], int1[13], mag[1], int2[13]);
multiplexer1bit M12_12(int1[14], int1[12], mag[1], int2[12]);
multiplexer1bit M11_11(int1[13], int1[11], mag[1], int2[11]);
multiplexer1bit M10_10(int1[12], int1[10], mag[1], int2[10]);
multiplexer1bit M9_9(int1[11], int1[9], mag[1], int2[9]);
multiplexer1bit M8_8(int1[10], int1[8], mag[1], int2[8]);
multiplexer1bit M7_7(int1[9], int1[7], mag[1], int2[7]);
multiplexer1bit M6_6(int1[8], int1[6], mag[1], int2[6]);
multiplexer1bit M5_5(int1[7], int1[5], mag[1], int2[5]);
multiplexer1bit M4_4(int1[6], int1[4], mag[1], int2[4]);
multiplexer1bit M3_3(int1[5], int1[3], mag[1], int2[3]);
multiplexer1bit M2_2(int1[4], int1[2], mag[1], int2[2]);
multiplexer1bit M1_1(int1[3], int1[1], mag[1], int2[1]);
multiplexer1bit M0_0(int1[2], int1[0], mag[1], int2[0]);

multiplexer1bit M15_15_15(1'b0, int2[15], mag[2], int3[15]);
multiplexer1bit M14_14_14(1'b0, int2[14], mag[2], int3[14]);
multiplexer1bit M13_13_13(1'b0, int2[13], mag[2], int3[13]);
multiplexer1bit M12_12_12(1'b0, int2[12], mag[2], int3[12]);
multiplexer1bit M11_11_11(int2[15], int2[11], mag[2], int3[11]);
multiplexer1bit M10_10_10(int2[14], int2[10], mag[2], int3[10]);
multiplexer1bit M9_9_9(int2[13], int2[9], mag[2], int3[9]);
multiplexer1bit M8_8_8(int2[12], int2[8], mag[2], int3[8]);
multiplexer1bit M7_7_7(int2[11], int2[7], mag[2], int3[7]);
multiplexer1bit M6_6_6(int2[10], int2[6], mag[2], int3[6]);
multiplexer1bit M5_5_5(int2[9], int2[5], mag[2], int3[5]);
multiplexer1bit M4_4_4(int2[8], int2[4], mag[2], int3[4]);
multiplexer1bit M3_3_3(int2[7], int2[3], mag[2], int3[3]);
multiplexer1bit M2_2_2(int2[6], int2[2], mag[2], int3[2]);
multiplexer1bit M1_1_1(int2[5], int2[1], mag[2], int3[1]);
multiplexer1bit M0_0_0(int2[4], int2[0], mag[2], int3[0]);

multiplexer1bit M15_15_15_15(1'b0, int3[15], mag[3], Q[15]);
multiplexer1bit M14_14_14_14(1'b0, int3[14], mag[3], Q[14]);
multiplexer1bit M13_13_13_13(1'b0, int3[13], mag[3], Q[13]);
multiplexer1bit M12_12_12_12(1'b0, int3[12], mag[3], Q[12]);
multiplexer1bit M11_11_11_11(1'b0, int3[11], mag[3], Q[11]);
multiplexer1bit M10_10_10_10(1'b0, int3[10], mag[3], Q[10]);
multiplexer1bit M9_9_9_9(1'b0, int3[9], mag[3], Q[9]);
multiplexer1bit M8_8_8_8(1'b0, int3[8], mag[3], Q[8]);
multiplexer1bit M7_7_7_7(int3[15], int3[7], mag[3], Q[7]);
multiplexer1bit M6_6_6_6(int3[14], int3[6], mag[3], Q[6]);
multiplexer1bit M5_5_5_5(int3[13], int3[5], mag[3], Q[5]);
multiplexer1bit M4_4_4_4(int3[12], int3[4], mag[3], Q[4]);
multiplexer1bit M3_3_3_3(int3[11], int3[3], mag[3], Q[3]);
multiplexer1bit M2_2_2_2(int3[10], int3[2], mag[3], Q[2]);
multiplexer1bit M1_1_1_1(int3[9], int3[1], mag[3], Q[1]);
multiplexer1bit M0_0_0_0(int3[8], int3[0], mag[3], Q[0]);

endmodule