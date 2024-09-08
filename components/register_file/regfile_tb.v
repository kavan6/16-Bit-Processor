// Created by Kavan Heppenstall, 01/09/2024

`timescale 1ns/1ns
`include "regfile.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [2:0] DEST, SRC0, SRC1;

reg [15:0] w_in;

reg w_en, reset;

wire [15:0] op0, op1;

regfile dut(.DEST(DEST), .SRC0(SRC0), .SRC1(SRC1), .clk, .w_in, .w_en, .reset, .op0, .op1);


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
    DEST = 3'b000; SRC0 = 3'b000; SRC1 = 3'b000; w_in = 16'h0000; w_en = 1'b0; reset = 1'b1; #20;
    DEST = 3'b001; SRC0 = 3'b000; SRC1 = 3'b000; w_in = 16'hAAAA; w_en = 1'b1; reset = 1'b0; #20;
    DEST = 3'b010; SRC0 = 3'b000; SRC1 = 3'b000; w_in = 16'hBBBB; w_en = 1'b0; reset = 1'b0; #20;
    DEST = 3'b011; SRC0 = 3'b000; SRC1 = 3'b000; w_in = 16'hCCCC; w_en = 1'b1; reset = 1'b0; #20;
    DEST = 3'b100; SRC0 = 3'b000; SRC1 = 3'b000; w_in = 16'hDDDD; w_en = 1'b1; reset = 1'b0; #20;
    DEST = 3'b101; SRC0 = 3'b000; SRC1 = 3'b000; w_in = 16'hEEEE; w_en = 1'b1; reset = 1'b0; #20;
    DEST = 3'b110; SRC0 = 3'b000; SRC1 = 3'b000; w_in = 16'hFFFF; w_en = 1'b1; reset = 1'b0; #20;
    DEST = 3'b000; SRC0 = 3'b010; SRC1 = 3'b100; w_in = 16'hEEEE; w_en = 1'b0; reset = 1'b0; #20;
    DEST = 3'b000; SRC0 = 3'b110; SRC1 = 3'b100; w_in = 16'hEEEE; w_en = 1'b0; reset = 1'b0; #20;


    $display("end simulation");

end

endmodule

