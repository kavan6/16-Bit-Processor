// Created by Kavan Heppenstall, 22/08/2024

module dflipflop(D, clk, en, reset, Q);

input D, clk, en, reset;

output reg Q;


always @(posedge clk) begin
    
    if (en) begin

        if (reset) begin
        
        Q <= 1'b0;

        end else begin
            
            Q <= D;

        end
    end

end


endmodule

module register16bit(D, clk, en, reset, Q);

input [15:0] D;
input en;
input clk, reset;

output [15:0] Q;

genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin : dff
        dflipflop D (
            .D(D[i]),
            .clk(clk),
            .en(en),
            .reset(reset),
            .Q(Q[i])
        );
    end
endgenerate


endmodule

module register8bit(D, clk, en, Q, reset);

input [7:0] D;
input en;
input clk, reset;

output [7:0] Q;

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : dff
        dflipflop D (
            .D(D[i]),
            .clk(clk),
            .en(en),
            .reset(reset),
            .Q(Q[i])
        );
    end
endgenerate


endmodule

module register4bit(D, clk, en, Q, reset);

input [3:0] D;
input en;
input clk, reset;

output [3:0] Q;

genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin : dff
        dflipflop D (
            .D(D[i]),
            .clk(clk),
            .en(en),
            .reset(reset),
            .Q(Q[i])
        );
    end
endgenerate


endmodule

