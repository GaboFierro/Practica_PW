module counter_debouncer #(
    parameter N_MAX = 50000
)(
    input clk,
    input rst_a_p,
    output reg [$clog2(N_MAX)-1:0] counter_out,
    output reg counter_match
);

    always @(posedge clk or posedge rst_a_p) begin
        if (rst_a_p) begin
            counter_out <= 0;
            counter_match <= 0;
        end else if (counter_out >= N_MAX - 1) begin
            counter_out <= 0;
            counter_match <= 1;
        end else begin
            counter_out <= counter_out + 1;
            counter_match <= 0;
        end
    end
endmodule