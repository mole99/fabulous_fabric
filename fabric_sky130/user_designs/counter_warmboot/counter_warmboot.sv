module top(
    input  wire               clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);

	wire rst;
	reg [`NUM_IO-1:0] ctr;
	
    WARMBOOT_wrapper WARMBOOT_wrapper (
        .SLOT   (4'd0),
        .BOOT   (1'b0),
        .RESET  (rst)
    );

	always_ff @(posedge clk) begin
		if (rst)
			ctr <= '0;
		else
			ctr <= ctr + 1'b1;
    end

	assign io_out = ctr;
	assign io_oeb = '0;

endmodule
