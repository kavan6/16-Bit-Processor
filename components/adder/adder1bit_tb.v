`timescale 1ns/1ns
`include "adder.v"

module adder1bit_tb;

reg A, B, C_in;
wire S, C_out;
integer i;
reg c1, c2, c3;

adder1bit UUT(A, B, C_in, S, C_out);

initial begin
    
    c1 = 1'b1;
    c2 = 1'b1;
    c3 = 1'b1;

    $dumpfile("adder1bit_tb.vcd");
    $dumpvars(0, adder1bit_tb);

    #20;

    // A = 1'b0; B = 1'b0; C_in = 1'b0; #20;
    // A = 1'b0; B = 1'b0; C_in = 1'b1; #20;
    // A = 1'b0; B = 1'b1; C_in = 1'b0; #20;
    // A = 1'b0; B = 1'b1; C_in = 1'b1; #20;

    for (i = 0; i < 8; i = i + 1) begin
        
        if ((i % 4) == 0) begin
            c1 = ~c1;
        end

        if ((i % 2) == 0) begin
            c2 = ~c2;
        end

        if ((i % 1) == 0) begin
            c3 = ~c3;
        end

        A = c1; B = c2; C_in = c3; #20;

    end


    $display("end");

end

endmodule