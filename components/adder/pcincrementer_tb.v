// Created by Kavan Heppenstall, 28/08/2024

`timescale 1ns/1ns
`include "incrementer.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] A;

wire [15:0] Q;


pcincrementer dut(A, clk, Q);


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

    $dumpfile("pcincrementer_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    A = 16'h0000; #20;
    A = Q; #20;
    A = Q; #20;
    A = Q; #20;
    A = Q; #20;
    A = Q; #20;


    $display("end simulation");

end

endmodule

