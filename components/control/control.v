// Created by Kavan Heppenstall, 28/08/2024

`ifndef control_v
`define control_v

`include "../components/state_machine/state.v"

module controlunit(init, OP, en, immed_in, flag_in, clk_out, immed_sel, w_en, alu_func, flag_en, write_sel, mem_en, pc_sel, read_write, fetch, decode, execute);

    input [3:0] OP;
    input en, immed_in, flag_in, init;


    output reg w_en;
    output reg [3:0] alu_func;
    output reg pc_sel;
    output immed_sel, flag_en;
    output reg mem_en, read_write, write_sel;

    output fetch, decode, execute;

    output reg clk_out;

    assign immed_sel = immed_in;
    assign flag_en = flag_in;

    reg fde_en;

    wire [1:0] state;

    fdemachine FDE(.clk(clk_out), .en(fde_en), .reset(init), .fetch(fetch), .decode(decode), .execute(execute));

    // dflipflop MEM_mem_en(.D(mem_en), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(mem_en));
    // dflipflop read_write(.D(read_write), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(read_write));
    // dflipflop write_write_sel(.D(write_sel), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(write_sel));
    // dflipflop ir_en(.D(ir_en), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(ir_en));


    // dflipflop MEM_EN_LATCH1(.D(en_latch1), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(mem_en));
    // dflipflop RW_LATCH1(.D(rw_latch1), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(read_write));
    // dflipflop write_sel_LATCH1(.D(sel_latch1), .clk(clk_out), .en(1'b1), .reset(latch_reset), .Q(write_sel));

    initial begin
        clk_out <= 1'b0;
        pc_sel <= 1'b0;
        read_write <= 1'b1;
        mem_en <= 1'b1;
        w_en <= 1'b0;
        write_sel <= 1'b0;
        fde_en <= 1'b1;
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
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end
                // ADD
                4'h1: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0001; 
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end
                // SUB
                4'h2: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0010; 
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end
                // LSL
                4'h3: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0011;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end
                // LSR
                4'h4: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0100;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end  
                // AND
                4'h5: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0101;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end  
                // OR
                4'h6: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0110;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end  
                // XOR
                4'h7: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b0111;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end
                // LD
                4'h8: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b1000;
                    write_sel <= 1'b1;
                    mem_en <= 1'b1;
                    pc_sel <= 1'b0;
                    read_write <= 1'b1;
                end
                // ST
                4'h9: begin
                    w_en <= 1'b0;
                    alu_func <= 4'b1001;
                    write_sel <= 1'b0;
                    mem_en <= 1'b1;
                    pc_sel <= 1'b0;
                    read_write <= 1'b0;
                end
                // MOV
                4'hA: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b1010;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end
                // BE
                4'hB: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b1011;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b1;
                    read_write <= 1'bX;
                end
                // BNE
                4'hC: begin
                    w_en <= 1'b1;
                    alu_func <= 4'b1100;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b1;
                    read_write <= 1'bX;
                end
                // BLT
                4'hD: begin
                    w_en <= 1'b0;
                    alu_func <= 4'b1101;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b1;
                    read_write <= 1'bX;
                end
                // BGT
                4'hE: begin
                    w_en <= 1'b0;
                    alu_func <= 4'b1110;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b1;
                    read_write <= 1'bX;
                end
                // CMP
                4'hF: begin
                    w_en <= 1'b0;
                    alu_func <= 4'b1111;
                    write_sel <= 1'b0;
                    mem_en <= 1'b0;
                    pc_sel <= 1'b0;
                    read_write <= 1'bX;
                end
                default: begin
                    w_en <= 1'bX;
                    alu_func <= 4'bXXXX;
                    write_sel <= 1'bX;
                    mem_en <= 1'bX;
                    pc_sel <= 1'bX;
                    read_write <= 1'bX;
                end
            endcase
        end

    end

endmodule

`endif