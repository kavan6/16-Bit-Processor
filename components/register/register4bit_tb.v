// Created by Kavan Heppenstall, 28/08/2024

`timescale 1ns/1ns
`include "register.v"

module tb;

parameter PERIOD = 10;
parameter RUNTIME = 100000;

reg clk;

reg [3:0] D, en;
reg reset;

wire [3:0] Q;

register4bit dut(.D(D), .clk(clk), .en(en), .reset(reset), .Q(Q));

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

    $dumpfile("register4bit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    D = 4'h0; reset = 1'b0; #20;
    D = 4'h3; reset = 1'b0; #20;
    D = 4'h2; reset = 1'b0; #20;
    D = 4'hD; reset = 1'b0; #20;
    reset = 1'b1; #20;
    
    #20;    


    $display("end simulation");
end



endmodule

