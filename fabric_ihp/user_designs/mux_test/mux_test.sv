module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);
    
    logic [`NUM_IO-1:0] io_inb;
    
    assign io_inb = ~io_in;
    
    (* keep *) FABULOUS_MUX2 mux2 (
        .I0 (io_inb[0]),
        .I1 (io_inb[1]),
        .S0 (io_in[2]),
        .O  (io_out[0])
    );

endmodule
