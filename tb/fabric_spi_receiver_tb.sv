// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`timescale 1ns/1ps
`default_nettype none

module fabric_spi_receiver_tb;

    initial begin
        $dumpfile("fabric_spi_receiver_tb.fst");
        $dumpvars(0, fabric_spi_receiver_tb);
    end

    wire  clk_i;
    wire  rst_ni;
    
    // Bitstream data
    wire [31:0] bitstream_data_o;
    wire        bitstream_valid_o;
    
    // SPI
    wire sclk;
    wire cs;
    wire mosi;
    wire miso;

    fabric_spi_receiver fabric_spi_receiver (
        .clk_i,
        .rst_ni,
        
        // Bitstream data
        .bitstream_data_o,
        .bitstream_valid_o,
        
        // Enable the SPI receiver
        .enable_i   (1'b1),
        
        // SPI
        .sclk_i (sclk),
        .cs_ni  (cs),
        .mosi_i (mosi),
        .miso_o (miso)
    );

    

endmodule
