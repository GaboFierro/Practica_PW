module one_shot (
    input clk,
    input signal,
    output reg pulse
);

    reg last;

    always @(posedge clk) begin
        last <= signal;
        pulse <= ~last & signal;
    end
endmodule

