// Created by Kavan Heppenstall, 12/09/2024

`timescale 1ns/1ns
`include "multiplexer.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] A, B, C;
reg [1:0] sel;

wire [15:0] Q;

multiplexer3to1 dut(.A(A), .B(B), .C(C), .sel(sel), .Q(Q));


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

    $dumpfile("multiplexer3to1_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;
    A = 16'h0000; B = 16'h0000; C = 16'h0000; sel = 2'b00; #20;
    A = 16'h0000; B = 16'h0000; C = 16'hFFFF; sel = 2'b00; #20;
    A = 16'h0000; B = 16'hDDDD; C = 16'hFFFF; sel = 2'b01; #20;
    A = 16'hEEEE; B = 16'h2222; C = 16'h0000; sel = 2'b10; #20;
    A = 16'h0000; B = 16'h0000; C = 16'h0000; sel = 2'b11; #20;


    $display("end simulation");

end

endmodule

