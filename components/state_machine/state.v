//Created by Kavan Heppenstall, 26/08/2024

module fdemachine(clk, en, reset, fetch, decode, execute);

input clk, en, reset;

output reg fetch, decode, execute;

reg [2:0] state;

initial begin
    state <= 2'b00;
end

always @(posedge clk) begin
    
    if (en) begin

        if (reset) begin
            fetch <= 1'b0;
            decode <= 1'b0;
            execute <= 1'b0;
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    execute <= 1'b0;
                    fetch <= 1'b1;
                    state <= 2'b01;
                end
                2'b01: begin
                    fetch <= 1'b0;
                    decode <= 1'b1;
                    state <= 2'b10;
                end
                2'b10: begin
                    decode <= 1'b0;
                    execute <= 1'b1;
                    state <= 2'b00;
                end

                default: state <= 2'bXX;
            endcase
        end

    end

end

endmodule