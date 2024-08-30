// Created by Kavan Heppenstall, 28/08/2024

`include "../state_machine/state.v"

module controlunit(OP, en, clk_out, immed_sel, w_en, alu_func, flag_en, mem_sel, mem_en, pc_sel, mar_sel);

    input [3:0] OP;
    input en;

    output reg w_en;
    output reg [3:0] alu_func;
    output reg immed_sel, flag_en, mem_sel, mem_en, pc_sel, mar_sel;

    output reg clk_out;

    reg fde_en, fde_reset;
    wire [1:0] state;

    fdemachine FDE(.clk(clk_out), .en(fde_en), .reset(fde_reset), .state(state));

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

    always @(state) begin

    end

    always @(OP) begin

        if (en) begin
            case (OP)
                // JMP
                4'h0: begin
                    immed_sel <= 1'b1;
                    w_en = 1'b0;
                    alu_func <= 4'b0000; // pass through
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b1;
                    pc_sel <= 1'b1;
                    mar_sel <= 1'b0;
                end
                // ADDS
                4'h1: begin
                    immed_sel <= 1'b0;
                    w_en <= 1'b1;
                    alu_func <= 4'b0001; 
                    flag_en <= 1'b1;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // SUBS
                4'h2: begin
                    immed_sel <= 1'b0;
                    w_en <= 1'b1;
                    alu_func <= 4'b0010; 
                    flag_en <= 1'b1;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // LSL
                4'h3: begin
                    immed_sel <= 1'b0;
                    w_en <= 1'b1;
                    alu_func <= 4'b0011;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // LSR
                4'h4: begin
                    immed_sel <= 1'b0;
                    w_en <= 1'b1;
                    alu_func <= 4'b0100;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end  
                // LD
                4'h5: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b1;
                    alu_func <= 4'b0101;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b1;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b1;
                end  
                // ST
                4'h6: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b0;
                    alu_func <= 4'b0110;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b1;
                    mem_en <= 1'b1;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b1;
                end  
                // MOV
                4'h7: begin
                    immed_sel <= 1'b0;
                    w_en <= 1'b1;
                    alu_func <= 4'b0111;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // ANDS + C
                4'h8: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b1;
                    alu_func <= 4'b1000;
                    flag_en <= 1'b1;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // ADDS + C
                4'h9: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b1;
                    alu_func <= 4'b1001;
                    flag_en <= 1'b1;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // SUBS + C
                4'hA: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b1;
                    alu_func <= 4'b1010;
                    flag_en <= 1'b1;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // LSL + C
                4'hB: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b1;
                    alu_func <= 4'b1011;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // LSR + C
                4'hC: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b1;
                    alu_func <= 4'b1100;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    mar_sel <= 1'b0;
                end
                // BNE
                4'hD: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b0;
                    alu_func <= 4'b1101;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b1;
                    mar_sel <= 1'b0;
                end
                // BLT
                4'hE: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b0;
                    alu_func <= 4'b1101;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b1;
                    mar_sel <= 1'b0;
                end
                // BE
                4'hF: begin
                    immed_sel <= 1'b1;
                    w_en <= 1'b0;
                    alu_func <= 4'b1101;
                    flag_en <= 1'b0;
                    mem_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b1;
                    mar_sel <= 1'b0;
                end
                default: begin
                    immed_sel <= 1'bX;
                    w_en <= 1'bX;
                    alu_func <= 4'bXXXX;
                    flag_en <= 1'bX;
                    mem_sel <= 1'bX;
                    mem_en <= 1'bX;
                    pc_sel <= 1'bX;
                    mar_sel <= 1'bX;
                end
            endcase
        end

    end



endmodule