module address_dec#(localparam N = 127)(

    input clk,
    input rst,

    input [7:0] d_in,      //fsm
    output data_received,
    output [7:0] d_out,

    output [6:0] address,    //a_d kimenetek
    output [7:0] w_data,
    output [7:0] r_data,
    output wr,
    output [N-6:0] cs,
    output [N-6:0] [7:0] q
);

logic [N-6:0] [7:0] q_int;
logic [7:0] q_or;

assign address = 0;
assign q_or = 0;

assign wr = (d_in[7] == 1'b1) ? 1'b1 : 1'b0;

genvar i;

always @(posedge clk) begin
    for(i = 0; i < N; i = i + 1) begin
        assign cs[i] = (address == i)  ? 1'b1  : 1'b0;
    end

    for(i = 0; i < N; i = i + 1) begin
        q_int[7:0][i] = (cs[i] == 1)  ? q[7:0][i] : '0;          
    end

    for(i = 0; i < N; i = i + 1) begin
        q_or = (q_or | q_int[7:0][i]);
    end
end

assign r_data = q_or;

endmodule