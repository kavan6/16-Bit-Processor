// Created by Kavan Heppenstall, 01/09/2024

`timescale 1ns/1ns
`include "demux.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000a;

reg clk;

// I/Os

reg A, sel;

wire Q, R;


demultiplexer1bit dut(.A(A), .sel(sel), .Q(Q), .R(R));


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

    $dumpfile("demultiplexer1bit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    A = 1'b0; sel = 1'b0; #20;
    A = 1'b1; sel = 1'b0; #20;


    $display("end simulation");

end

endmodule

