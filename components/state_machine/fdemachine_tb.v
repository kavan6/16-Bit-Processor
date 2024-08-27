// Created by Kavan Heppenstall, 26/08/2024

`timescale 1ns/1ns
`include "state.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg en;

wire [1:0] state;

fdemachine dut(clk, en, state);


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

    $dumpfile("fdemachine_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    en = 1'b0; #20;
    en = 1'b1; #20;

    $display("end simulation");

end

endmodule

