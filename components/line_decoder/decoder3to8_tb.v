// Created by Kavan Heppenstall, 23/08/2024

`timescale 1ns/1ns
`include "decoder.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [2:0] A;

wire [7:0] D;

integer i;

decoder3to8 dut(.A(A), .D(D));


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

    $dumpfile("decoder3to8_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    for (i = 0; i < 8; i = i + 1) begin
        
        A = i; #20;

    end


    $display("end simulation");

end

endmodule

