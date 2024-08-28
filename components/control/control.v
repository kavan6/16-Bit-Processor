// Created by Kavan Heppenstall, 28/08/2024

`include "../state_machine/state.v"

module controlunit(OP, en, clk_out, immed_sel, w_en, alu_func, flag_en, mem_sel, mem_en, pc_sel);

    input [3:0] OP;
    input en;

    output w_en;
    output [3:0] alu_func;
    output immed_sel, flag_en, mem_sel, mem_en, pc_sel;

    output reg clk_out;

    reg fde_en, fde_reset;
    wire state;

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
                    immed_sel = 1'bX;
                    w_en = 1'b0;
                    alu_func = 4'b0000; // pass through
                    flag_en = 1'bX;
                    mem_sel = 1'bX;
                    mem_en = 1'bX;
                    pc_sel = 1'b1;
                end
                // ADDS
                4'h1: begin
                    immed_sel = 1'bX;
                    w_en = 1'b1;
                    alu_func = 4'b0001; // ADD
                    flag_en = 1'b1;
                    mem_sel = 1'b0;
                    mem_en = 1'b0;
                    pc_sel = 1'b0;
                end
                //
                4'h2: begin
                    
                end
                //
                4'h3: begin
                    
                end
                //
                4'h4: begin
                    
                end  
                //
                4'h5: begin
                    
                end  
                //
                4'h6: begin
                    
                end  
                // 
                4'h7: begin
                    
                end
                //
                4'h8: begin
                    
                end
                //
                4'h9: begin
                    
                end
                //
                4'hA: begin
                    
                end
                //
                4'hB: begin
                    
                end
                //
                4'hC: begin
                    
                end
                //
                4'hD: begin
                    
                end
                //
                4'hE: begin
                    
                end
                //
                4'hF: begin
                    
                end
                default: begin
                    immed_sel = 1'bX;
                    w_en = 1'bX;
                    alu_func = 4'bXXXX;
                    flag_en = 1'bX;
                    mem_sel = 1'bX;
                    mem_en = 1'bX;
                    pc_sel = 1'bX;
                end
            endcase
        end

    end



endmodule