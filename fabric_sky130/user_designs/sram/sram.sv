module top (
    input  wire               clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);

    OPENRAM_256x32_1RW1R_wrapper sram (
        .CSB_A   (io_in[0]),
        .WEB_A   (io_in[1]),
        .WMASK_A (io_in[5:2]),
        .ADDR_A  (io_in[13:6]),
        .DIN_A   (io_in[45:14]),
        .DOUT_A  (io_out[31:0]),
        
        .CSB_B   (io_in[46]),
        .ADDR_B  (io_in[55:47]),
        .DOUT_B  (io_out[63:32])
    );
    
    assign io_oeb = '0;

endmodule
