# SPDX-FileCopyrightText: © 2025 Leo Moser <leomoser99@gmail.com>
# SPDX-License-Identifier: Apache-2.0

import os
import math
import random
from pathlib import Path
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.triggers import Timer, Edge, RisingEdge, FallingEdge
from cocotb.regression import TestFactory
from cocotb.runner import get_runner

random.seed()

WAIT_CYCLES = random.randint(0, 5)
print(f'WAIT_CYCLES: {WAIT_CYCLES}')

FrameBitsPerRow = 32
MaxFramesPerCol = 20
FrameSelectWidth = 5 # hardcoded, should be based on NumColumns

NumColumns = 12
NumRows = 18

BITSTREAM_START = 0xFAB0FAB1
DESYNC_FLAG = 20

FABRIC_NUM_IO_WEST = 32
FABRIC_NUM_IO_NORTH = 16

run_all_zeros   = True
run_all_ones    = True
run_counter     = True
run_passthrough = True
run_sram        = True
run_adc_dac     = True
run_peripheral  = True
run_xif         = True

async def reset_design(dut):
    dut.rst_ni.value = 0
    await ClockCycles(dut.clk_i, 10)
    dut.rst_ni.value = 1

async def set_defaults(dut):
    dut.bitstream_data_i.value = 0
    dut.bitstream_valid_i.value = 0
    
    dut.fabric_io_west_in_i.value = 0
    dut.fabric_io_north_in_i.value = 0
    
    dut.fabric_adc0_cmp_i.value = 0

    dut.fabric_sram0_do_i.value = 0
    dut.fabric_sram1_do_i.value = 1
    dut.fabric_sram2_do_i.value = 2
    dut.fabric_sram3_do_i.value = 3
    dut.fabric_sram4_do_i.value = 4
    dut.fabric_sram5_do_i.value = 5
    dut.fabric_sram6_do_i.value = 6
    dut.fabric_sram7_do_i.value = 7
    
    dut.fabric_xif_or_periph_i.value = 0 # XIF
    
    dut.fabric_rs1_i.value = 13
    dut.fabric_rs2_i.value = 42
    
    dut.fabric_req_i.value = 0
    dut.fabric_we_i.value = 0
    dut.fabric_be_i.value = 0
    dut.fabric_addr_i.value = 13
    dut.fabric_wdata_i.value = 42
    
    print('Clearing bitstream!')
    
    # Reset all frames to zero
    await zero_bitstream(dut)
    
    print('Bitstream cleared!')

async def zero_bitstream(dut):
    """
    Upload an all-zeros bitstream in reverse to prevent
    logic loops before uploading a new user design.
    
    For faster clearing enable all FrameStrobe signals
    of a column at once.
    
    Note: Still does not reliably prevent logic loops...
    """

    # Write start of bitstream
    dut.bitstream_valid_i.value = 1
    dut.bitstream_data_i.value = BITSTREAM_START
    await ClockCycles(dut.clk_i, 1)
    
    # Write zero frames in reverse
    for column in reversed(range(NumColumns)):
    
        # Write header, clear all frames of a column at once
        dut.bitstream_data_i.value = column<<(FrameBitsPerRow-FrameSelectWidth) | ((1<<MaxFramesPerCol)-1)
        await ClockCycles(dut.clk_i, 1)

        # Write row data
        dut.bitstream_data_i.value = 0x00000000
        await ClockCycles(dut.clk_i, NumRows)

    # Write desync bit
    dut.bitstream_data_i.value = 1<<DESYNC_FLAG
    await ClockCycles(dut.clk_i, 1)

async def upload_bitstream(dut, name):
    """
    Read data until start of bitstream is detected
    Write data until desync bit is in header
    """

    print(f'Uploading bitstream: {name}')

    with open(f'../../user_designs/{name}/{name}.bit', 'br') as f:

        # Wait for start of bitstream
        while (data := f.read(4)) != None:
            number = int.from_bytes(data, "big")
            if number == BITSTREAM_START:
                print('Start of bitstream')
                
                # Write start of bitstream
                dut.bitstream_valid_i.value = 1
                dut.bitstream_data_i.value = number
                await ClockCycles(dut.clk_i, 1)

                if WAIT_CYCLES:
                    dut.bitstream_valid_i.value = 0
                    await ClockCycles(dut.clk_i, WAIT_CYCLES)

                break
    
        # Read bitstream content
        while 1:
        
            # Read header
            data = f.read(4)
            if data == None:
                break
            header = int.from_bytes(data, "big")
            
            print(f'--- header: 0x{header:08x}')

            # Write header
            dut.bitstream_valid_i.value = 1
            dut.bitstream_data_i.value = header
            await ClockCycles(dut.clk_i, 1)
            
            if WAIT_CYCLES:
                dut.bitstream_valid_i.value = 0
                await ClockCycles(dut.clk_i, WAIT_CYCLES)

            # Desync
            if header & (1<<DESYNC_FLAG):
                print("Detected desync flag!")
                break
            
            # Read row data
            for i in range(NumRows):
                row_data = int.from_bytes(f.read(4), "big")
                
                print(f'0x{row_data:08x}')
                
                # Write row data
                dut.bitstream_valid_i.value = 1
                dut.bitstream_data_i.value = row_data
                await ClockCycles(dut.clk_i, 1)
                
                if WAIT_CYCLES:
                    dut.bitstream_valid_i.value = 0
                    await ClockCycles(dut.clk_i, WAIT_CYCLES)
        
        print(f'Bitstream upload completed')
        
        # Stop the bitstream
        dut.bitstream_valid_i.value = 0
        dut.bitstream_data_i.value = 0
        await ClockCycles(dut.clk_i, 1)

@cocotb.test(skip=True)
async def test_default(dut):
    """No bitstream loaded"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_all_zeros==False)
async def test_all_zeros(dut):
    """Load bitstream to set output to zero"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'all_zeros')
    
    values_west = [random.randint(0,(1<<FABRIC_NUM_IO_WEST)-1) for _ in range(10)]
    values_north = [random.randint(0,(1<<FABRIC_NUM_IO_NORTH)-1) for _ in range(10)]
    
    for value_west, value_north in zip(values_west, values_north):
        dut.fabric_io_west_in_i.value = value_west
        dut.fabric_io_north_in_i.value = value_north
        await ClockCycles(dut.clk_i, 1)
        assert(dut.fabric_io_west_out_o.value == 0)
        assert(dut.fabric_io_north_out_o.value == 0)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_all_ones==False)
async def test_all_ones(dut):
    """Load bitstream to set output to ones"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'all_ones')

    values_west = [random.randint(0,(1<<FABRIC_NUM_IO_WEST)-1) for _ in range(10)]
    values_north = [random.randint(0,(1<<FABRIC_NUM_IO_NORTH)-1) for _ in range(10)]
    
    for value_west, value_north in zip(values_west, values_north):
        dut.fabric_io_west_in_i.value = value_west
        dut.fabric_io_north_in_i.value = value_north
        await ClockCycles(dut.clk_i, 1)
        assert(dut.fabric_io_west_out_o.value == (1<<FABRIC_NUM_IO_WEST)-1)
        assert(dut.fabric_io_north_out_o.value == (1<<FABRIC_NUM_IO_NORTH)-1)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_counter==False)
async def test_counter(dut):
    """Load bitstream for counter"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'counter')
    
    dut.fabric_io_west_in_i.value = 1
    await ClockCycles(dut.clk_i, 5)
    dut.fabric_io_west_in_i.value = 0
    
    await ClockCycles(dut.clk_i, 30)

@cocotb.test(skip=run_passthrough==False)
async def test_passthrough(dut):
    """Load bitstream for test_passthrough"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")

    await upload_bitstream(dut, 'passthrough')
    
    values_west = [random.randint(0,(1<<FABRIC_NUM_IO_WEST)-1) for _ in range(10)]
    values_north = [random.randint(0,(1<<FABRIC_NUM_IO_NORTH)-1) for _ in range(10)]
    
    for value_west, value_north in zip(values_west, values_north):
        dut.fabric_io_west_in_i.value = value_west
        dut.fabric_io_north_in_i.value = value_north
        await ClockCycles(dut.clk_i, 1)
        assert(dut.fabric_io_west_out_o.value == value_west)
        assert(dut.fabric_io_north_out_o.value == value_north)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_sram==False)
async def test_sram(dut):
    """Load bitstream for test_sram"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")

    await upload_bitstream(dut, 'sram')
    
    for i in range(8):
    
        # Select sram
        dut.fabric_io_west_in_i.value = i<<10
        await ClockCycles(dut.clk_i, 4)
        
        # Test the correct output of each sram
        assert(dut.fabric_io_west_out_o.value == i)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_adc_dac==False)
async def test_adc_dac(dut):
    """Load bitstream for adc_dac"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'adc_dac')
    
    dut.fabric_adc0_cmp_i.value = 1
    await ClockCycles(dut.clk_i, 50)
    
    dut.fabric_adc0_cmp_i.value = 0
    await ClockCycles(dut.clk_i, 50)

async def write_reg(dut, addr, data, be=0xF):
    dut.fabric_req_i.value = 1
    dut.fabric_we_i.value = 1
    dut.fabric_be_i.value = be
    dut.fabric_addr_i.value = addr
    dut.fabric_wdata_i.value = data
    
    while 1:
        await ClockCycles(dut.clk_i, 1)
        if dut.fabric_gnt_o.value == 1 and dut.fabric_rvalid_o.value == 1:
            dut.fabric_req_i.value = 0
            dut.fabric_we_i.value = 0
            dut.fabric_be_i.value = 0
            dut.fabric_addr_i.value = 0
            dut.fabric_wdata_i.value = 0
            await ClockCycles(dut.clk_i, 1)
            return

async def read_reg(dut, addr):
    dut.fabric_req_i.value = 1
    dut.fabric_we_i.value = 0
    dut.fabric_be_i.value = 0
    dut.fabric_addr_i.value = addr
    dut.fabric_wdata_i.value = 0

    while 1:
        await ClockCycles(dut.clk_i, 1)
        if dut.fabric_gnt_o.value == 1 and dut.fabric_rvalid_o.value == 1:
            rdata = dut.fabric_rdata_o.value
            dut.fabric_req_i.value = 0
            dut.fabric_we_i.value = 0
            dut.fabric_be_i.value = 0
            dut.fabric_addr_i.value = 0
            dut.fabric_wdata_i.value = 0
            await ClockCycles(dut.clk_i, 1)
            return rdata

@cocotb.test(skip=run_peripheral==False)
async def test_peripheral(dut):
    """Load bitstream for peripheral"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'peripheral')

    dut.fabric_xif_or_periph_i.value = 1 # Peripheral

    NUM_REGS = 32

    for i in range(NUM_REGS):
        for _ in range(5):
            value = random.randint(0,(1<<32)-1)
            
            await write_reg(dut, i, value)
            assert (await read_reg(dut, i) == value)

    for i in reversed(range(NUM_REGS)):
        for _ in range(5):
            value = random.randint(0,(1<<32)-1)
            
            await write_reg(dut, i, value)
            assert (await read_reg(dut, i) == value)

    # Test byte enable
    await write_reg(dut, 0, 0)

    await write_reg(dut, 0, 0x000000FF, be=0x1)
    assert (await read_reg(dut, 0) == 0x000000FF)
    
    await write_reg(dut, 0, 0xFF000000, be=0x8)
    assert (await read_reg(dut, 0) == 0xFF0000FF)
    
    await write_reg(dut, 0, 0xFFFF00FF, be=0x2)
    assert (await read_reg(dut, 0) == 0xFF0000FF)
    
    await write_reg(dut, 0, 0x000000FF, be=0x8)
    assert (await read_reg(dut, 0) == 0x000000FF)
    
    await write_reg(dut, 0, 0xDEADBEEF)
    assert (await read_reg(dut, 0) == 0xDEADBEEF)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_xif==False)
async def test_xif(dut):
    """Load bitstream for xif"""

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'xif')
    
    dut.fabric_xif_or_periph_i.value = 0 # XIF
    
    values_rs1 = [random.randint(0,(1<<32)-1) for _ in range(10)]
    values_rs2 = [random.randint(0,(1<<32)-1) for _ in range(10)]
    
    for value_rs1, value_rs2 in zip(values_rs1, values_rs2):
    
        result = (value_rs1 + value_rs2) & 0xFFFFFFFF
    
        dut.fabric_rs1_i.value = value_rs1
        dut.fabric_rs2_i.value = value_rs2
        
        await ClockCycles(dut.clk_i, 1)
        
        assert (dut.fabric_result_o.value == result)

    await ClockCycles(dut.clk_i, 10)

if __name__ == "__main__":

    sim = os.getenv("SIM", "icarus")
    pdk_root = os.getenv("PDK_ROOT", "~/.volare")
    pdk = os.getenv("PDK", "sky130A")
    scl = os.getenv("SCL", "sky130_fd_sc_hd")
    gl = os.getenv("GL", None)

    proj_path = Path(__file__).resolve().parent
    
    # Add fabric wrapper, fabric config and tb wrapper
    sources = [
        '../rtl/fabric_wrapper.sv',
        '../../rtl/fabric_config.sv',
        'tb_icarus.sv'
    ]

    if gl:
        # GL does not work because of pessimistic x-propagation!
        sources.append(f'../macro/{pdk}/nl/eFPGA.nl.v')
        sources.append(Path(pdk_root).expanduser() / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v" )
        sources.append(Path(pdk_root).expanduser() / pdk / "libs.ref" / scl / "verilog" / "primitives.v" )
    else:
        # Add fabric
        sources.append(f'../macro/sky130A/fabulous/eFPGA.v')

        # Add tiles
        TILES_ROOT = '../../fabulous_tiles/tiles'
        
        # DSP
        sources.append(f'{TILES_ROOT}/DSP/DSP.v')
        sources.append(f'{TILES_ROOT}/DSP/DSP_bot/DSP_bot.v')
        sources.append(f'{TILES_ROOT}/DSP/DSP_bot/DSP_bot_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/DSP/DSP_bot/DSP_bot_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/DSP/DSP_bot/MULADD.v')
        sources.append(f'{TILES_ROOT}/DSP/DSP_top/DSP_top.v')
        sources.append(f'{TILES_ROOT}/DSP/DSP_top/DSP_top_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/DSP/DSP_top/DSP_top_switch_matrix.v')
        
        # LUT4AB
        sources.append(f'{TILES_ROOT}/LUT4AB/LUT4AB.v')
        sources.append(f'{TILES_ROOT}/LUT4AB/LUT4AB_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/LUT4AB/LUT4AB_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/LUT4AB/LUT4c_frame_config_dffesr.v')
        sources.append(f'{TILES_ROOT}/LUT4AB/MUX8LUT_frame_config_mux.v')
        
        # N_term_DSP
        sources.append(f'{TILES_ROOT}/N_term_DSP/N_term_DSP.v')
        sources.append(f'{TILES_ROOT}/N_term_DSP/N_term_DSP_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/N_term_DSP/N_term_DSP_switch_matrix.v')
        
        # N_term_single
        sources.append(f'{TILES_ROOT}/N_term_single/N_term_single.v')
        sources.append(f'{TILES_ROOT}/N_term_single/N_term_single_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/N_term_single/N_term_single_switch_matrix.v')
        
        # N_term_single2
        sources.append(f'{TILES_ROOT}/N_term_single2/N_term_single2.v')
        sources.append(f'{TILES_ROOT}/N_term_single2/N_term_single2_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/N_term_single2/N_term_single2_switch_matrix.v')

        # RegFile
        sources.append(f'{TILES_ROOT}/RegFile/RegFile.v')
        sources.append(f'{TILES_ROOT}/RegFile/RegFile_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/RegFile/RegFile_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/RegFile/RegFile_32x4.v')
        
        # S_term_DSP
        sources.append(f'{TILES_ROOT}/S_term_DSP/S_term_DSP.v')
        sources.append(f'{TILES_ROOT}/S_term_DSP/S_term_DSP_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_term_DSP/S_term_DSP_switch_matrix.v')
        
        # S_term_single
        sources.append(f'{TILES_ROOT}/S_term_single/S_term_single.v')
        sources.append(f'{TILES_ROOT}/S_term_single/S_term_single_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_term_single/S_term_single_switch_matrix.v')

        # S_term_single2
        sources.append(f'{TILES_ROOT}/S_term_single2/S_term_single2.v')
        sources.append(f'{TILES_ROOT}/S_term_single2/S_term_single2_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_term_single2/S_term_single2_switch_matrix.v')

        # N_IO
        sources.append(f'{TILES_ROOT}/N_IO/N_IO.v')
        sources.append(f'{TILES_ROOT}/N_IO/N_IO_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/N_IO/N_IO_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/N_IO/IO_1_bidirectional_frame_config_pass.v')
        sources.append(f'{TILES_ROOT}/N_IO/Config_access.v')

        # W_IO
        sources.append(f'{TILES_ROOT}/W_IO/W_IO.v')
        sources.append(f'{TILES_ROOT}/W_IO/W_IO_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/W_IO/W_IO_switch_matrix.v')
        #sources.append(f'{TILES_ROOT}/W_IO/IO_1_bidirectional_frame_config_pass.v')
        #sources.append(f'{TILES_ROOT}/W_IO/Config_access.v')
        
        # S_EF_ADC12
        sources.append(f'{TILES_ROOT}/S_EF_ADC12/S_EF_ADC12.v')
        sources.append(f'{TILES_ROOT}/S_EF_ADC12/S_EF_ADC12_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_EF_ADC12/S_EF_ADC12_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_EF_ADC12/EF_ADC12.sv')

        # S_EF_DAC8
        sources.append(f'{TILES_ROOT}/S_EF_DAC8/S_EF_DAC8.v')
        sources.append(f'{TILES_ROOT}/S_EF_DAC8/S_EF_DAC8_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_EF_DAC8/S_EF_DAC8_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_EF_DAC8/EF_DAC8.v')
        
        # S_WARMBOOT
        sources.append(f'{TILES_ROOT}/S_WARMBOOT/S_WARMBOOT.v')
        sources.append(f'{TILES_ROOT}/S_WARMBOOT/S_WARMBOOT_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_WARMBOOT/S_WARMBOOT_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_WARMBOOT/WARMBOOT.v')
        
        # S_CPU_IF
        sources.append(f'{TILES_ROOT}/S_CPU_IF/S_CPU_IF.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IF/S_CPU_IF_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IF/S_CPU_IF_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IF/CPU_IF.v')

        # S_CPU_IRQ
        sources.append(f'{TILES_ROOT}/S_CPU_IRQ/S_CPU_IRQ.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IRQ/S_CPU_IRQ_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IRQ/S_CPU_IRQ_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/S_CPU_IRQ/CPU_IRQ.v')

        # EF_SRAM
        sources.append(f'{TILES_ROOT}/EF_SRAM/EF_SRAM.v')
        sources.append(f'{TILES_ROOT}/EF_SRAM/EF_SRAM_bot/EF_SRAM_bot.v')
        sources.append(f'{TILES_ROOT}/EF_SRAM/EF_SRAM_bot/EF_SRAM_bot_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/EF_SRAM/EF_SRAM_bot/EF_SRAM_bot_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/EF_SRAM/EF_SRAM_bot/EF_SRAM_1024x32v2.v') # TODO
        sources.append(f'{TILES_ROOT}/EF_SRAM/EF_SRAM_top/EF_SRAM_top.v')
        sources.append(f'{TILES_ROOT}/EF_SRAM/EF_SRAM_top/EF_SRAM_top_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/EF_SRAM/EF_SRAM_top/EF_SRAM_top_switch_matrix.v')

        # N_term_EF_SRAM
        sources.append(f'{TILES_ROOT}/N_term_EF_SRAM/N_term_EF_SRAM.v')
        sources.append(f'{TILES_ROOT}/N_term_EF_SRAM/N_term_EF_SRAM_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/N_term_EF_SRAM/N_term_EF_SRAM_switch_matrix.v')

        # S_term_EF_SRAM
        sources.append(f'{TILES_ROOT}/S_term_EF_SRAM/S_term_EF_SRAM.v')
        sources.append(f'{TILES_ROOT}/S_term_EF_SRAM/S_term_EF_SRAM_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_term_EF_SRAM/S_term_EF_SRAM_switch_matrix.v')

        sources.append('../../fabulous_tiles/models_pack.v')

    hdl_toplevel = "tb"

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=hdl_toplevel,
        defines={'COCOTB': True, 'FUNCTIONAL': True, 'UNIT_DELAY': '#0'},
        always=True,
    )

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module="tb_cocotb,",
        plusargs=['-fst'],
        waves=True
    )
