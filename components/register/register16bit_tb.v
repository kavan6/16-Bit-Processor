// Created by Kavan Heppenstall, 22/08/2024

`timescale 1ns/1ns
`include "register.v"

module tb;

parameter PERIOD = 10;
parameter RUNTIME = 100000;

reg clk;

reg [15:0] D;
reg reset;

wire [15:0] Q;

register16bit dut(.D(D), .clk(clk), .reset(reset), .Q(Q));

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

    $dumpfile("register16bit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    D = 16'h0000; reset = 1'b0; #20;
    D = 16'h0003; reset = 1'b0; #20;
    D = 16'h0002; reset = 1'b0; #20;
    D = 16'h000D; reset = 1'b0; #20;
    reset = 1'b1; #20;
    
    #20;    


    $display("end simulation");
end



endmodule

