module top(
    input  wire        clk,
    input  wire [47:0] io_in,
    output wire [47:0] io_out,
    output wire [47:0] io_oeb
);

	assign io_out = io_in;
	assign io_oeb = '0;

endmodule
