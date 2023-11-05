`timescale 1ns / 1ps

module tb_uart ();

    logic clk_1; // The master clock for this module
    logic rst_n_1; // Synchronous reset.
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
    logic rst_n_2; // Synchronous reset.
    logic rx_2; // Incoming serial line
    logic tx_2; // Outgoing serial line
    logic transmit_2; // Signal to transmit
    logic [7:0] tx_byte_2; // Byte to transmit
    logic received_2; // Indicated that a byte has been received.
    logic [7:0] rx_byte_2; // Byte received
    logic is_receiving_2; // Low when receive line is idle.
    logic is_transmitting_2; // Low when transmit line is idle.
    logic recv_error_2; // Indicates error in receiving packet.

    logic [7:0] din_1;
    logic [7:0] din_2;
    logic [7:0] dout_1;
    logic [7:0] dout_2;

    uart #(.CLOCK_DIVIDE( 2604 )) uart_1(
        .clk(clk_1),
        .rst(rst_n_1),
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

    uart #(.CLOCK_DIVIDE( 2604 )) uart_2(
        .clk(clk_2),
        .rst(rst_n_2),
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

    assign rx_1 = tx_2;
    assign rx_2 = tx_1;
    assign tx_1 = rx_1;
    assign tx_2 = rx_2;

    always #5ns clk_1 = ~clk_1;
    always #4.99ns clk_2 = ~clk_2;

    initial begin
        clk_1 = 1;
        clk_2 = 1;
        rst_n_1 = 0;
        rst_n_2 = 0;
        transmit_1 = 0;
        transmit_2 = 0;
        #100ns;
        rst_n_1 = 1;
        rst_n_2 = 1;
    end

    always @(negedge clk_1) begin
        if (!rst_n_1)begin
            din_1 <= 8'h55;
        end
        else if (din_1 > 8'h00 && transmit_1)begin
            din_1 <= din_1 - 8'h01;
        end
        else begin
            din_1 <= din_1;
        end
    end

    always @(posedge clk_1) begin
        if (transmit_1) begin
            dout_1 <= rx_byte_1;
            tx_byte_1 <= din_1;
            rx_byte_2 <= tx_byte_1;
            #1ns
            transmit_1 <= 0;
        end
        else if (!transmit_1) begin
            #1ns
            transmit_1 <= 1;
        end
    end

    always @(posedge clk_2) begin
        if (transmit_2) begin
            dout_2 <= rx_byte_2;
            din_2 <= dout_2;
            tx_byte_2 <= din_2;
            rx_byte_1 <= tx_byte_2;
            #1ns
            transmit_2 <= 0;
        end
        else if (!transmit_2) begin
            #1ns
            transmit_2 <= 1;
        end
    end

endmodule
