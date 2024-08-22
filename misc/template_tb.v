// Created by Kavan Heppenstall, 22/08/2024

`timescale 1ns/1ns
`include ""


module tb;

parameter PERIOD = 10;
parameter RUNTIME = 1000000;


// I/Os


DEVICE_UNDER_TEST dut();


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

    $dumpfile("this.vcd");
    $dumpvars;

end

initial begin // Test Cases
    


    $display("end simulation");

end

endmodule

