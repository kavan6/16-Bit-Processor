// Created by Kavan Heppenstall, 09/09/2024

`timescale 1ns/1ns
`include "memory.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] addr;
reg en;

wire [15:0] Q;

ROM dut(addr, en, Q);


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

    $dumpfile("ROM_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;
    addr = 16'h0000; en = 1'b1; #20;
    addr = 16'h0001; en = 1'b1; #20;
    addr = 16'h0002; en = 1'b1; #20;
    addr = 16'h000F; en = 1'b1; #20;

    $display("end simulation");

end

endmodule

