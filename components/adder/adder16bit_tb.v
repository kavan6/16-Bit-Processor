// Created by Kavan Heppenstall, 22/08/2024

`timescale 1ns/1ns
`include "adder.v"

module adder16bit_tb;

reg [15:0] A, B;
reg C_in;

wire [15:0] S;
wire C_out;

integer i, j;

adder16bit dut(A, B, C_in, S, C_out);

initial begin
    
    $dumpfile("adder16bit_tb.vcd");
    $dumpvars(0, adder16bit_tb);

    #20;

    for (i = 0; i < 100; i = i + 1) begin
        
        for (j = 0; j < 100; j = j + 1) begin
            
            A = i; B = j; C_in = 1'b0; #20;
            
            A = i; B = j; C_in = 1'b1; #20;

        end

    end


    $display("end");

end


endmodule