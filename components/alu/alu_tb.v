// Created by Kavan Heppenstall, 05/09/2024

`timescale 1ns/1ns
`include "alu.v"


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;

reg clk;

// I/Os

reg [3:0] FUNC;
reg [15:0] OP0, OP1;
reg flag_en;
reg [3:0] flag_in;

wire [15:0] Q;
wire [3:0] flag_out;


alu dut(.func(FUNC), .OP0(OP0), .OP1(OP1), .flag_en(flag_en), .flag_in(flag_in), .Q(Q), .flag_out(flag_out));


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

    $dumpfile("alu_tb.vcd");
    $dumpvars;

end

initial begin // Test Cases
    
    #20;

    // JMP 0
    FUNC = 4'b0000; OP0 = 16'h0000; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b0; #20;
    // ADD 1
    FUNC = 4'b0001; OP0 = 16'h0001; OP1 = 16'h0001; flag_in = 4'b0000; flag_en = 1'b0; #20;
    FUNC = 4'b0001; OP0 = 16'h8001; OP1 = 16'h0001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // SUB 2
    FUNC = 4'b0010; OP0 = 16'h000A; OP1 = 16'h0005; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b0010; OP0 = 16'h0005; OP1 = 16'h000A; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // LSL 3
    FUNC = 4'b0011; OP0 = 16'h0001; OP1 = 16'h0001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b0011; OP0 = 16'h0001; OP1 = 16'h0004; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // LSR 4
    FUNC = 4'b0100; OP0 = 16'h8000; OP1 = 16'h0001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b0100; OP0 = 16'h0001; OP1 = 16'h0001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // AND 5
    FUNC = 4'b0101; OP0 = 16'h0001; OP1 = 16'h0001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b0101; OP0 = 16'h1100; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // OR 6
    FUNC = 4'b0110; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b0110; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // XOR 7
    FUNC = 4'b0111; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b0111; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // LD 8
    FUNC = 4'b1000; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b1000; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // ST 9
    FUNC = 4'b1001; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b1001; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // MOV A
    FUNC = 4'b1010; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b1010; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // BEQ B
    FUNC = 4'b1011; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b1011; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // BNE C
    FUNC = 4'b1100; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b1100; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // BLT D
    FUNC = 4'b1101; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b1101; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // BGT E
    FUNC = 4'b1110; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b1110; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;
    // CMP F
    FUNC = 4'b1111; OP0 = 16'h0001; OP1 = 16'h1001; flag_in = 4'b0000; flag_en = 1'b1; #20;
    FUNC = 4'b1111; OP0 = 16'h0101; OP1 = 16'h0000; flag_in = 4'b0000; flag_en = 1'b1; #20;

    $display("end simulation");

end

endmodule

