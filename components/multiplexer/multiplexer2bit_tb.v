// Created by Kavan Heppenstall, 23/08/2024

`timescale 1ns/1ns
`include "multiplexer.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg A, B, C, D;
reg [1:0] sel;

wire Q;

multiplexer2bit dut(.A(A), .B(B), .C(C), .D(D), .sel(sel), .Q(Q));


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

    $dumpfile("multiplexer2bit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; sel = 2'b00; #20;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b0; sel = 2'b00; #20;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b0; sel = 2'b01; #20;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b0; sel = 2'b10; #20;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b1; sel = 2'b11; #20;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; sel = 2'b11; #20;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b0; sel = 2'b11; #20;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b1; sel = 2'b10; #20;



    $display("end simulation");

end

endmodule

