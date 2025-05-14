// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`timescale 1ns/1ps
`default_nettype none

module tb;

    initial begin
        $dumpfile("tb.fst");
        $dumpvars(0, tb);
    end

    parameter FrameBitsPerRow = 32;
    parameter MaxFramesPerCol = 20;

    parameter NumColumns = 14;
    parameter NumRows = 18;

    parameter NUM_IO_WEST = 64;

    wire clk_i;
    wire rst_ni;
    
    // Bitstream
    wire  [31:0] bitstream_data_i;
    wire         bitstream_valid_i;
    
    // Configuration in progress
    wire  busy_o;
    
    // Fabric is configured
    wire configured_o;
    
    // To the fabric
    wire [(FrameBitsPerRow*NumRows)-1:0]    FrameData_o;
    wire [(MaxFramesPerCol*NumColumns)-1:0] FrameStrobe_o;
    
    // I/Os West
    wire [NUM_IO_WEST-1:0]      io_west_in_i;
    wire [NUM_IO_WEST-1:0]      io_west_out_o;
    wire [NUM_IO_WEST-1:0]      io_west_oe_o;

    // I/O West config
    wire [NUM_IO_WEST-1:0]      io_west_config_bit0_o;
    wire [NUM_IO_WEST-1:0]      io_west_config_bit1_o;
    wire [NUM_IO_WEST-1:0]      io_west_config_bit2_o;
    wire [NUM_IO_WEST-1:0]      io_west_config_bit3_o;

    // WARMBOOT
    wire        warmboot_boot_o;
    wire  [3:0] warmboot_slot_o;
    wire        warmboot_reset_i;

    // ADC 0
    wire        adc0_cmp_i;
    wire        adc0_hold_o;
    wire        adc0_reset_o;
    wire [11:0] adc0_value_o;
    
    // ADC 1
    wire        adc1_cmp_i;
    wire        adc1_hold_o;
    wire        adc1_reset_o;
    wire [11:0] adc1_value_o;

    // DAC 0
    wire [7:0]  dac0_value_o;
    wire        dac0_enable_o;
    
    // DAC 1
    wire [7:0]  dac1_value_o;
    wire        dac1_enable_o;
    
    assign warmboot_reset_i = busy_o;
    
    fabric_config #(
        	.FrameBitsPerRow    (FrameBitsPerRow),
	    .MaxFramesPerCol    (MaxFramesPerCol),
	    
	    .NumColumns         (NumColumns),
	    .NumRows            (NumRows)
    ) fabric_config (
        .clk_i,
        .rst_ni,
        
        // Bitstream
        .bitstream_data_i,
        .bitstream_valid_i,
        
        // Configuration in progress
        .busy_o,
        
        // Fabric is configured
        .configured_o,
        
        // To the fabric
        .FrameData_o,
        .FrameStrobe_o
    );
    
    
    fabric_wrapper fabric_wrapper (
        .clk_i,
        
        // Configuration
        .FrameData_i    (FrameData_o),
        .FrameStrobe_i  (FrameStrobe_o),
        
        // Fabric is configured
        .configured_i   (configured_o),
        
        // I/Os West
        .io_west_in_i,
        .io_west_out_o,
        .io_west_oe_o,

        // I/O West config
        .io_west_config_bit0_o,
        .io_west_config_bit1_o,
        .io_west_config_bit2_o,
        .io_west_config_bit3_o,

        // WARMBOOT
        .warmboot_boot_o,
        .warmboot_slot_o,
        .warmboot_reset_i,

        // ADC 0
        .adc0_cmp_i,
        .adc0_hold_o,
        .adc0_reset_o,
        .adc0_value_o,
        
        // ADC 1
        .adc1_cmp_i,
        .adc1_hold_o,
        .adc1_reset_o,
        .adc1_value_o,

        // DAC 0
        .dac0_value_o,
        .dac0_enable_o,
        
        // DAC 1
        .dac1_value_o,
        .dac1_enable_o
    );

endmodule

module clk_buf(input A, output X);
assign X = A;
endmodule

module break_comb_loop(input A, output X);
assign #0.1 X = A;
endmodule
