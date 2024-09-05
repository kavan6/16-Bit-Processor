// Created by Kavan Heppenstall, 05/08/2024

`timescale 1ns/1ns
`include "datapath.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os


datapath dut();


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
    


    $display("end simulation");

end

endmodule

