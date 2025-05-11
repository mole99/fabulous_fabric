module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);
    
    MULADD_wrapper #(
        .A_reg  (1'b1),
        .B_reg  (1'b1),
        .C_reg  (1'b0),
        
        .signExtension  (1'b1),
        .ACC            (1'b0),
        .ACCout         (1'b0),
    ) muladd (
        .A  (io_in[7:0]),
        .B  (io_in[15:8]),
        .C  ('0),
        .clr  (1'b0),
        
        .Q  (io_out[19:0]),
        
        //.GlobalClk()
    );

endmodule
