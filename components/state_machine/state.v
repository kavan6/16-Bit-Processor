//Created by Kavan Heppenstall, 26/08/2024

module fdemachine(clk, en, reset, state);

input clk, en, reset;

output reg [1:0] state;

localparam fetch = 2'b00;
localparam decode = 2'b01;
localparam execute = 2'b10;
localparam memory = 2'b11;

always @(posedge clk) begin
    
    if (en) begin

        if (reset) begin
            state <= fetch;
        end else begin
            case (state)
                fetch: begin
                    state <= decode;
                end
                decode: begin
                    state <= execute;
                end
                execute: begin
                    state <= fetch;
                end

                default: state <= fetch;
            endcase
        end

    end

end

endmodule