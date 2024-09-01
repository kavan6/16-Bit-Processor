// Created by Kavan Heppenstall, 01/09/2024

`timescale 1ns/1ns
`include "regfile.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [15:0] A;

reg [15:0] w_in;

reg w_en, reset;

wire [15:0] op0, op1;

regfile dut(.A, .clk, .w_in, .w_en, .reset, .op0, .op1);


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

    $dumpfile("regfile_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;
    A = 16'h0000; w_in = 16'h0000; w_en = 1'b0; reset = 1'b0; #20;
    A = 16'h1048; w_in = 16'h0000; w_en = 1'b1; reset = 1'b0; #20;
    A = 16'hFF4F; w_in = 16'hEEEE; w_en = 1'b1; reset = 1'b0; #20;


    $display("end simulation");

end

endmodule

