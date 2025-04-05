module top(
    input  wire        clk,
    input  wire [47:0] io_in,
    output wire [47:0] io_out,
    output wire [47:0] io_oeb
);

	wire rst = io_in[0];
	
	reg [31:0] ctr;

	always @(posedge clk) begin
		if (rst)
			ctr <= 0;
		else
			ctr <= ctr + 1'b1;
    end

	assign io_out = {10'h123, ctr, rst, 1'b0}; // pass thru reset for debugging
	assign io_oeb = '1;
endmodule
