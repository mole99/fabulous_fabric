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

from cocotbext.spi import SpiBus, SpiConfig, SpiMaster

random.seed()

recv_data = []

async def monitor(dut):
    global recv_data
    
    while 1:
        await RisingEdge(dut.bitstream_valid_o)
        recv_data.append(dut.bitstream_data_o.value.integer)

@cocotb.test(skip=False)
async def test_default(dut):
    """Write data via SPI"""

    # SPI
    spi_bus = SpiBus.from_prefix(dut, "")

    spi_config = SpiConfig(
        word_width = 8,
        sclk_freq  = 2e6,
        cpol       = False,
        cpha       = True,
        msb_first  = True,
        frame_spacing_ns = 500
    )

    spi_master = SpiMaster(spi_bus, spi_config)

    await cocotb.start(monitor(dut))

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())
    
    # Reset
    dut.rst_ni.value = 0
    await ClockCycles(dut.clk_i, 10)
    dut.rst_ni.value = 1
    dut._log.info("Reset done")
    
    await ClockCycles(dut.clk_i, 10)
    
    data = [random.randint(0, 2**32-1) for _ in range(100)]
    
    print(f'Sending: {data}')
    
    for word in data:
        print(f'Writing: {word}')
        for _ in range(4):
            byte = word >> 24 & 0xFF
            await spi_master.write([byte])
            word = word << 8 & 0xFFFFFFFF

    await ClockCycles(dut.clk_i, 10)
    
    global recv_data
    print(f'Received: {recv_data}')
    
    assert (len(data) == len(recv_data))
    
    for a, b in zip(data, recv_data):
        assert (a == b)

if __name__ == "__main__":
    sim = os.getenv("SIM", "icarus")

    proj_path = Path(__file__).resolve().parent
    
    sources = [
        '../rtl/fabric_spi_receiver.sv',
        'fabric_spi_receiver_tb.sv',
    ]

    hdl_toplevel = "fabric_spi_receiver_tb"

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=hdl_toplevel,
        always=True,
    )

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module="fabric_spi_receiver_tb,",
        plusargs=['-fst'],
        waves=True
    )
