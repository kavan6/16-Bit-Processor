// Created by Kavan Heppenstall, 23/08/2024

`timescale 1ns/1ns
`include "multiplexer.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] A, B; 
reg sel;

wire [15:0] Q;

multiplexer16bit dut(A, B, sel, Q);


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

    $dumpfile("multiplexer16bit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;
    A = 16'h0000; B = 16'h0000; sel = 1'b0; #20;
    A = 16'hAAAA; B = 16'h0000; sel = 1'b0; #20;
    A = 16'hAAAB; B = 16'h0DE4; sel = 1'b1; #20;
    A = 16'hAAAB; B = 16'h0DE4; sel = 1'b0; #20;



    $display("end simulation");

end

endmodule

