// SPDX-FileCopyrightText: © 2025 Leo Moser <leo.moser@pm.me>
// SPDX-License-Identifier: Apache-2.0

`timescale 1ns/1ps
`default_nettype none

module fabric_spi_controller_tb;

    initial begin
        $dumpfile("fabric_spi_controller_tb.fst");
        $dumpvars(0, fabric_spi_controller_tb);
    end

    localparam NUM_SLOTS = 16;
    
    wire  clk_i;
    wire  rst_ni;
    
    // Start reading data at selected slot
    wire   start_i;
    wire   [$clog2(NUM_SLOTS)-1:0] slot_i;
    
    // Bitstream data
    wire [31:0] bitstream_data_o;
    wire        bitstream_valid_o;
    
    // Reading in progress
    wire  busy_o;
    
    // SPI
    wire sclk_o;
    wire cs_no;
    wire mosi_o;
    wire miso_i;

    fabric_spi_controller #(
        .BITSTREAM_LENGTH_WORDS (10),
        .SLOT_OFFSET_WORDS      (16),
        .NUM_SLOTS              (NUM_SLOTS)
    ) fabric_spi_controller (
        .clk_i,
        .rst_ni,
        
        // Start reading data at selected slot
        .start_i,
        .slot_i,
        
        // Bitstream data
        .bitstream_data_o,
        .bitstream_valid_o,
        
        // Reading in progress
        .busy_o,
        
        // SPI
        .sclk_o,
        .cs_no,
        .mosi_o,
        .miso_i
    );

    // QSPI - Flash
    logic            flash_sck;
    logic            flash_ce_n;
    wire [3:0] flash_io;
    
    // QSPI Flash
    spiflash i_spiflash (
	    .csb (flash_ce_n),
	    .clk (flash_sck),
	    .io0 (flash_io[0]), // MOSI
	    .io1 (flash_io[1]), // MISO
	    .io2 (flash_io[2]),
	    .io3 (flash_io[3])
    );
    
    assign flash_ce_n = cs_no;
    assign flash_sck = sclk_o;
    assign flash_io[0] = mosi_o;
    assign miso_i = flash_io[1];
    
    assign flash_io[2] = 1'bz;
    assign flash_io[3] = 1'bz;

endmodule
