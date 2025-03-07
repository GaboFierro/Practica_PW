# Practica_PW

📌 Descripción

Este proyecto implementa un sistema de control de contraseña basado en una Máquina de Estados Finitos (FSM) utilizando Verilog. El sistema permite el ingreso de una contraseña de 4 dígitos mediante switches, e indica el estado de progreso y resultado en displays de 7 segmentos y LEDs. La FSM controla el flujo desde el estado inicial, pasando por la verificación de cada dígito, hasta llegar a la validación o error.

⚙️ Requisitos
Tarjeta FPGA DE10-Lite (Intel Cyclone V)
Cable USB Blaster
Software Intel Quartus Prime Lite
Código en Verilog

📂 Estructura del Proyecto
|-- top_contra.v
|-- contra.v
|-- clk_divider.v
|-- README.md
