module test_reset (
    input CLOCK_50,
    input [1:0] KEY,
    output [0:0] LEDR
);

    assign LEDR[0] = ~KEY[0];  // LED encendido si KEY[0] está presionado

endmodule
