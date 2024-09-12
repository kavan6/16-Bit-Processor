// Created by Kavan Heppenstall, 05/09/2024

`ifdef alu_v
`define alu_v

`include "../adder/adder.v"
`include "../multiplexer/multiplexer.v"

`endif

`ifndef alu_V
`define alu_v

module alu(func, OP0, OP1, clk, flag_en, flag_in, Q, flag_out, b_out);

input wire [3:0] func;
input wire [15:0] OP0, OP1;
input wire [3:0] flag_in;
input wire flag_en, clk;

output reg [15:0] Q;
output reg [3:0] flag_out;
output reg b_out;

reg adder;
wire [15:0] adder_out;

// multiplexer16bit M0(.A(adder_out), .B(other), .sel(adder), .Q(Q));

// adder16bit ADDER(.A(OP0), .B(OP1), .C_in(flag_in[3]), .S(Q), .C_out(flag_out[3]));

always @(func, posedge clk) begin

    case (func)
        // JMP
        4'b0000: begin
            if (flag_en) begin
                {Q} <= {OP1};
            end else begin
                {Q} <= {OP1};
            end
            b_out <= 1'b1;
        end
        // ADD
        4'b0001: begin
            if (flag_en) begin
                {flag_out[3], Q} <= {1'b0, OP0} + {1'b0, OP1} + {flag_in[3]};
                {flag_out[2]} <= (Q[15] == 1'b1);           
                {flag_out[1]} <= ((OP0[15] == OP1[15]) && (Q[15] != OP0[15]));
                {flag_out[0]} <= (Q == 16'h0000);
            end else begin
                {Q} <= {1'b0, OP0} + {1'b0, OP1};
            end
            b_out <= 1'b0;
        end
        // SUB
        4'b0010: begin
            if (flag_en) begin
                {flag_out[3], Q} <= {1'b0, OP0} + {1'b0, ~OP1} + 1'b1;
                {flag_out[2]} <= (Q[15] == 1'b1);           
                {flag_out[1]} <= ((OP0[15] == OP1[15]) && (Q[15] != OP0[15]));
                {flag_out[0]} <= (Q == 16'h0000);
            end else begin
                {Q} <= {1'b0, OP0} + {1'b0, ~OP1} + 1'b1;
            end
            b_out <= 1'b0;
        end
        // LSL
        4'b0011: begin
            if (flag_en) begin
                {Q} <= OP0 << OP1;
                {flag_out[3]} <= OP0[15 - OP1];
                {flag_out[2]} <= (Q[15] == 1'b1);           
                {flag_out[1]} <= (1'b0);
                {flag_out[0]} <= (Q == 16'h0000);
            end else begin
                {Q} <= OP0 << OP1;
            end
            b_out <= 1'b0;
        end
        // LSR
        4'b0100: begin
            if (flag_en) begin
                {Q} <= OP0 >> OP1;
                {flag_out[3]} <= OP0[OP1 - 1];
                {flag_out[2]} <= (Q[15] == 1'b1);           
                {flag_out[1]} <= (1'b0);
                {flag_out[0]} <= (Q == 16'h0000);
            end else begin
                {Q} <= OP0 >> OP1;
            end
            b_out <= 1'b0;
        end
        // AND
        4'b0101: begin
            if (flag_en) begin
                {Q} <= OP0 & OP1;
                {flag_out[3]} <= (1'b0);
                {flag_out[2]} <= (Q[15] == 1'b1);           
                {flag_out[1]} <= (1'b0);
                {flag_out[0]} <= (Q == 16'h0000);
            end else begin
                {Q} <= OP0 & OP1;
            end
            b_out <= 1'b0;
        end
        // OR
        4'b0110: begin
            if (flag_en) begin
                {Q} <= OP0 | OP1;
                {flag_out[3]} <= (1'b0);
                {flag_out[2]} <= (Q[15] == 1'b1);           
                {flag_out[1]} <= (1'b0);
                {flag_out[0]} <= (Q == 16'h0000);
            end else begin
                {Q} <= OP0 | OP1;
            end
            b_out <= 1'b0;
        end
        // XOR
        4'b0111: begin
            if (flag_en) begin
                {Q} <= OP0 ^ OP1;
                {flag_out[3]} <= (1'b0);
                {flag_out[2]} <= (Q[15] == 1'b1);           
                {flag_out[1]} <= (1'b0);
                {flag_out[0]} <= (Q == 16'h0000);
            end else begin
                {Q} <= OP0 ^ OP1;
            end
            b_out <= 1'b0;
        end
        // LD
        4'b1000: begin
            if (flag_en) begin
                {Q} <= {1'b0, OP0} + {1'b0, OP1} + {flag_in[3]};
                {flag_out[3]} <= (1'b0);
                {flag_out[2]} <= (1'b0);
                {flag_out[1]} <= (1'b0);
                {flag_out[0]} <= (1'b0);
            end else begin
                {Q} <= {1'b0, OP0} + {1'b0, OP1};
            end
            b_out <= 1'b0;
        end
        // ST
        4'b1001: begin
            if (flag_en) begin
                {Q} <= {1'b0, OP0} + {1'b0, OP1};
                {flag_out[3]} <= (1'b0);
                {flag_out[2]} <= (1'b0);
                {flag_out[1]} <= (1'b0);
                {flag_out[0]} <= (1'b0);
            end else begin
                {Q} <= {1'b0, OP0} + {1'b0, OP1};
            end
            b_out <= 1'b0;
        end
        // MOV
        4'b1010: begin
            if (flag_en) begin
                {Q} <= {1'b0, OP0} + {1'b0, OP1};
                {flag_out[3]} <= (1'b0);
                {flag_out[2]} <= (1'b0);
                {flag_out[1]} <= (1'b0);
                {flag_out[0]} <= (1'b0);
            end else begin
                {Q} <= {1'b0, OP0} + {1'b0, OP1};
            end
            b_out <= 1'b0;
        end
        // BEQ
        4'b1011: begin
            if (flag_out[0] == 1'b1) begin
                {Q} <= {OP1};
                $display("OP1: %h, flag_in: %b", OP1, flag_in);
                b_out <= 1'b1;
            end else begin
                b_out <= 1'b0;
            end
        end
        // BNE
        4'b1100: begin
            if (flag_out[0] == 1'b0) begin
                Q <= OP1;
                b_out <= 1'b1;
            end else begin
                b_out <= 1'b0;
            end
        end
        // BLT
        4'b1101: begin
            if ((flag_out[2] == 1'b1) && (flag_out[0] == 1'b0)) begin
                {Q} <= {OP1};
                b_out <= 1'b1;
            end else begin
                b_out <= 1'b0;
            end

        end
        // BGT
        4'b1110: begin
            if ((flag_out[2] == 1'b0) && (flag_out[0] == 1'b0)) begin
                {Q} <= {OP1};
                b_out <= 1'b1;
            end else begin
                b_out <= 1'b0;
            end
        end
        // CMP
        4'b1111: begin
            {flag_out[3], Q} <= {1'b0, OP0} + {1'b0, ~OP1} + {flag_in[3]} + 1'b1;
            {flag_out[2]} <= (Q[15] == 1'b1);           
            {flag_out[1]} <= ((OP0[15] == OP1[15]) && (Q[15] != OP0[15]));
            {flag_out[0]} <= (Q == 16'h0000);
        end
        default: begin
            {flag_out[3], Q} <= 16'hXXXX;
            {flag_out[2]} <= 1'bX;           
            {flag_out[1]} <= 1'bX;
            {flag_out[0]} <= 1'bX;
        end
    endcase

end


endmodule

`endif