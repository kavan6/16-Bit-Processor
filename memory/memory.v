// Created by Kavan Heppenstall, 30/08/2024

module RAM(A, addr, en, rw, Q);

input [15:0] A;
input [15:0] addr;
input en, rw;

reg [15:0] memory [511:0];

output reg [15:0] Q;

reg clk_en;

wire clk;

reg[8*8-1:0] str;
reg res;
integer mem_file;
integer scan_file;
integer count;

initial begin
    clk_en = 1;
    count = 0;

    mem_file = $fopen("memory.txt", "r");
    if (mem_file == 0) begin
        mem_file = $fopen("../memory/memory.txt", "r");
        if (mem_file == 0) begin
            $display("memory file handle was NULL");
            $finish;
        end
    end

    while (! $feof(mem_file)) begin
        
        res = $fgets(str, mem_file);

        if(res) begin
            
            scan_file = $sscanf(str, "%h", memory[count]);

            if (scan_file == 1) begin
                $display("Loaded Memory[%0d]: %h", count, memory[count]);
                count = count + 1;
            end else begin
                $display("Error reading line %0d", count);
            end

        end
    end

    $fclose(mem_file);

end

mem_clk C0(.en(clk_en), .clk_out(clk));

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