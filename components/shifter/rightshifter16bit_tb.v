// Created by Kavan Heppenstall, 28/08/2024

`timescale 1ns/1ns
`include "shifter.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] A;
reg [3:0] mag;

wire [15:0] Q;

rightshifter16bit dut(.A(A), .mag(mag), .Q(Q));


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

    $dumpfile("rightshifter16bit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    A = 16'h8000; mag = 4'h0; #20; 
    A = 16'h8000; mag = 4'h1; #20; 
    A = 16'h8000; mag = 4'h2; #20; 
    A = 16'h8000; mag = 4'h3; #20; 
    A = 16'h8000; mag = 4'h4; #20; 
    A = 16'h8000; mag = 4'h5; #20; 
    A = 16'h8000; mag = 4'h6; #20; 
    A = 16'h8000; mag = 4'h7; #20;
    A = 16'h8000; mag = 4'h8; #20; 
    A = 16'h8000; mag = 4'h9; #20; 
    A = 16'h8000; mag = 4'hA; #20; 
    A = 16'h8000; mag = 4'hB; #20; 
    A = 16'h8000; mag = 4'hC; #20; 
    A = 16'h8000; mag = 4'hD; #20; 
    A = 16'h8000; mag = 4'hE; #20; 
    A = 16'h8000; mag = 4'hF; #20; 

    A = 16'h1111; mag = 4'hF; #20; 
    A = 16'h1010; mag = 4'h1; #20; 


    $display("end simulation");

end

endmodule

