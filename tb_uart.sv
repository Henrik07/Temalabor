`timescale 1ns / 1ps

module tb_uart ();

    logic clk_1; // The master clock for this module
    logic rst_1; // Synchronous reset.
    logic rx_1; // Incoming serial line
    logic tx_1; // Outgoing serial line
    logic transmit_1; // Signal to transmit
    logic [7:0] tx_byte_1; // Byte to transmit
    logic received_1; // Indicated that a byte has been received.
    logic [7:0] rx_byte_1; // Byte received
    logic is_receiving_1; // Low when receive line is idle.
    logic is_transmitting_1; // Low when transmit line is idle.
    logic recv_error_1; // Indicates error in receiving packet.

    logic clk_2; // The master clock for this module
    logic rst_2; // Synchronous reset.
    logic rx_2; // Incoming serial line
    logic tx_2; // Outgoing serial line
    logic transmit_2; // Signal to transmit
    logic [7:0] tx_byte_2; // Byte to transmit
    logic received_2; // Indicated that a byte has been received.
    logic [7:0] rx_byte_2; // Byte received
    logic is_receiving_2; // Low when receive line is idle.
    logic is_transmitting_2; // Low when transmit line is idle.
    logic recv_error_2; // Indicates error in receiving packet.

    uart #(.CLOCK_DIVIDE( 2604 )) uart_1(
        .clk(clk_1),
        .rst(rst_1),
        .rx(rx_1),
        .tx(tx_1),
        .transmit(transmit_1),
        .tx_byte(tx_byte_1),
        .received(received_1),
        .rx_byte(rx_byte_1),
        .is_receiving(is_receiving_1),
        .is_transmitting(is_transmitting_1),
        .recv_error(recv_error_1)
    );

    uart #(.CLOCK_DIVIDE( 2606 )) uart_2(
        .clk(clk_2),
        .rst(rst_2),
        .rx(rx_2),
        .tx(tx_2),
        .transmit(transmit_2),
        .tx_byte(tx_byte_2),
        .received(received_2),
        .rx_byte(rx_byte_2),
        .is_receiving(is_receiving_2),
        .is_transmitting(is_transmitting_2),
        .recv_error(recv_error_2)
    );

    always #5 clk_1 = ~clk_1;
    always #4.99 clk_2 = ~clk_2;

    initial begin
        clk_1 = 1;
        clk_2 = 1;
        rst_1 = 0;
        rst_2 = 0;
        transmit_1 = 1;
        transmit_2 = 1;
        rx_1 = 1;
        rx_1 = 1;
        #100;
        rst_1 = 1;
        rst_2 = 1;
        #500;
        rst_1 = 0;
        rst_2 = 0;
        transmit_1 = 0;
        transmit_2 = 0;
        rx_1 = 0;
        rx_1 = 0;
        #100;
    end

    logic [7:0] Din_1 = 8'h55;
    logic [7:0] Din_2 = 8'h55;

    logic [7:0] Dout_1;
    logic [7:0] Dout_2;

    always @(posedge clk_1) begin
        Dout_1 <= rx_byte_1;
        tx_byte_1 <= Din_1;
    end

    always @(posedge clk_2) begin
        Dout_2 <= rx_byte_2;
        tx_byte_2 <= Din_2;
    end

endmodule
