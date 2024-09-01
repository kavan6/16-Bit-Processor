// Created by Kavan Heppenstall, 01/09/2024

`timescale 1ns/1ns
`include "demux.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] A;
reg [2:0] sel;

wire [15:0] Q, R, S, T, U, V, W, X;

demultiplexer8bit dut(A, sel, Q, R, S, T, U, V, W, X);


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

    $dumpfile("demultiplexer8bit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    A = 16'h0000; sel = 3'b000; #20;
    A = 16'hFEEF; sel = 3'b111; #20;
    A = 16'hFEEF; sel = 3'b101; #20;
    A = 16'h10AF; sel = 3'b100; #20;
    A = 16'hAAAA; sel = 3'b111; #20;


    $display("end simulation");

end

endmodule

