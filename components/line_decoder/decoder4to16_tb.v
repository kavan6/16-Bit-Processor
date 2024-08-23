// Created by Kavan Heppenstall, 23/08/2024

`timescale 1ns/1ns
`include "decoder.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [3:0] A;
reg en;

wire [15:0] D;

integer i, j;

decoder4to16 dut(.A(A), .en(en), .D(D));


initial begin
    $display("starting simulation");
    clk = 0;
end

always begin
    if ($time > RUNTIME) begin
        $finish;
    end else begin
        #PERIOD clk = ~clk;
    end
end

initial begin

    $dumpfile("decoder4to16_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    en = 1'b1; #20;

    A = 4'b0000; #20;

    for (i = 0; i < 2; i = i + 1) begin
        for (j = 0; j < 8; j = j + 1) begin
            A[3] = i; A[2:0] = j; #20;
        end
    end

    $display("end simulation");

end

endmodule

