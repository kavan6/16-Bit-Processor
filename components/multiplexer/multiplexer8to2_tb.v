// Created by Kavan Heppenstall, 01/09/2024

`timescale 1ns/1ns
`include "multiplexer.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] A, B, C, D, E, F, G, H;
reg [2:0] sel;

wire [15:0] Q;

multiplexer8to2 dut(A, B, C, D, E, F, G, H, sel, Q);


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

    $dumpfile("multiplexer8to2.vcd");
    $dumpvars;

end

initial begin // Test Cases
    


    $display("end simulation");

end

endmodule

