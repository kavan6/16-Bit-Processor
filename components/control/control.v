// Created by Kavan Heppenstall, 28/08/2024

`ifndef control_v
`define control_v

`include "../components/state_machine/state.v"

module controlunit(OP, en, immed_in, flag_in, clk_out, immed_sel, w_en, alu_func, flag_en, mem_sel, mem_en, pc_sel, read_write, ir_en);

    input [3:0] OP;
    input en, immed_in, flag_in;

    output reg w_en;
    output reg [3:0] alu_func;
    output reg pc_sel;
    output immed_sel, flag_en;
    output wire mem_en, read_write, mem_sel, ir_en;


    output reg clk_out;

    assign immed_sel = immed_in;
    assign flag_en = flag_in;

    reg fde_en, fde_reset;
    wire [1:0] state;

    fdemachine FDE(.clk(clk_out), .en(fde_en), .reset(fde_reset), .state(state));

    reg en_latch0, rw_latch0, sel_latch0, ir_latch0;
    wire en_latch1, rw_latch1, sel_latch1;
    reg latch_reset;

    dflipflop MEM_EN_LATCH0(.D(en_latch0), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(mem_en));
    dflipflop RW_LATCH0(.D(rw_latch0), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(read_write));
    dflipflop MEM_SEL_LATCH0(.D(sel_latch0), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(mem_sel));
    dflipflop IR_LATCH0(.D(ir_latch0), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(ir_en));


    // dflipflop MEM_EN_LATCH1(.D(en_latch1), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(mem_en));
    // dflipflop RW_LATCH1(.D(rw_latch1), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(read_write));
    // dflipflop MEM_SEL_LATCH1(.D(sel_latch1), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(mem_sel));

    initial begin
        clk_out <= 1'b0;
        pc_sel <= 1'b0;
        rw_latch0 <= 1'b1;
        en_latch0 <= 1'b1;
        w_en <= 1'b0;
        sel_latch0 <= 1'b0;
        ir_latch0 <= 1'b1;
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
                    w_en = 1'b0;
                    alu_func <= 4'b0000; // pass through
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b1;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // ADD
                4'h1: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0001; 
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // SUB
                4'h2: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0010; 
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // LSL
                4'h3: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0011;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // LSR
                4'h4: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0100;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end  
                // AND
                4'h5: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0101;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end  
                // OR
                4'h6: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0110;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end  
                // XOR
                4'h7: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0111;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // LD
                4'h8: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b1000;
                    sel_latch0 <= 1'b1;
                    en_latch0 <= 1'b1;
                    pc_sel <= 1'b1;
                    rw_latch0 <= 1'b1;
                    ir_latch0 <= 1'b0;
                end
                // ST
                4'h9: begin
                    w_en <= 1'b0;
                    alu_func <= 4'b1001;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b1;
                    pc_sel <= 1'b1;
                    rw_latch0 <= 1'b0;
                    ir_latch0 <= 1'b1;
                end
                // MOV
                4'hA: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b1010;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // BE
                4'hB: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b1011;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b1;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // BNE
                4'hC: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b1100;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b1;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // BLT
                4'hD: begin
                    w_en <= 1'b0;
                    alu_func <= 4'b1101;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b1;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // BGT
                4'hE: begin
                    w_en <= 1'b0;
                    alu_func <= 4'b1110;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b1;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                // CMP
                4'hF: begin
                    w_en <= 1'b0;
                    alu_func <= 4'b1111;
                    sel_latch0 <= 1'b0;
                    en_latch0 <= 1'b0;
                    pc_sel <= 1'b0;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'b1;
                end
                default: begin
                    w_en <= 1'bX;
                    alu_func <= 4'bXXXX;
                    sel_latch0 <= 1'bX;
                    en_latch0 <= 1'bX;
                    pc_sel <= 1'bX;
                    rw_latch0 <= 1'bX;
                    ir_latch0 <= 1'bX;
                end
            endcase
        end

    end

endmodule

`endif