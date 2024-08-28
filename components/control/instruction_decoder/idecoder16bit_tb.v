// Created by Kavan Heppenstall, 28/08/2024

`timescale 1ns/1ns
`include "idecoder.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] A;

wire [3:0] OP, Q0, Q1, DEST;


instructiondecoder dut(.A(A), .OP(OP), .Q0(Q0), .Q1(Q1), .DEST(DEST));


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

    $dumpfile("idecoder16bit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    A = 16'h0000; #20;
    A = 16'hABCD; #20;
    A = 16'hAE13; #20;
    A = 16'hFFE1; #20;


    $display("end simulation");

end

endmodule

