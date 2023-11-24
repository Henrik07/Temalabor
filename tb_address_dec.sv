module tb_address_dec();
    parameter N = 127;
    logic clk;
    logic rst_n;

    logic [7:0] d_in;      //fsm
    logic data_received;
    logic [7:0] d_out;

    logic [6:0] address;    //a_d kimenetek
    logic [7:0] w_data;
    logic [7:0] r_data;
    logic wr;
    logic [N-6:0] cs;

    address_dec #(.N(N)) uut(
        .clk(clk),
        .rst(rst_n),
        .d_in(d_in),
        .data_received(data_received),
        .d_out(d_out),
        .address(address),
        .w_data(w_data),
        .r_data(r_data),
        .wr(wr),
        .cs(cs)
    );

endmodule