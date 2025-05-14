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

NumColumns = 14
NumRows = 18

BITSTREAM_START = 0xFAB0FAB1
DESYNC_FLAG = 20

FABRIC_NUM_IO = 64

run_all_zeros   = True
run_all_ones    = True
run_counter     = True
run_passthrough = True
run_sram        = True
run_adc_dac     = True

def set_fabric_io(dut, value):
    value = value & 0xFFFFFFFFFFFFFFFF
    dut.io_west_in_i.value = value

def get_fabric_io(dut):
    value = dut.io_west_out_o.value
    return value

async def reset_design(dut):
    dut.rst_ni.value = 0
    await ClockCycles(dut.clk_i, 10)
    dut.rst_ni.value = 1

async def set_defaults(dut):
    dut.bitstream_data_i.value = 0
    dut.bitstream_valid_i.value = 0
    
    dut.io_west_in_i.value = 0
    
    dut.adc0_cmp_i.value = 0
    
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
    c = Clock(dut.clk_i, 20, 'ns')
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
    c = Clock(dut.clk_i, 20, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'all_zeros')
    
    values = [random.randint(0,(1<<FABRIC_NUM_IO)-1) for _ in range(10)]
    
    for value in values:
        set_fabric_io(dut, value)
        await ClockCycles(dut.clk_i, 1)
        assert(get_fabric_io(dut) == 0)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_all_ones==False)
async def test_all_ones(dut):
    """Load bitstream to set output to ones"""

    # Start the clock
    c = Clock(dut.clk_i, 20, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'all_ones')

    values = [random.randint(0,(1<<FABRIC_NUM_IO)-1) for _ in range(10)]
    
    for value in values:
        set_fabric_io(dut, value)
        await ClockCycles(dut.clk_i, 1)
        assert(get_fabric_io(dut) == (1<<FABRIC_NUM_IO)-1)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_counter==False)
async def test_counter(dut):
    """Load bitstream for counter"""

    # Start the clock
    c = Clock(dut.clk_i, 20, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'counter')
    
    set_fabric_io(dut, 1)
    await ClockCycles(dut.clk_i, 5)
    set_fabric_io(dut, 0)
    
    MAX_CNT = 30
    
    await ClockCycles(dut.clk_i, MAX_CNT)
    assert(get_fabric_io(dut) == MAX_CNT-1)

@cocotb.test(skip=run_passthrough==False)
async def test_passthrough(dut):
    """Load bitstream for test_passthrough"""

    # Start the clock
    c = Clock(dut.clk_i, 20, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")

    await upload_bitstream(dut, 'passthrough')
    
    values = [random.randint(0,(1<<FABRIC_NUM_IO)-1) for _ in range(10)]
    
    for value in values:
        set_fabric_io(dut, value)
        await ClockCycles(dut.clk_i, 1)
        assert(get_fabric_io(dut) == value)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_sram==False)
async def test_sram(dut):
    """Load bitstream for test_sram"""

    # Start the clock
    c = Clock(dut.clk_i, 20, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")

    await upload_bitstream(dut, 'sram')
    
    # 16 words of data
    sram_data = [random.randint(0,(1<<32)-1) for i in range(16)]
    
    # Write all words
    for i, data in enumerate(sram_data):
    
        # Select port 0 for write
        csb_a = 0
        web_a = 0
        wmask_a = 0xF
        addr_a = i
        din_a = data
        
        # Don't use port 1
        csb_b = 1
        addr_b = 0
        
        io_in = (addr_b<<47) | (csb_b<<46) | (din_a<<14) | (addr_a<<6) | (wmask_a<<2) | (web_a<<1) | csb_a
        
        # Set io
        set_fabric_io(dut, io_in)
        
        await ClockCycles(dut.clk_i, 1)
    
    # Read all words with port 0
    for i, data in enumerate(sram_data):
        # Select port 0 for read
        csb_a = 0
        web_a = 1
        wmask_a = 0xF
        addr_a = i
        din_a = 0
        
        # Don't use port 1
        csb_b = 1
        addr_b = 42
        
        io_in = (addr_b<<47) | (csb_b<<46) | (din_a<<14) | (addr_a<<6) | (wmask_a<<2) | (web_a<<1) | csb_a
        
        # Set io
        set_fabric_io(dut, io_in)
        
        await ClockCycles(dut.clk_i, 2)
        
        print(dut.io_west_out_o.value)
        
        print(dut.io_west_out_o.value[0:31])
        print(dut.io_west_out_o.value[32:63])

        assert(dut.io_west_out_o.value[32:63].integer == data)

    # Read all words with port 1
    for i, data in enumerate(sram_data):
        # Don't use port 0
        csb_a = 1
        web_a = 1
        wmask_a = 0xF
        addr_a = 42
        din_a = 0
        
        # Select port 1 for read
        csb_b = 0
        addr_b = i
        
        io_in = (addr_b<<47) | (csb_b<<46) | (din_a<<14) | (addr_a<<6) | (wmask_a<<2) | (web_a<<1) | csb_a
        
        # Set io
        set_fabric_io(dut, io_in)
        
        await ClockCycles(dut.clk_i, 2)
        
        assert(dut.io_west_out_o.value[0:31].integer == data)
    
    await ClockCycles(dut.clk_i, 10)

@cocotb.test(skip=run_adc_dac==False)
async def test_adc_dac(dut):
    """Load bitstream for adc_dac"""

    # Start the clock
    c = Clock(dut.clk_i, 20, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    await set_defaults(dut)
    await reset_design(dut)
    dut._log.info("Reset done")
    
    await upload_bitstream(dut, 'adc_dac')
    
    dut.adc0_cmp_i.value = 1
    await ClockCycles(dut.clk_i, 50)
    
    dut.adc0_cmp_i.value = 0
    await ClockCycles(dut.clk_i, 50)

async def write_reg(dut, addr, data, be=0xF):
    dut.req_i.value = 1
    dut.we_i.value = 1
    dut.be_i.value = be
    dut.addr_i.value = addr
    dut.wdata_i.value = data
    
    while 1:
        await ClockCycles(dut.clk_i, 1)
        if dut.gnt_o.value == 1 and dut.rvalid_o.value == 1:
            dut.req_i.value = 0
            dut.we_i.value = 0
            dut.be_i.value = 0
            dut.addr_i.value = 0
            dut.wdata_i.value = 0
            await ClockCycles(dut.clk_i, 1)
            return

async def read_reg(dut, addr):
    dut.req_i.value = 1
    dut.we_i.value = 0
    dut.be_i.value = 0
    dut.addr_i.value = addr
    dut.wdata_i.value = 0

    while 1:
        await ClockCycles(dut.clk_i, 1)
        if dut.gnt_o.value == 1 and dut.rvalid_o.value == 1:
            rdata = dut.rdata_o.value
            dut.req_i.value = 0
            dut.we_i.value = 0
            dut.be_i.value = 0
            dut.addr_i.value = 0
            dut.wdata_i.value = 0
            await ClockCycles(dut.clk_i, 1)
            return rdata

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
        'tb_icarus.sv',
        
        # SRAM models
        Path(pdk_root).expanduser() / pdk / "libs.ref" / "sky130_sram_macros" / "verilog" / "sky130_sram_1kbyte_1rw1r_32x256_8.v",
    ]

    if gl:
        # GL does not work because of pessimistic x-propagation!
        sources.append(f'../macro/{pdk}/nl/eFPGA.nl.v')
        sources.append(Path(pdk_root).expanduser() / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v" )
        sources.append(Path(pdk_root).expanduser() / pdk / "libs.ref" / scl / "verilog" / "primitives.v" )
        
        sources.append(f'{TILES_ROOT}/DSP/macro/{pdk}/nl/DSP.nl.v')
        sources.append(f'{TILES_ROOT}/OpenRAM/macro/{pdk}/nl/OpenRAM.nl.v')
        sources.append(f'{TILES_ROOT}/SimpleCLB/macro/{pdk}/nl/SimpleCLB.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_DSP/macro/{pdk}/nl/N_term_DSP.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_IHP_SRAM/macro/{pdk}/nl/N_term_IHP_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_single/macro/{pdk}/nl/N_term_single.nl.v')
        sources.append(f'{TILES_ROOT}/N_term_single2/macro/{pdk}/nl/N_term_single2.nl.v')
        sources.append(f'{TILES_ROOT}/RegFile/macro/{pdk}/nl/RegFile.nl.v')
        sources.append(f'{TILES_ROOT}/S_WARMBOOT/macro/{pdk}/nl/S_WARMBOOT.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_DSP/macro/{pdk}/nl/S_term_DSP.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_IHP_SRAM/macro/{pdk}/nl/S_term_IHP_SRAM.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_single/macro/{pdk}/nl/S_term_single.nl.v')
        sources.append(f'{TILES_ROOT}/S_term_single2/macro/{pdk}/nl/S_term_single2.nl.v')
        sources.append(f'{TILES_ROOT}/W_IO4/macro/{pdk}/nl/W_IO4.nl.v')
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
        
        # SimpleCLB
        sources.append(f'{TILES_ROOT}/SimpleCLB/SimpleCLB.v')
        sources.append(f'{TILES_ROOT}/SimpleCLB/SimpleCLB_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/SimpleCLB/SimpleCLB_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/SimpleCLB/LUT4c_frame_config_dffesr.v')
        
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

        # W_IO4
        sources.append(f'{TILES_ROOT}/W_IO4/W_IO4.v')
        sources.append(f'{TILES_ROOT}/W_IO4/W_IO4_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/W_IO4/W_IO4_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/W_IO4/IO_1_bidirectional_frame_config_pass.v')
        sources.append(f'{TILES_ROOT}/W_IO4/Config_access.v')
        
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

        # OpenRAM
        sources.append(f'{TILES_ROOT}/OpenRAM/OpenRAM.v')
        sources.append(f'{TILES_ROOT}/OpenRAM/OpenRAM_bot/OpenRAM_bot.v')
        sources.append(f'{TILES_ROOT}/OpenRAM/OpenRAM_bot/OpenRAM_bot_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/OpenRAM/OpenRAM_bot/OpenRAM_bot_switch_matrix.v')
        sources.append(f'{TILES_ROOT}/OpenRAM/OpenRAM_bot/OPENRAM_256x32_1RW1R.v')
        sources.append(f'{TILES_ROOT}/OpenRAM/OpenRAM_top/OpenRAM_top.v')
        sources.append(f'{TILES_ROOT}/OpenRAM/OpenRAM_top/OpenRAM_top_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/OpenRAM/OpenRAM_top/OpenRAM_top_switch_matrix.v')

        # N_term_OpenRAM
        sources.append(f'{TILES_ROOT}/N_term_OpenRAM/N_term_OpenRAM.v')
        sources.append(f'{TILES_ROOT}/N_term_OpenRAM/N_term_OpenRAM_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/N_term_OpenRAM/N_term_OpenRAM_switch_matrix.v')

        # S_term_OpenRAM
        sources.append(f'{TILES_ROOT}/S_term_OpenRAM/S_term_OpenRAM.v')
        sources.append(f'{TILES_ROOT}/S_term_OpenRAM/S_term_OpenRAM_ConfigMem.v')
        sources.append(f'{TILES_ROOT}/S_term_OpenRAM/S_term_OpenRAM_switch_matrix.v')

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
