// Created by Kavan Heppenstall, 28/08/2024

`timescale 1ns/1ns
`include "control.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [3:0] OP;
reg en;


wire write_en;
wire [3:0] alu_func;
wire clk2, immed_sel, flag_en, mem_sel, mem_en, pc_sel;

controlunit dut(.OP(OP), .en(en), .clk_out(clk2), .immed_sel(immed_sel), .w_en(write_en), .alu_func(alu_func), .flag_en(flag_en), .mem_sel(mem_sel), .mem_en(mem_en), .pc_sel(pc_sel));


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

    $dumpfile("controlunit_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    en = 1'b0; #20;
    en = 1'b1; #20;

    OP = 4'h0; #20;
    OP = 4'h1; #20;

    $display("end simulation");

end

endmodule

