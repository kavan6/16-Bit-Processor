//Created by Kavan Heppenstall, 22/08/2024


module decoder1to2(A, D);

input A;
output [1:0] D;

assign D[0] = ~A;
assign D[1] = A;

endmodule

module decoder2to4(A, D);

input [1:0] A;
output [3:0] D;

wire [3:0] W;

decoder1to2 U0(.A(A[0]), .D(W[3:2]));

decoder1to2 U1(.A(A[1]), .D(W[1:0]));

assign D[0] = W[3] & W[1];
assign D[1] = W[2] & W[1];
assign D[2] = W[3] & W[0];
assign D[3] = W[2] & W[0];


endmodule


module decoder3to8(A, en, D);

input [2:0] A;
input en;

output [7:0] D;

wire [5:0] W;

decoder1to2 U0(.A(A[0]), .D(W[5:4]));

decoder1to2 U1(.A(A[1]), .D(W[3:2]));

decoder1to2 U2(.A(A[2]), .D(W[1:0]));


assign D[0] = en ? (W[5] & W[3] & W[1]):
              ~en ? 1'b0:
              1'bX;
assign D[1] = en ? (W[4] & W[3] & W[1]):
              ~en ? 1'b0:
              1'bX;
assign D[2] = en ? (W[5] & W[2] & W[1]):
              ~en ? 1'b0:
              1'bX;
assign D[3] = en ? (W[4] & W[2] & W[1]):
              ~en ? 1'b0:
              1'bX;
assign D[4] = en ? (W[5] & W[3] & W[0]):
              ~en ? 1'b0:
              1'bX;
assign D[5] = en ? (W[4] & W[3] & W[0]):
              ~en ? 1'b0:
              1'bX;
assign D[6] = en ? (W[5] & W[2] & W[0]):
              ~en ? 1'b0:
              1'bX;
assign D[7] = en ? (W[4] & W[2] & W[0]):
              ~en ? 1'b0:
              1'bX;


endmodule

module decoder4to16(A, en, D);

input [3:0] A;
input en;

output [15:0] D;

wire [15:0] W;

decoder3to8 U0(.A(A[2:0]), .en(A[3]), .D(D[15:8]));

decoder3to8 U1(.A(A[2:0]), .en(~A[3]), .D(D[7:0]));


endmodule
