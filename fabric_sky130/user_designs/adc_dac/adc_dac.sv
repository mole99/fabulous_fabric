module top(
    input  wire        clk,
    input  wire [47:0] io_in,
    output wire [47:0] io_out,
    output wire [47:0] io_oeb
);

    logic reset;

    WARMBOOT_wrapper i_WARMBOOT_wrapper (
        .SLOT   (4'd0),
        .BOOT   (1'b0),
        .RESET  (reset)
    );

    logic [11:0] adc_value;

    EF_ADC12_wrapper #(
        .SAMPLE (4'd13)
    ) i_EF_ADC12_wrapper (
        .START  (1'b1),
        .RESET  (reset),
        .VALID  (adc_valid),
        .VALUE  (adc_value)
    );
    
    logic [7:0] dac_value;
    
    always_ff @(posedge clk) begin
        if (adc_valid) begin
            dac_value = adc_value[11:4];
        end
    end

    EF_DAC8_wrapper i_EF_DAC8_wrapper (
        .VALUE (dac_value)
    );

    assign io_out = {'0, dac_value};
    assign io_oeb = '0;

endmodule
