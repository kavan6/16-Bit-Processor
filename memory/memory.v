// Created by Kavan Heppenstall, 30/08/2024

module RAM(A, addr, en, rw, Q);

input [15:0] A;
input [3:0] addr;
input en, rw;

output reg [15:0] Q;

reg clk_en;

wire clk;

initial begin
    clk_en = 1;
end

mem_clk C0(.en(clk_en), .clk_out(clk));

reg [15:0] memory [15:0];

always @(posedge clk) begin

    if(en) begin
        if(rw) begin // READ
            
            Q <= memory[addr];

        end else if (!rw) begin // WRITE
            
            memory[addr] <= A;

        end
    end

end


endmodule


// Memory has its own clock

module mem_clk(en, clk_out);

input en;

output reg clk_out;

initial begin
    clk_out = 0;
end

always begin
    if (en) begin
        #10 clk_out = ~clk_out;
    end else begin
        #10 clk_out = clk_out;
    end        
end

endmodule