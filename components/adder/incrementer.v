// Created by Kavan Heppenstall, 28/08/2024

module pcincrementer(A, clk, Q);

input [15:0] A;
input clk;

output reg [15:0] Q;

always @(A) begin
    Q <= A + 1;
end

endmodule