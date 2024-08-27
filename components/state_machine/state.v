//Created by Kavan Heppenstall, 26/08/2024

module fdemachine(clk, en, state);

input clk, en;

output reg [1:0] state;

localparam fetch = 2'b00;
localparam decode = 2'b01;
localparam execute = 2'b10;
localparam memory = 2'b11;

localparam next_state = 2'b00;

always @(posedge clk) begin
    if (en) begin
        if(next_state == 2'b10) begin
            next_state = 2'b00;
        end else begin
            next_state = next_state + 1; 
        end

        state = next_state;
    end
end

endmodule