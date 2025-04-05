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

# Simple test config
# bitstream is 10 words long
# a slot is 16 words
# there are 16 slots

BITSTREAM_LENGTH_WORDS = 10
SLOT_OFFSET_WORDS      = 16
NUM_SLOTS              = 16

recv_data = []

async def monitor(dut):
    global recv_data
    
    while 1:
        await RisingEdge(dut.bitstream_valid_o)
        recv_data.append(dut.bitstream_data_o.value.integer)

@cocotb.test(skip=False)
async def test_default(dut):
    """Load data from different slots"""

    # Load data file
    data = []
    
    with open('../data.hex', 'r') as f:
        for i in range(SLOT_OFFSET_WORDS*NUM_SLOTS):
            hexstr = ''
            for j in range(4):
                hexstr += f.readline().rstrip()
            num = int(hexstr, 16)
            data.append(num)

    await cocotb.start(monitor(dut))

    # Start the clock
    c = Clock(dut.clk_i, 10, 'ns')
    await cocotb.start(c.start())

    # Assign default values
    
    dut.start_i.value = 0
    dut.slot_i.value = 0
    
    # Reset
    dut.rst_ni.value = 0
    await ClockCycles(dut.clk_i, 10)
    dut.rst_ni.value = 1
    dut._log.info("Reset done")
    
    await ClockCycles(dut.clk_i, 10)
    
    # Perform 20 slot reads
    slots = [random.randint(0, 15) for i in range(20)]

    for slot in slots:

        dut.start_i.value = 1
        dut.slot_i.value = slot
        await ClockCycles(dut.clk_i, 1)
        dut.start_i.value = 0
    
        await ClockCycles(dut.clk_i, 1000)
    
    global recv_data
    print(f'Received: {recv_data}')
    
    # Compare with expected data
    compare_data = []
    for slot in slots:
        # Get slot data
        compare_data += data[slot*SLOT_OFFSET_WORDS:slot*SLOT_OFFSET_WORDS+BITSTREAM_LENGTH_WORDS]

    assert (len(compare_data) == len(recv_data))
    
    for a, b in zip(compare_data, recv_data):
        assert (a == b)

if __name__ == "__main__":
    sim = os.getenv("SIM", "icarus")
    
    random.seed()
    
    # Write data file
    with open('data.hex', 'w') as f:
        for i in range(SLOT_OFFSET_WORDS*NUM_SLOTS*4):
            f.write(f'{random.randint(0, 255):0>2x}\n')

    proj_path = Path(__file__).resolve().parent
    
    sources = [
        '../rtl/fabric_spi_controller.sv',
        'fabric_spi_controller_tb.sv',
        'spiflash.v',
    ]

    hdl_toplevel = "fabric_spi_controller_tb"

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=hdl_toplevel,
        always=True,
    )

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module="fabric_spi_controller_tb,",
        plusargs=['-fst', f'+firmware=../data.hex'],
        waves=True
    )
