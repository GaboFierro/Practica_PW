`timescale 1ns/1ps

module tb_top;

    reg CLOCK_50;
    reg [1:0] KEY;
    reg [9:0] SW;
    wire [6:0] HEX0, HEX1, HEX2, HEX3;
    wire [2:0] LEDR;

    // Instanciar el top
    top dut (
        .CLOCK_50(CLOCK_50),
        .KEY(KEY),
        .SW(SW),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .LEDR(LEDR)
    );

    // Reloj de 50 MHz simulado
    initial CLOCK_50 = 0;
    always #10 CLOCK_50 = ~CLOCK_50;  // 50 MHz -> Periodo de 20ns

    // Procedimiento de test
    initial begin
        // Inicialización
        KEY = 2'b11;   // Sin presionar (KEY[0] = 1, KEY[1] = 1)
        SW = 10'b0;

        // Reset
        #50;
        KEY[0] = 0;  // Presionamos reset
        #50;
        KEY[0] = 1;  // Soltamos reset

        // Caso 1: GOOD (SW[1:0] = 2'b11)
        SW[0] = 1;
        SW[1] = 1;
        #50;
        press_confirm();
        #100;

        // Revisar resultado (esperamos "GOOD" en los displays)
        check_display("GOOD");

        // Volver a IDLE
        press_confirm();
        #100;

        // Caso 2: BAD (SW[1:0] = 2'b10)
        SW[0] = 0;
        SW[1] = 1;
        #50;
        press_confirm();
        #100;

        // Revisar resultado (esperamos "BAD" en los displays)
        check_display("BAD");

        // Volver a IDLE
        press_confirm();
        #100;

        // Terminar la simulación
        $display("Testbench finalizado.");
        $stop;
    end

    // Tarea para presionar el botón de confirmación
    task press_confirm;
        begin
            KEY[1] = 0;  // Presionar KEY[1]
            #20;
            KEY[1] = 1;  // Soltar KEY[1]
        end
    endtask

    // Tarea para revisar el display
    task check_display(input [31:0] expected_text);
        begin
            case (expected_text)
                "GOOD": begin
                    if (HEX3 !== 7'b1000000 ||  // G
                        HEX2 !== 7'b0000011 ||  // o
                        HEX1 !== 7'b0000011 ||  // o
                        HEX0 !== 7'b0101111)    // d
                    begin
                        $display("ERROR: Se esperaba 'GOOD' pero no se mostró correctamente.");
                    end else begin
                        $display("Display muestra correctamente: GOOD");
                    end
                end
                "BAD": begin
                    if (HEX3 !== 7'b0000011 ||  // b
                        HEX2 !== 7'b0000110 ||  // A
                        HEX1 !== 7'b0101111 ||  // d
                        HEX0 !== 7'b1111111)    // espacio
                    begin
                        $display("ERROR: Se esperaba 'BAD' pero no se mostró correctamente.");
                    end else begin
                        $display("Display muestra correctamente: BAD");
                    end
                end
                default: $display("ERROR: Texto no reconocido.");
            endcase
        end
    endtask

endmodule
