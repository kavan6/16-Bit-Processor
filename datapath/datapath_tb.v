// Created by Kavan Heppenstall, 05/08/2024

`timescale 1ns/1ns
`include "datapath.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 100000;

reg clk;

// I/Os

reg reset;
reg pc_reset;

datapath dut(.reset(reset), .pc_reset(pc_reset));


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

    $dumpfile("datapath_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    pc_reset = 1'b0; #20;
    pc_reset = 1'b1; #20;
    pc_reset = 1'b0; #20;

    $display("end simulation");

end

endmodule

